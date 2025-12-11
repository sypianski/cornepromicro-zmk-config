#!/bin/bash
# Generate macOS and Android keymap variants from template
# Usage: ./generate-keymaps.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="$SCRIPT_DIR/config/corne.keymap.template"
OUTPUT_DIR="$SCRIPT_DIR/config"

if [[ ! -f "$TEMPLATE" ]]; then
    echo "Error: Template not found at $TEMPLATE"
    exit 1
fi

# Generate macOS version
# macOS: GUI (Cmd) is primary modifier for shortcuts
# Homerow: A=GUI, S=Ctrl (standard Mac layout)
echo "Generating macOS keymap..."
sed -e 's/{{TARGET}}/macos/g' \
    -e 's/{{TARGET_DESC}}/GUI is primary, Ctrl is secondary/g' \
    -e 's/{{CORNER_L1}}/LCTRL/g' \
    -e 's/{{CORNER_L2}}/LGUI/g' \
    -e 's/{{PRIMARY}}/GUI/g' \
    -e 's/{{SECONDARY}}/CTRL/g' \
    -e 's/{{L_PRIMARY}}/LGUI/g' \
    -e 's/{{L_SECONDARY}}/LCTRL/g' \
    -e 's/{{R_PRIMARY}}/RGUI/g' \
    -e 's/{{R_SECONDARY}}/RCTRL/g' \
    -e 's/{{NAV_MOD}}/LG/g' \
    "$TEMPLATE" > "$OUTPUT_DIR/corne.macos.keymap"
echo "  -> $OUTPUT_DIR/corne.macos.keymap"

# Generate Android version
# Android: Ctrl is primary modifier for shortcuts (like Windows/Linux)
# Homerow: A=Ctrl, S=GUI (swapped for Android shortcuts)
echo "Generating Android keymap..."
sed -e 's/{{TARGET}}/android/g' \
    -e 's/{{TARGET_DESC}}/Ctrl is primary, GUI is secondary/g' \
    -e 's/{{CORNER_L1}}/LGUI/g' \
    -e 's/{{CORNER_L2}}/LCTRL/g' \
    -e 's/{{PRIMARY}}/CTRL/g' \
    -e 's/{{SECONDARY}}/GUI/g' \
    -e 's/{{L_PRIMARY}}/LCTRL/g' \
    -e 's/{{L_SECONDARY}}/LGUI/g' \
    -e 's/{{R_PRIMARY}}/RCTRL/g' \
    -e 's/{{R_SECONDARY}}/RGUI/g' \
    -e 's/{{NAV_MOD}}/LC/g' \
    "$TEMPLATE" > "$OUTPUT_DIR/corne.android.keymap"
echo "  -> $OUTPUT_DIR/corne.android.keymap"

echo ""
echo "Done! To use a keymap:"
echo "  cp config/corne.macos.keymap config/corne.keymap"
echo "  # or"
echo "  cp config/corne.android.keymap config/corne.keymap"
echo ""
echo "Then commit and push to trigger GitHub Actions build."
