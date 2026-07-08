# ARCHITECTURE.md — packages/atomsn (the library)

Dart package `atomsn`; single public entry point
`import 'package:atomsn/atomsn.dart'` (barrel file `lib/atomsn.dart`).

## Layers (dependency rule: inward only, `foundations <- theme <- components`)

```
lib/
├── foundations/   # layer 0, brand-agnostic primitives
│   ├── border/  color/  radius/  spacing/  status/  typography/
├── theme/         # layer 1: theming and app shell
│   ├── asn_app.dart              # AsnApp: ShadApp wrapper + AsnThemeScope
│   ├── asn_theme.dart            # AsnTheme.of(context) accessor
│   ├── asn_theme_extension.dart  # editorial roles ShadColorScheme lacks
│   ├── asn_color_scheme.dart / asn_text_theme.dart
│   └── presets/                  # atomsn_preset.dart — the AtomSN default preset
└── components/    # layer 2: atoms / molecules / organisms / templates / shared
```

A layer MUST NOT import from a layer above it (see /CONSTRAINTS.md).

## Component conventions

- Stateless and controlled (`value` + `onChanged`); no business logic, no
  state-management dependencies.
- Public API never exposes `Shad*` types: each component defines its own
  `Asn*` enums/models.
- Primary source is the pinned `shadcn_ui` fork; gaps are custom widgets on the
  same theme (shadcn_flutter as visual reference only, never a dependency).
- Editorial color roles that `ShadColorScheme` does not cover (warning, link,
  success, highlightMark, borderSection, ...) travel via `AsnThemeScope` and
  are read with `AsnTheme.of(context)`.

## Assets

- ElmsSans font shipped under `assets/`; Flutter resolves it as
  `packages/atomsn/ElmsSans` (path must match the Dart package name).

## Interfaces / consumers

- `apps/demo` consumes this package by `path:` — API changes surface there
  immediately and CI analyzes both packages.
- Downstream apps (UScoreNow) consume the published releases from `main`.

## Verify

`flutter analyze` and `flutter test` here (root `make check` covers both
packages). Widget/golden tests live in `test/` (alchemist for goldens).
