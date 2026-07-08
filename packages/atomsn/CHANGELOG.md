# Changelog

## [1.1.0](https://github.com/UScoreNow/atom-sn-flutter/compare/1.0.0...1.1.0) (2026-07-08)


### Features

* **select:** add withSearch and multiple select variants ([68e8973](https://github.com/UScoreNow/atom-sn-flutter/commit/68e897384a39e5268089e116c0bfd91ea230eabc))
* **select:** variantes de select con estado independiente y tests ([e2f4245](https://github.com/UScoreNow/atom-sn-flutter/commit/e2f424546e61c50de3fd29b86b34057f1b0ad02b))
* variantes de select faltantes y AsnForm a organism ([63ba84d](https://github.com/UScoreNow/atom-sn-flutter/commit/63ba84d68050ed79b2cf813b84233b2e1b392bee))
* variantes de select/form completas, fixes de paridad shadcn y docs de agente ([e9a8f9c](https://github.com/UScoreNow/atom-sn-flutter/commit/e9a8f9c91d3a207b8d76bf961b753dd7c6d71952))


### Bug Fixes

* **breadcrumb:** hide the dropdown chevron on the collapsed ellipsis ([fb627c4](https://github.com/UScoreNow/atom-sn-flutter/commit/fb627c4fa5183e330784508a9c600b17eadc349b))
* **breadcrumb:** showcase the three official shadcn variants ([6097042](https://github.com/UScoreNow/atom-sn-flutter/commit/6097042733f24617eaefc43c29eefd8cb4fdf964))
* **checkbox,radio:** center control with primary label and unify sublabel style ([bfc2932](https://github.com/UScoreNow/atom-sn-flutter/commit/bfc2932703340fcd7cb433b4a82b0d7ea5f36d34))
* **select:** make search filter, keep multiple open, add scrollable demo ([df81b15](https://github.com/UScoreNow/atom-sn-flutter/commit/df81b156daf9ecd7c0eae4832025edcb6ed0ed17))
* **select:** search funcional, multiple sin cierre y variante scrollable ([794c765](https://github.com/UScoreNow/atom-sn-flutter/commit/794c765bd92208e5d1406fbbbac7083d0f2e6fb2))
* **select:** separate per-variant state and cover variants with tests ([44b7d14](https://github.com/UScoreNow/atom-sn-flutter/commit/44b7d148e9def5f09f8fc5085188bc555addff72))
* **theme,breadcrumb:** correct dropdown item radius without skewing padding ([57940a9](https://github.com/UScoreNow/atom-sn-flutter/commit/57940a9a8d8f7d6a95ac43c7ca44477ccf4acc3e))
* **theme:** nest dropdown menu items with a concentric radius ([0d839f8](https://github.com/UScoreNow/atom-sn-flutter/commit/0d839f8483c7772abd245cbe83b45cca70d2198e))
* **time-picker:** drop the segment field, add the period (AM/PM) variant ([2ef197d](https://github.com/UScoreNow/atom-sn-flutter/commit/2ef197de5a565dd895c7d2706018e56671f38f8e))
* **tooltip,popover:** trigger tooltip on hover and apply ElmsSans in popover ([24b4328](https://github.com/UScoreNow/atom-sn-flutter/commit/24b43281325a4671bb153276b739ec2622ebe6a6))

## [1.0.0](https://github.com/UScoreNow/atom-sn-flutter/compare/0.1.0...1.0.0) (2026-06-25)


### ⚠ BREAKING CHANGES

* the public class `AsnNewsprint` is renamed to `AsnColors` and `AsnNewsprintPalette` to `AsnPalette`; the preset file `theme/presets/newsprint_preset.dart` is renamed to `atomsn_preset.dart`. Update imports and references accordingly.

### Features

* cobertura completa del fork shadcn en atomsn ([bc4405c](https://github.com/UScoreNow/atom-sn-flutter/commit/bc4405c049ad7924afba8e88394696d546f0a18f))
* **components:** wrap remaining shadcn fork widgets ([e70c71b](https://github.com/UScoreNow/atom-sn-flutter/commit/e70c71b8073a6e41891a208e173035d8add0482b))
* **demo:** showcase and test the new shadcn wrappers ([958415b](https://github.com/UScoreNow/atom-sn-flutter/commit/958415bcb79815310651bb9c0086c3ae79e761cd))


### Code Refactoring

* rename editorial theme "newsprint" to AtomSN ([69d1a11](https://github.com/UScoreNow/atom-sn-flutter/commit/69d1a11b87f1fa862f7074dfb62f15692096f402))

## [0.1.0](https://github.com/UScoreNow/atom-sn/compare/0.0.1...0.1.0) (2026-06-24)


### Features

* rebrand to AtomSN, path-linked demo, Pages CI/CD ([3e0313e](https://github.com/UScoreNow/atom-sn/commit/3e0313e98b975f129fa30d6050c0b6a4c8672cbd))


### Bug Fixes

* **pages:** base-href a /atom-sn/ tras el rename del repo ([a7c1b73](https://github.com/UScoreNow/atom-sn/commit/a7c1b7390e7dd5f9fb5e0370fc1d60b8a3dcc3a0))
* **pages:** corregir base-href tras renombrar el repo a atom-sn ([d19d5a8](https://github.com/UScoreNow/atom-sn/commit/d19d5a8725bef7a80ec03819187c255a794f11d0))
* promocion base-href /atom-sn/ a main ([06bcb91](https://github.com/UScoreNow/atom-sn/commit/06bcb91f6f1eb83f6dd2eb4fc03f3800bc6591c3))

## 0.0.1

- Initial structure: foundations + theme (initial preset, since renamed to AtomSN) + components
  (atoms / molecules / organisms / templates) on top of shadcn_ui.
- `AsnApp`, `AsnThemeScope`, and `AsnTheme.of` for theme consumption.
- Example gallery with light/dark toggle and widget tests.
