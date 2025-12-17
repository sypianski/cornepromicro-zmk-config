# Corne Keymap - ZMK Firmware

## Deskripto

Ca esas mea personala keymap por la Corne klavaro, konvertita de Vial a ZMK formato. La baza strato uzas **Colemak** layout.

## Strati

| Strato | Nomo | Deskripto |
|--------|------|-----------|
| 0 | Base | Colemak literi kun homerow-modi |
| 1 | Num | Nombri 0-9, navigado (sagii), parentezi |
| 2 | Sym | Simboli (=, -, !, @, #, ', \, `) |
| 3 | Dia | Diakritiki (RALT+klavo → ą ę ó etc.) |
| 4 | Fn | Funciono-klavi F1-F24 |
| 5 | BT | Bluetooth-komandi (acesar per Z+X) |
| 6 | Dead | Morta-klavi (makron, cirkumflekso, etc.) |
| 7-9 | — | Rezervita por futura uzo |

## Acesar Strati

- **Tenar RALT (dextra polexo)** → Strato 3 (Diakritiki)
- **Tenar TAB** → Strato 1 (Nombri)
- **Tenar ENTER** → Strato 2 (Simboli)
- **Tenar BACKSPACE** → Strato 4 (Funciono-klavi)
- **Presar Z+X** → Strato 5 (Bluetooth) - sticky
- **Presar C+V** → Strato 6 (Morta-klavi) - sticky

## Baza Strato

```
LCTRL   Q       W       F       P       G       |  J       L       U       Y       :/;     ---
LGUI    A(gui)  R(alt)  S(ctrl) T(shft) D       |  H       N(shft) E(ctrl) I(alt)  O(gui)  ESC
LSHFT   Z       X       C       V       B       |  K       M       ,       .       ?//     RSHFT
                        LALT    SPACE   TAB(L1)   |  RET(L2) BSPC(L4) RALT(L3)
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

## Strato 3: Diakritiki

Tenar RALT (dextra polexo) + klavo:

```
---     ʿ       ʾ       š       ā       ḡ       |  ǧ       ł       ū       ī       è       ---
---     ą       ṣ       ś       ṭ       ḍ       |  ḥ       ń       ę       ı       ó       ---
---     ż       ź       ć       ẓ       ·       |  •       ṯ       à       ò       ù       ---
                        ---     ---     ---     |  ---     ---     ---
```

Sendas `RALT+klavo`. Requiras EKH (Android) o keylayout (macOS).

## Strato 4: Funciono-Klavi

```
---     F21     F22     F23     F24     ---     |  ---     ---     ---     ---     ---     ---
---     F11     F12     F13     F14     F15     |  F16     F17     F18     F19     F20     ---
---     F1      F2      F3      F4      F5      |  F6      F7      F8      F9      F10     ---
                        ---     ---     ---     |  ---     ---     ---
```

F-klavi komencas de malsupre-maldekstre, iras dekstre, tiam supre.

## Strato 5: Bluetooth

Presar Z+X samtempe por acesar:

```
---     ---     ---     ---     ---     ---     |  BT_CLR  BT0     BT1     BT2     BT3     BT4
---     ---     ---     ---     ---     ---     |  ---     ---     ---     ---     ---     ---
---     ---     ---     ---     ---     ---     |  ---     ---     ---     ---     ---     ---
                        ---     ---     ---     |  ---     ---     ---
```

## Strato 6: Morta-Klavi

Combo TBD. Presar morta-klavo, poste litera:

```
---     ---     ---     ---     ---     ---     |  ---     ---     ---     ---     ---     ---
---     Makron  Cirk.   Uml.    Karon   ---     |  ---     Breve   Akuto   Cedil.  ---     ---
---     ---     ---     ---     ---     ---     |  ---     ---     ---     ---     ---     ---
                        ---     ---     ---     |  ---     ---     ---
```

- Makron (¯): ā ē ī ō ū
- Cirkumflekso (^): â ê î ô û
- Umlaut (¨): ä ë ï ö ü
- Karon (ˇ): č š ž
- Breve (˘): ğ ŭ
- Akuto (´): á é í ó ú
- Cedilo (¸): ç ş

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
| Z + X | Strato 5 (Bluetooth) - sticky |
| C + V | Strato 6 (Morta-klavi) - sticky |
| LSHFT + RSHFT | Caps Lock |

## Caps Word

Caps Word aktivigas per T+N kombo. Olu duros dum tu tajpas literi, e duras kun:
- Underscore (_)
- Minus (-)
- Backspace
- Delete

## Bluetooth (Strato 5)

Acesar per Z+X kombo (sticky - presar, liberigar, lore presar klavo):

- BT_CLR - Klarigar aktuala profilo
- BT_SEL 0-4 - Selektar profilo (5 totala)

## EKH Agordado (Android)

External Keyboard Helper necesas por diakritiki sur Android.

**Polona:**
```
RALT+A→ą  RALT+C→ć  RALT+E→ę  RALT+L→ł  RALT+N→ń
RALT+O→ó  RALT+S→ś  RALT+X→ź  RALT+Z→ż
```

**Araba ISO 233:**
```
RALT+Q→ʿ  RALT+W→ʾ  RALT+D→ḍ  RALT+F→š  RALT+G→ḡ
RALT+H→ḥ  RALT+J→ǧ  RALT+R→ṣ  RALT+T→ṭ  RALT+V→ẓ
RALT+M→ṯ  RALT+P→ā  RALT+Y→ī  RALT+U→ū
```

**Morta-klavi:**
```
RALT+6→makron(¯)  RALT+7→cirkumflekso(^)  RALT+8→umlaut(¨)
RALT+9→karon(ˇ)   RALT+0→breve(˘)         RALT+minus→akuto(´)
RALT+equal→cedilo(¸)
```

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
