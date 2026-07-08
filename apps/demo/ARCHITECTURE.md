# ARCHITECTURE.md — apps/demo (showcase app)

Dart package `atomsn_demo`. Shows every AtomSN component live, with a theme
toggle "AtomSN Light" / "AtomSN Dark". Deployed to GitHub Pages from `dev`
(https://uscorenow.github.io/atom-sn-flutter/).

## Layout

- `lib/main.dart` — `AsnApp` + section navigation + theme toggle.
- `lib/screens/` — one screen per atomic-design layer: `atoms_screen.dart`,
  `molecules_screen.dart`, `organisms_screen.dart`, `templates_screen.dart`.
- `lib/widgets/demo_block.dart` — presentation helpers (`DemoBlock`,
  `DemoScreen`).

## Rules

- Depends on the library via `path: ../../packages/atomsn` — never a git ref
  or version; library changes are visible instantly.
- Every component variant added to the library MUST get its own trigger here,
  on the screen matching its atomic layer (see /CONSTRAINTS.md).

## Run / verify

```bash
flutter pub get
flutter run -d chrome        # local; agent sandboxes usually have no Chrome
flutter build web            # sandbox-friendly smoke check
```

`flutter analyze` here is a required CI check (`analyze (apps/demo)`).
`pages.yml` builds this app with `--wasm`, `--pwa-strategy=none`, and a
base-href derived from the repo slug — do not hardcode it.
