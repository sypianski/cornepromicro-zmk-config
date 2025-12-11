# Corne Keymap - ZMK Firmware

## Deskripto

Ca esas mea personala keymap por la Corne klavaro, konvertita de Vial a ZMK formato. La baza strato uzas **Colemak** layout.

## Strati

| Strato | Nomo | Deskripto |
|--------|------|-----------|
| 0 | Base | Colemak literi kun homerow-modi |
| 1 | Num | Nombri 0-9, navigado (sagii), parentezi |
| 2 | Sym | Simboli (=, -, !, @, #, ', \, `) |
| 3 | Media | Media-klavi, Bluetooth-komandi |
| 4 | Fn | Funciono-klavi F1-F24 |
| 5-9 | — | Rezervita por futura uzo |

## Acesar Strati

- **Tenar SPACE** → Strato 3 (Media + Bluetooth)
- **Tenar TAB** → Strato 1 (Nombri)
- **Tenar ENTER** → Strato 2 (Simboli)
- **Tenar BACKSPACE** → Strato 4 (Funciono-klavi)

## Baza Strato

```
LCTRL   Q       W       F       P       G       |  J       L       U       Y       :/;     ---
LGUI    A(gui)  R(alt)  S(ctrl) T(shft) D       |  H       N(shft) E(ctrl) I(alt)  O(gui)  ESC
LSHFT   Z       X       C       V       B       |  K       M       ,       .       ?//     RSHFT
                        LALT    SPACE(L3) TAB(L1) |  RET(L2) BSPC(L4) RALT
```

- `:` defaŭlte, `;` kun shift
- `?` defaŭlte, `/` kun shift

## Strato 1: Nombri + Navigado

```
---     PgUp    Home    PgDn    End     ---     |  [       7       8       9       ]       ---
---     Up      Left    Right   Down    ---     |  (       4       5       6       )       ---
---     Alt+←   Alt+↓   Alt+↑   Alt+→   ---     |  {       1       2       3       }       ---
                        ---     ---     ---     |  ---     ---     0
```

## Strato 2: Simboli

```
---     =       +       *       &       |       |  {       [       (       )       ]       }
---     -       !       @       #       '       |  "       _       :       ;       ?       ---
\       ^       \       `       ~       %       |  $       <       >       /       ---     ---
                        ---     ---     ---     |  ---     ---     ---
```

Noto: `` ` `` e `~` uzas NUBS (ISO-klavaro) por kongrueco kun Polish Programmer layout.

## Strato 3: Media + Bluetooth

```
---     ---     ---     ---     ---     ---     |  BT_CLR  BT0     BT1     BT2     BT3     BT4
---     PREV    VOL-    VOL+    NEXT    ---     |  CLR_ALL BT_PRV  BT_NXT  ---     ---     ---
---     ---     BRI-    BRI+    MUTE    PLAY    |  ---     DISC0   DISC1   DISC2   ---     ---
                        ---     ---     ---     |  ---     ---     ---
```

## Strato 4: Funciono-Klavi

```
---     F21     F22     F23     F24     ---     |  ---     ---     ---     ---     ---     ---
---     F11     F12     F13     F14     F15     |  F16     F17     F18     F19     F20     ---
---     F1      F2      F3      F4      F5      |  F6      F7      F8      F9      F10     ---
                        ---     ---     ---     |  ---     ---     ---
```

F-klavi komencas de malsupre-maldekstre, iras dekstre, tiam supre.

## Homerow Modi

Uzo de tap-preferred hold-tap (280ms):

| Sinistra | Dextra |
|----------|--------|
| A = GUI | N = SHIFT |
| R = ALT | E = CTRL |
| S = CTRL | I = ALT |
| T = SHIFT | O = GUI |

## Kombi

Presar du klavi samtempe:

| Klavi | Rezulto |
|-------|---------|
| Q + W | Delete |
| A + R | { |
| R + S | [ |
| S + T | ( |
| N + E | ) |
| E + I | ] |
| I + O | } |
| G + J | Bootloader |
| T + N | Caps Word |

## Caps Word

Caps Word aktivigas per T+N kombo. Olu duros dum tu tajpas literi, e duras kun:
- Underscore (_)
- Minus (-)
- Backspace
- Delete

## Bluetooth (Strato 3)

- BT_CLR, BT_CLR_ALL - Klarigar konexi
- BT_SEL 0-4 - Selektar profilo
- BT_PRV, BT_NXT - Antea/nexta profilo
- BT_DISC 0-2 - Diskonetar profilo

## Instalado

1. Klonez o forkez la repositorio
2. Pozez `corne.keymap` en la `config/` foldero
3. Komitez e pushyez a GitHub
4. Atendez ke GitHub Actions kompilez la firmware
5. Deskargez la `.uf2` dosieri de la "Actions" tabo
6. Flashez a tua klavaro

## Modifikar

Por modifikar la keymap:

1. Editez `config/corne.keymap`
2. Komitez e pushyez
3. Deskargez nova firmware de GitHub Actions
4. Flashez

## Resursaro

- [ZMK Dokumenturo](https://zmk.dev/docs)
- [ZMK Keycodes](https://zmk.dev/docs/codes)
- [ZMK Behaviors](https://zmk.dev/docs/keymaps/behaviors)

## Licenco

MIT
