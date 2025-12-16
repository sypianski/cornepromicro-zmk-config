# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **keyboard configuration repository** for two Corne split keyboards:

| Keyboard | Keys | Firmware | Connection | Config Location |
|----------|------|----------|------------|-----------------|
| **Corne 42** | 42 | ZMK | Bluetooth | `config/corne.keymap` |
| **Corne 46** | 46 | Vial/QMK | USB | `vial/*.vil` |

Both keyboards use **Colemak** layout with **homerow mods**.

**Platform variants:**
- `corne.android.keymap` - Android (CAGS: Ctrl primary, GUI secondary)
- `corne.macos.keymap` - macOS (GACS: GUI primary, Ctrl secondary)

## Architecture

```
klavari/
├── config/                  # ZMK keymap files (Corne 42)
│   ├── corne.keymap         # Active keymap (synced to GitHub)
│   ├── corne.android.keymap # Android variant (Ctrl primary)
│   ├── corne.macos.keymap   # macOS variant (Cmd primary)
│   └── corne.conf           # ZMK settings (BT power, sleep, debounce)
├── vial/                    # Vial config files (Corne 46)
│   └── v16-faster-tapping.vil
├── ukulelo/                 # macOS keylayout files
│   └── PolishProgrammerPlus-v15.keylayout
├── firmware/                # Downloaded .uf2 files (for flashing)
├── build.yaml               # GitHub Actions build matrix
└── flash.sh                 # Firmware download & flash script
```

## Layer Structure (Android keymap)

| Layer | Name | Access | Content |
|-------|------|--------|---------|
| 0 | Base | - | Colemak + homerow mods |
| 1 | Num | TAB hold | Numbers + navigation |
| 2 | Sym | ENTER hold | Symbols |
| 3 | Dia | RALT hold | Diacritics (RALT+key) |
| 4 | Fn | BSPC hold | Function keys F1-F24 |
| 5 | BT | Z+X combo | Bluetooth controls |
| 6 | Dead | TBD | Dead keys (macron, circumflex, etc.) |

**Thumb cluster:**
```
LALT | SPACE | TAB/L1 | ENT/L2 | BSPC/L4 | RALT/L3
```

## Key Relationships

**Diacritics flow (Android):**
```
Layer 3 + key → sends RALT(x) → EKH app → outputs ą/ę/ó etc.
```
Requires External Keyboard Helper (EKH) configured with RALT+key mappings.

**Diacritics flow (macOS):**
```
Layer 3 + key → sends RALT(x) → keylayout → outputs ą/ę/ó etc.
```
- Keylayout must have `group="0"` (ANSI, not Unicode)
- Keylayout must define codes 36, 48, 51, 53, 117 in all keyMaps

## Common Commands

### Build & Flash ZMK (Corne 42)

```bash
# Automatic: downloads firmware, flashes both halves
./flash.sh

# Manual download from GitHub Actions
gh run download <RUN_ID> --repo sypianski/cornepromicro-zmk-config --name firmware

# Flash to bootloader (double-tap reset on keyboard)
cp firmware/corne_left-nice_nano-zmk.uf2 /Volumes/NICENANO/
cp firmware/corne_right-nice_nano-zmk.uf2 /Volumes/NICENANO/

# Reset Bluetooth pairing (flash to BOTH halves first, then reflash normal firmware)
cp firmware/settings_reset-nice_nano-zmk.uf2 /Volumes/NICENANO/
```

### Keymap Changes

```bash
# Edit the active keymap
vim config/corne.keymap

# Commit and push to trigger GitHub Actions build
git add config/corne.keymap && git commit -m "Update keymap" && git push

# Monitor build status
gh run list --repo sypianski/cornepromicro-zmk-config --limit 1
```

### Platform Switching (Android/macOS)

The `flash.sh` script handles this automatically, or manually:
```bash
cp config/corne.android.keymap config/corne.keymap  # Android (Ctrl primary)
cp config/corne.macos.keymap config/corne.keymap    # macOS (Cmd primary)
```

## ZMK Keymap Structure

Key positions for combos (42-key Corne):
```
Row 0:  0  1  2  3  4  5  |  6  7  8  9 10 11
Row 1: 12 13 14 15 16 17  | 18 19 20 21 22 23
Row 2: 24 25 26 27 28 29  | 30 31 32 33 34 35
Thumb:       36 37 38     | 39 40 41
```

Important combos:
- `T + N` (16 + 19): Caps Word
- `LSHIFT + RSHIFT` (24 + 35): Caps Lock
- `G + J` (5 + 6): Bootloader mode
- `Q + W` (1 + 2): Delete
- `Z + X` (25 + 26): Layer 5 (Bluetooth)

## Troubleshooting

### Bluetooth not detected (Corne 42)
1. Flash `settings_reset-nice_nano-zmk.uf2` to **both** halves
2. Re-flash normal firmware
3. Re-pair in device Bluetooth settings

### Diacritics not working (Corne 46)
- Check Polish Programmer Plus is active Input Source on macOS
- Layer 3 must send `LALT(KC_x)`, not `LSA(KC_x)`
- Use thumb key for Layer 3, not homerow Alt (TD conflicts)

### Bootloader won't mount
- Try different USB cable (data, not charge-only)
- Different double-reset timing (faster/slower)
- Hold reset before plugging USB, then release and tap again

## Subdirectory Documentation

- `vial/CLAUDE.md` - Detailed Vial/QMK configuration for Corne 46
- `ukulelo/CLAUDE.md` - macOS keylayout documentation
