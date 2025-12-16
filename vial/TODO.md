# Vial Layout

## TODO

- [ ] Add modifier combos for multi-mod shortcuts (see CLAUDE.md):
  - A + T → Cmd+Shift
  - S + T → Ctrl+Shift
  - A + R → Cmd+Alt
  - A + S → Cmd+Ctrl
- [ ] Set combo for Layer 6 (dead keys) on ZMK
- [ ] Sync Layer 5/6 structure to Vial (if needed)

---

## Current: v10-combos.vil

### Layer Summary

| Layer | Activator | Purpose |
|-------|-----------|---------|
| 0 | - | Base (Colemak) |
| 1 | LT1 (left thumb TAB) | Nav + Numpad |
| 2 | LT2 (right thumb ENTER) | Symbols |
| 3 | LT3 (right thumb RALT) | Diacritics (LALT+key for keylayout) |
| 4 | LT4 (right thumb BSPACE) | F-keys + Rare keys |

---

### Layer 2: Symbols

```
LEFT:                             RIGHT:
┌────┬────┬────┬────┬────┬────┐   ┌────┬────┬────┬────┬────┐
│ ▽  │ =  │ +  │ *  │ &  │ |  │   │ )  │ ]  │ }  │ "  │ '  │
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ -  │ !  │ @  │ #  │ '  │   │ (  │ [  │ {  │ `  │ ~  │
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ ^  │ \  │ §  │ ±  │ %  │   │ _  │ |  │ \  │ •  │ ·  │
└────┴────┴────┴────┴────┴────┘   └────┴────┴────┴────┴────┘

Brackets: opening on home row (easy reach), closing on top row
• and · via keylayout (LALT+K, LALT+B)
```

---

### Layer 3: Diacritics

Activator: `LT3(KC_RALT)` - hold RALT for diacritics, tap for Alt.
Sends `LALT(KC_x)` which macOS keylayout interprets as diacritics.

```
┌────┬────┬────┬────┬────┬────┐   ┌────┬────┬────┬────┬────┐
│ ▽  │ ʿ  │ ʾ  │ ę  │ ṣ  │ ṭ  │   │ ī  │ ū  │ ı  │ ó  │ ā  │
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ ą  │ ś  │ ḍ  │ š  │ ḡ  │   │ ḥ  │ ǧ  │ •  │ ł  │ è  │
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ ż  │ ź  │ ć  │ ẓ  │ ·  │   │ ń  │ ṯ  │ à  │ ò  │ ù  │
└────┴────┴────┴────┴────┴────┘   └────┴────┴────┴────┴────┘
```

---

### Layer 4: F-keys + Rare

F1-F15 on left (bottom-to-top), F16-F24 + rare keys on right.

```
LEFT:                             RIGHT:
┌────┬────┬────┬────┬────┬────┐   ┌────┬────┬────┬────┬────┐
│ ▽  │F11 │F12 │F13 │F14 │F15 │   │Ins │ScrL│Paus│Del │ ·  │
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ F6 │ F7 │ F8 │ F9 │F10 │   │F21 │F22 │F23 │F24 │PrtS│
├────┼────┼────┼────┼────┼────┤   ├────┼────┼────┼────┼────┤
│ ▽  │ F1 │ F2 │ F3 │ F4 │ F5 │   │F16 │F17 │F18 │F19 │F20 │
└────┴────┴────┴────┴────┴────┘   └────┴────┴────┴────┴────┘

Del = Forward Delete (KC_DELETE)
```

---

### Combos

| Keys | Output |
|------|--------|
| Z + / | Caps Lock |
| F + J | Caps Lock (backup) |
| W + U | Caps Word (if supported) |

---

### Settings

- Sticky shift: disabled (settings[1] = 0)

---

## Keylayout Integration

The Polish Programmer Plus keylayout provides:
- Direct diacritics on Option layer
- Dead keys on Option + 6/8/9/0
- See `../ukulelo/LAYOUT.md` for full reference
