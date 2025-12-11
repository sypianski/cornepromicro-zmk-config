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

# Platform selection menu
echo ""
echo -e "${BOLD}Select target platform:${NC}"
echo -e "  ${BLUE}1)${NC} Android  (Ctrl primary)"
echo -e "  ${BLUE}2)${NC} macOS    (Cmd primary)"
echo ""
read -p "Choice [1/2]: " choice

case "$choice" in
    1|a|android)
        PLATFORM="android"
        KEYMAP_FILE="$SCRIPT_DIR/config/corne.android.keymap"
        ;;
    2|m|macos)
        PLATFORM="macos"
        KEYMAP_FILE="$SCRIPT_DIR/config/corne.macos.keymap"
        ;;
    *)
        error "Invalid choice"
        ;;
esac

log "Selected platform: $PLATFORM"

# Check if keymap needs updating
if ! diff -q "$KEYMAP_FILE" "$SCRIPT_DIR/config/corne.keymap" &>/dev/null; then
    log "Updating keymap to $PLATFORM version..."
    cp "$KEYMAP_FILE" "$SCRIPT_DIR/config/corne.keymap"

    # Commit and push
    cd "$SCRIPT_DIR"
    git add config/corne.keymap
    git commit -m "Switch to $PLATFORM keymap"
    git push

    log "Pushed to GitHub. Waiting for build..."
    sleep 5

    # Wait for the new run to start
    log "Waiting for workflow to complete..."
    while true; do
        STATUS=$(gh run list --repo "$REPO" --limit 1 --json status --jq '.[0].status')
        if [ "$STATUS" = "completed" ]; then
            break
        fi
        printf "\r${YELLOW}[!]${NC} Build status: $STATUS "
        sleep 10
    done
    echo ""

    RESULT=$(gh run list --repo "$REPO" --limit 1 --json conclusion --jq '.[0].conclusion')
    if [ "$RESULT" != "success" ]; then
        error "Build failed: $RESULT"
    fi
    log "Build completed successfully!"
fi

# Get the latest successful workflow run
log "Finding latest successful workflow run..."
RUN_ID=$(gh run list --repo "$REPO" --status success --json databaseId --jq '.[0].databaseId')

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
