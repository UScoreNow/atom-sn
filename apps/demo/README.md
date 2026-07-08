# AtomSN — demo

Demo app for [`atomsn`](../../packages/atomsn): shows all
components (atoms, molecules, organisms, templates) live, with a theme toggle
light ("AtomSN Light") / dark ("AtomSN Dark").

**Live demo:** https://uscorenow.github.io/atom-sn-flutter/

> The site is built and published automatically to GitHub Pages via the
> `.github/workflows/pages.yml` workflow on every push to `dev`. There is no manual
> deployment or separate output repo.

## Run

```bash
flutter pub get
flutter run -d chrome   # or -d linux
```

The `atomsn` dependency is resolved by `path` from `packages/atomsn` within the
same monorepo: there are no git version bumps, and library changes are visible
instantly.

## Structure

- `lib/main.dart`: `AsnApp` + section navigation + theme toggle.
- `lib/screens/`: one screen per atomic design layer.
- `lib/widgets/demo_block.dart`: presentation helpers (`DemoBlock`, `DemoScreen`).
