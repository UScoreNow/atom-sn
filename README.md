# AtomSN

A brand-neutral, themeable Flutter design system, organized by **atomic
design** + **clean architecture** on top of [`shadcn_ui`](https://pub.dev/packages/shadcn_ui),
with the **AtomSN** theme by default.

**Live demo:** https://uscorenow.github.io/atom-sn-flutter/

**Agent entry point:** [AGENTS.md](AGENTS.md) (`CLAUDE.md` is a symlink to it).

## Structure (monorepo)

```
packages/atomsn/   # the library (import 'package:atomsn/atomsn.dart')
apps/demo/         # showcase app for every component, published to Pages
.github/workflows/ # ci.yml (analyzer) + pages.yml (deploy to Pages) + release-please.yml
```

The demo consumes the library by `path`, so any change in
`packages/atomsn` is reflected instantly: there are no version bumps or separate
output repos.

## Development

```bash
# Library
cd packages/atomsn && flutter pub get && flutter test

# Demo
cd apps/demo && flutter pub get && flutter run -d chrome
```

## Workflow

`main` and `dev` are permanent, protected branches; everything lands via PR with CI
green. The branch model is detailed in [CONTRIBUTING.md](CONTRIBUTING.md):

- `main`: stable / production. Source of Releases.
- `dev`: integration. **Deploys to GitHub Pages.**
- Work: `feature/…`, `fix/…`, `refactor/…`, `update/…` -> PR to `dev`.
- Promotion: PR `dev -> main`; merging publishes a Release.

## Deployment

Each push to `dev` triggers `.github/workflows/pages.yml`, which builds `apps/demo`
to web and publishes it to GitHub Pages. Each merge to `main` triggers
`release-please.yml`, which maintains a release PR and cuts the Release (tag,
notes, and `packages/atomsn/pubspec.yaml` version bump) when that PR is merged.

## Contributing

This repository follows the [UScoreNow contribution guidelines](https://github.com/UScoreNow/.github/blob/main/CONTRIBUTING.md): branching model, Conventional Commits, pull requests and releases.
