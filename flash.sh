#!/bin/bash
# Flash ZMK firmware to Corne keyboard halves
# Usage: ./flash.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="sypianski/cornepromicro-zmk-config"
ARTIFACT_NAME="firmware"
TEMP_DIR="/tmp/zmk-firmware"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log() { echo -e "${GREEN}[*]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

# Check gh authentication
if ! gh auth status &>/dev/null; then
    error "Not authenticated. Run: gh auth login"
fi

log "Target platform: Android"

# Get the latest successful workflow run with commit info
log "Finding latest successful workflow run..."
RUN_INFO=$(gh run list --repo "$REPO" --status success --limit 1 --json databaseId,headSha,displayTitle)
RUN_ID=$(echo "$RUN_INFO" | jq -r '.[0].databaseId')
RUN_SHA=$(echo "$RUN_INFO" | jq -r '.[0].headSha')
RUN_TITLE=$(echo "$RUN_INFO" | jq -r '.[0].displayTitle')

if [ -z "$RUN_ID" ]; then
    error "No workflow run found"
fi

# Get local HEAD for comparison
LOCAL_SHA=$(git rev-parse HEAD)

log "Using workflow run: $RUN_ID"
log "Build commit: ${RUN_SHA:0:7} - $RUN_TITLE"

# Warn if build doesn't match local HEAD
if [ "${RUN_SHA:0:7}" != "${LOCAL_SHA:0:7}" ]; then
    warn "Build commit (${RUN_SHA:0:7}) differs from local HEAD (${LOCAL_SHA:0:7})"
    warn "The build may be outdated. Wait for new build or check GitHub Actions."
    read -p "Continue anyway? [y/N]: " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        error "Aborted"
    fi
fi

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
        for path in /Volumes/NICENANO /Volumes/NICENANO* /media/$USER/NICENANO* /run/media/$USER/NICENANO* /mnt/NICENANO*; do
            if [ -d "$path" ] && [ -f "$path/INFO_UF2.TXT" ]; then
                mount_point="$path"
                break
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
    sleep 2
    local wait_count=0
    while [ -d "$mount_point" ] && [ $wait_count -lt 10 ]; do
        sleep 1
        ((wait_count++))
    done
    log "$side half flashed successfully!"
}

# Flash both halves
flash_half "$LEFT_UF2" "LEFT"

echo ""
log "Left half done. Waiting 5 seconds before looking for right half..."
sleep 5

flash_half "$RIGHT_UF2" "RIGHT"

echo ""
log "Both halves flashed! Firmware update complete."
