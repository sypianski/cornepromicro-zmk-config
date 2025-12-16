# Corne 46 - Vial Configuration

## Current Setup (v16)

**Active file:** `v16-faster-tapping.vil`

### Base Layer (Colemak)

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│ CTRL  │   Q   │   W   │   F   │   P   │   G   │   │   J   │   L   │   U   │   Y   │  :;   │  VOL+ │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│  GUI  │ A/GUI │ R/ALT │S/CTRL │T/SHIFT│   D   │   │   H   │N/SHIFT│E/CTRL │ I/ALT │ O/GUI │  VOL- │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHIFT │   Z   │   X   │   C   │   V   │   B   │   │   K   │   M   │   ,   │   .   │  ?/   │ SHIFT │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │  ALT  │ SPACE │TAB/L1 │   │ENT/L2 │BSP/L4 │ALT/L3 │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Homerow Mods (Tap Dance)

| Pozycja | Klawisz | Tap | Hold | Timing |
|---------|---------|-----|------|--------|
| TD(1) | A | KC_A | KC_LGUI | 280ms |
| TD(2) | R | KC_R | KC_LALT | 280ms |
| TD(3) | S | KC_S | KC_LCTRL | 280ms |
| TD(4) | T | KC_T | KC_LSHIFT | 280ms |
| TD(5) | N | KC_N | KC_RSHIFT | 280ms |
| TD(6) | E | KC_E | KC_RCTRL | 280ms |
| TD(7) | I | KC_I | KC_RALT | 280ms |
| TD(8) | O | KC_O | KC_RGUI | 280ms |

**Global Tapping Term:** 250ms

### Modifier Combos (for multi-mod shortcuts)

Tap Dance can't reliably combine multiple mods (timing issues). Use combos instead:

**Left hand (A=GUI, R=ALT, S=CTRL, T=SHIFT):**

| Combo | Keys | Positions | Output | Use case |
|-------|------|-----------|--------|----------|
| Cmd+Shift | A + T | 13 + 16 | `OSM(LGUI\|LSFT)` | Selection, uppercase |
| Cmd+Alt | A + R | 13 + 14 | `OSM(LGUI\|LALT)` | App-specific |
| Cmd+Ctrl | A + S | 13 + 15 | `OSM(LGUI\|LCTRL)` | Screenshots |
| Ctrl+Shift | S + T | 15 + 16 | `OSM(LCTRL\|LSFT)` | IDE shortcuts |
| Alt+Shift | R + T | 14 + 16 | `OSM(LALT\|LSFT)` | Text selection |
| Ctrl+Alt | S + R | 15 + 14 | `OSM(LCTRL\|LALT)` | System shortcuts |

**Right hand (mirrored: O=GUI, I=ALT, E=CTRL, N=SHIFT):**

| Combo | Keys | Positions | Output |
|-------|------|-----------|--------|
| Cmd+Shift | O + N | 22 + 19 | `OSM(RGUI\|RSFT)` |
| Cmd+Alt | O + I | 22 + 21 | `OSM(RGUI\|RALT)` |
| Cmd+Ctrl | O + E | 22 + 20 | `OSM(RGUI\|RCTRL)` |
| Ctrl+Shift | E + N | 20 + 19 | `OSM(RCTRL\|RSFT)` |
| Alt+Shift | I + N | 21 + 19 | `OSM(RALT\|RSFT)` |
| Ctrl+Alt | E + I | 20 + 21 | `OSM(RCTRL\|RALT)` |

**Triple mods (optional):**

| Combo | Keys | Output |
|-------|------|--------|
| Cmd+Ctrl+Shift | A + S + T | `OSM(LGUI\|LCTRL\|LSFT)` |
| Cmd+Alt+Shift | A + R + T | `OSM(LGUI\|LALT\|LSFT)` |

**Setup in Vial:**
1. Combos tab → Add combo
2. Set key positions (e.g., 13, 16 for A+T)
3. Assign `OSM(MOD_LGUI | MOD_LSFT)`
4. Timeout: 50ms (default)

### Layers

| Layer | Nazwa | Dostęp |
|-------|-------|--------|
| 0 | Base (Colemak) | - |
| 1 | Num + Nav | Hold TAB |
| 2 | Symbols | Hold ENTER |
| 3 | Diacritics | Hold right ALT (thumb) |
| 4 | Function Keys | Hold BACKSPACE |

### Layer 3 - Diacritics (Colemak-ordered)

Każdy klawisz wysyła `LALT(KC_x)` gdzie x = litera z base layer.

```
┌───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┐
│   ʿ   │   ʾ   │   š   │   ṣ   │   ḡ   │   │   ǧ   │   ł   │   ū   │   ī   │   è   │
├───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┤
│   ą   │   ṣ   │   ś   │   ṭ   │   ḍ   │   │   ḥ   │   ń   │   ę   │   ı   │   ó   │
├───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┤
│   ż   │   ź   │   ć   │   ẓ   │   ·   │   │   •   │   ṯ   │   à   │   ò   │   ù   │
└───────┴───────┴───────┴───────┴───────┘   └───────┴───────┴───────┴───────┴───────┘
```

## Version History

| Wersja | Data | Zmiany |
|--------|------|--------|
| v11 | 2024-12-13 | Baseline z homerow mods (mod-tap) |
| v12 | 2024-12-16 | Layer 3 Colemak-ordered (fix QWERTY → Colemak) |
| v13 | 2024-12-16 | Fix LSA → LALT dla diakrytyków (małe litery) |
| v14 | 2024-12-16 | Homerow mods jako mod-tap (problemy z aktywacją) |
| v15 | 2024-12-16 | Homerow mods jako Tap Dance (280ms per key) |
| v16 | 2024-12-16 | Global tapping term 2000ms → 250ms |

## Wymagania

- **Keylayout:** `PolishProgrammerPlus-v15.keylayout` musi być zainstalowany na macOS
- **Firmware:** Vial-compatible firmware na Corne

## Instalacja

1. Otwórz Vial
2. File → Load → `v16-faster-tapping.vil`
3. File → Save (zapisuje do EEPROM klawiatury)

## Troubleshooting

### Homerow mods aktywują się za wolno
- Zmniejsz Tapping Term w QMK Settings (obecnie 250ms)

### Homerow mods aktywują się przypadkowo
- Zwiększ Tapping Term (spróbuj 280-300ms)

### Diakrytyki nie działają
- Sprawdź czy Polish Programmer Plus v15 jest aktywny w macOS
- Użyj kciuka (LT3) do Layer 3, nie homerow Alt

### Nie mogę użyć dwóch modów naraz (np. Cmd+Shift)
- Tap Dance nie obsługuje dobrze wielu modów jednocześnie
- Użyj combo zamiast (patrz "Modifier Combos" wyżej)
- Lub użyj corner keys (LGUI/LCTRL) + homerow mod
