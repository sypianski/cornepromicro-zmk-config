# Corne Keymap - ZMK Firmware

## Deskripto

Ca esas mea personala keymap por la Corne klavaro, konvertita de Vial a ZMK formato. La baza strato uzas **Colemak** layout.

## Strati

| Strato | Nomo | Deskripto |
|--------|------|-----------|
| 0 | Base | Colemak literi kun homerow-modi |
| 1 | Num | Nombri 0-9, navigado (sagii), parentezi |
| 2 | Sym | Simboli (=, -, !, @, #, ', \, `) |
| 3 | L3 | Vakua (por futura uzo) |
| 4 | Fn | Funciono-klavi F1-F18, Bluetooth-komandi |
| 5-9 | — | Rezervita por futura uzo |

## Acesar Strati

- **Tenar TAB** → Strato 1 (Nombri)
- **Tenar ENTER** → Strato 2 (Simboli)
- **Tenar BACKSPACE** → Strato 4 (Funciono-klavi)

## Homerow Modi

Uzo de tap-preferred hold-tap (200ms):

| Sinistra | Dextra |
|----------|--------|
| A = GUI | N = SHIFT |
| R = ALT | E = CTRL |
| S = CTRL | I = ALT |
| T = SHIFT | O = GUI |

## Mod-Tap Klavi

Kelka klavi havas duopla funciono:

| Klavo | Frapeto | Tenado |
|-------|---------|--------|
| Sinistra X | X | LSHIFT |
| Dextra ESC | ESC | RGUI |

## Kombi

Presar du klavi samtempe:

| Klavi | Rezulto |
|-------|---------|
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

## Bluetooth (Strato 4)

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

## Kompiluro-Konfiguro

En `config/corne.conf`, adjuntez:

```
# Bluetooth
CONFIG_ZMK_BLE=y

# Profunda somneyo por sparar baterio
CONFIG_ZMK_SLEEP=y
CONFIG_ZMK_IDLE_SLEEP_TIMEOUT=900000
```

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
