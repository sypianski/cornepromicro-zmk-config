# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **keyboard configuration repository** for two Corne split keyboards:

| Keyboard | Keys | Firmware | Connection | Config Location |
|----------|------|----------|------------|-----------------|
| **Corne 42** | 42 | ZMK | Bluetooth | `config/corne.keymap` |
| **Corne 46** | 46 | Vial/QMK | USB | `vial/*.vil` |

Both keyboards use **Colemak** layout with **homerow mods**:
```
A=Ctrl  R=Alt  S=GUI  T=Shift  |  N=Shift  E=GUI  I=Alt  O=Ctrl
```

**Platform variants:**
- `corne.android.keymap` - Android (CAGS: Ctrl-Alt-GUI-Shift on homerow)
- `corne.macos.keymap` - macOS (GACS: GUI-Alt-Ctrl-Shift on homerow)

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
| 4 | Fn | (reserved) | Function keys F1-F24 |
| 5 | BT | Z+X sticky / BSPC hold | Bluetooth + Media controls |
| 6 | Dead | C+V sticky | Dead keys (macron, circumflex, etc.) |

**Thumb cluster:**
```
RALT | SPACE | TAB/L1 | ENT/L2 | BSPC/L5 | RALT
```

## Layer 3: Diacritics Map

Hold RALT (right thumb) + key:
```
Q=ʿ   W=ʾ   F=š   P=ā   G=ḡ     J=ǧ   L=ł   U=ū   Y=ī   ;=è
A=ą   R=ṣ   S=ś   T=ṭ   D=ḍ     H=ḥ   N=ń   E=ę   I=ı   O=ó
Z=ż   X=ź   C=ć   V=ẓ   B=·     K=•   M=ṯ   ,=à   .=ò   /=ù
```

**Polish:** ą ć ę ł ń ó ś ź ż
**Arabic ISO 233:** ʿ ʾ ḍ š ḡ ḥ ǧ ṣ ṭ ẓ ṯ ā ī ū
**Italian:** à è ò ù

## Layer 6: Dead Keys Map

Press C+V combo, then dead key on home row:
```
Left hand (A R S T):
A = Macron ¯    (ā ē ī ō ū)
R = Circumflex ^ (â ê î ô û)
S = Umlaut ¨    (ä ë ï ö ü)
T = Caron ˇ     (č š ž ř)

Right hand (N E I):
N = Breve ˘     (ğ ŭ ă)
E = Acute ´     (á é í ó ú)
I = Cedilla ¸   (ç ş)
```

## Key Relationships

**Diacritics flow (Android):**
```
Layer 3 + key → sends RALT(x) → EKH app → outputs ą/ę/ó etc.
```
Requires External Keyboard Helper (EKH) configured with RALT+key mappings.

**Dead keys flow:**
```
C+V combo → Layer 6 (sticky) → press dead key (e.g. A for macron) →
layer deactivates → type base letter (e.g. e) → EKH outputs ē
```

**Diacritics flow (macOS):**
```
Layer 3 + key → sends RALT(x) → keylayout → outputs ą/ę/ó etc.
```
- Keylayout must have `group="0"` (ANSI, not Unicode)
- Keylayout must define codes 36, 48, 51, 53, 117 in all keyMaps

## EKH Setup (Android)

Configure these RALT+key mappings in External Keyboard Helper:

**Polish:** RALT+A→ą, RALT+C→ć, RALT+E→ę, RALT+L→ł, RALT+N→ń, RALT+O→ó, RALT+S→ś, RALT+X→ź, RALT+Z→ż

**Dead keys:** RALT+6→macron, RALT+7→circumflex, RALT+8→umlaut, RALT+9→caron, RALT+0→breve, RALT+minus→acute, RALT+equal→cedilla

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
- `G + J` (5 + 6): Caps Lock
- `Q + W` (1 + 2): Backspace
- `U + Y` (8 + 9): Enter
- `E + R` (20 + 14): Delete
- `Z + X` (25 + 26): Layer 5 (Bluetooth) - sticky
- `C + V` (27 + 28): Layer 6 (Dead keys) - sticky
- Corner keys (0 + 11): Bootloader mode

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
