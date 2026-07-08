# Changelog

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
