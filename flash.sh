#!/bin/bash
# Flash ZMK firmware to Corne keyboard halves
# Usage: ./flash.sh [commit_sha]

REPO="sypianski/cornepromicro-zmk-config"
ARTIFACT_NAME="firmware"
TEMP_DIR="/tmp/zmk-firmware"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[*]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

# Check gh authentication
if ! gh auth status &>/dev/null; then
    error "Not authenticated. Run: gh auth login"
fi

# Get the workflow run (from commit or latest)
if [ -n "$1" ]; then
    log "Finding workflow run for commit $1..."
    RUN_ID=$(gh run list --repo "$REPO" --commit "$1" --json databaseId --jq '.[0].databaseId')
else
    log "Finding latest successful workflow run..."
    RUN_ID=$(gh run list --repo "$REPO" --status success --json databaseId --jq '.[0].databaseId')
fi

if [ -z "$RUN_ID" ]; then
    error "No workflow run found"
fi

log "Using workflow run: $RUN_ID"

# Download artifacts
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

log "Downloading firmware artifacts..."
gh run download "$RUN_ID" --repo "$REPO" --name "$ARTIFACT_NAME" 2>/dev/null || \
gh run download "$RUN_ID" --repo "$REPO" 2>/dev/null || \
error "Failed to download artifacts"

# Find UF2 files
LEFT_UF2=$(find . -name "*left*.uf2" | head -1)
RIGHT_UF2=$(find . -name "*right*.uf2" | head -1)

if [ -z "$LEFT_UF2" ] && [ -z "$RIGHT_UF2" ]; then
    # Try alternate naming
    LEFT_UF2=$(find . -name "*corne_left*.uf2" | head -1)
    RIGHT_UF2=$(find . -name "*corne_right*.uf2" | head -1)
fi

# List what we found
log "Found firmware files:"
find . -name "*.uf2" -exec echo "  {}" \;

if [ -z "$LEFT_UF2" ] || [ -z "$RIGHT_UF2" ]; then
    warn "Could not identify left/right. Please flash manually from: $TEMP_DIR"
    exit 0
fi

log "Left:  $LEFT_UF2"
log "Right: $RIGHT_UF2"

# Function to wait for bootloader and flash
flash_half() {
    local uf2_file="$1"
    local side="$2"

    echo ""
    warn "Put $side half into bootloader mode (double-tap reset or G+J combo)"
    log "Waiting for bootloader device..."

    # Wait for a new mass storage device
    local mount_point=""
    local timeout=60
    local count=0

    while [ -z "$mount_point" ] && [ $count -lt $timeout ]; do
        # Check common mount points for nice!nano bootloader (Linux + macOS)
        for path in /Volumes/* /media/$USER/* /run/media/$USER/* /mnt/*; do
            if [ -d "$path" ]; then
                # nice!nano shows as NICENANO or has INFO_UF2.TXT
                if [[ "$(basename "$path")" == *NICENANO* ]] || [ -f "$path/INFO_UF2.TXT" ]; then
                    mount_point="$path"
                    break
                fi
            fi
        done

        if [ -z "$mount_point" ]; then
            sleep 1
            ((count++))
            printf "\r${YELLOW}[!]${NC} Waiting... %ds " "$count"
        fi
    done

    echo ""

    if [ -z "$mount_point" ]; then
        error "Timeout waiting for bootloader device"
    fi

    log "Found bootloader at: $mount_point"
    log "Flashing $side half..."

    # Use -X on macOS to skip extended attributes (avoids FAT32 warnings)
    if cp -X "$uf2_file" "$mount_point/" 2>/dev/null || cp "$uf2_file" "$mount_point/" 2>/dev/null; then
        log "File copied, waiting for device to reboot..."
    else
        warn "Copy had warnings, but may have succeeded"
    fi

    # Wait for device to disconnect (indicates successful flash)
    sleep 3
    while [ -d "$mount_point" ]; do
        sleep 1
    done
    log "$side half flashed successfully!"
}

# Flash both halves
flash_half "$LEFT_UF2" "LEFT"
flash_half "$RIGHT_UF2" "RIGHT"

echo ""
log "Both halves flashed! Firmware update complete."
