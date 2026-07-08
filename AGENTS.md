# AGENTS.md — AtomSN monorepo

AtomSN is a brand-neutral, themeable Flutter design system organized by atomic
design + clean architecture on top of a private `shadcn_ui` fork. This file is
the canonical agent entry point; `CLAUDE.md` is a symlink to it.

## Hard constraints (MUST / MUST NOT)

1. MUST NOT push directly to `main` or `dev`; all work lands via PR to `dev`
   from a `feature|fix|refactor|update/<name>` branch. MUST NOT merge the
   owner's PRs. (Source: repo protection rules + owner policy.)
2. MUST take `shadcn_ui` from the private fork
   `UScoreNow/atom-sn-flutter-shadcn-fork` pinned by commit SHA — NEVER from
   pub.dev. (Source: `packages/atomsn/pubspec.yaml`.)
3. MUST NOT use the retired brand names "Newsprint", "Night Press", or "Paper"
   (as a theme name) anywhere. The system is **AtomSN**; themes are
   "AtomSN Light" / "AtomSN Dark". The `AsnPalette.paperXX` color-ramp
   identifiers are a color name, not a brand name, and stay until a separate
   cross-repo rename. (Source: brand decision 2026-07-08, atom-sn-docs.)
4. MUST prefix public widgets/classes `Asn*` and files `asn_*.dart`; the
   public API MUST NOT expose `Shad*` types (wrap them in `Asn*` enums/models).
5. MUST use HugeIcons only (no LucideIcons) and the ElmsSans font (asset path
   `packages/atomsn/ElmsSans`).
6. MUST apply the nested-radius formula `outerRadius = childRadius + padding`
   on every rounded surface that wraps rounded children; never reuse the child
   radius on the parent.
7. MUST add a demo trigger in `apps/demo` for every new component variant.
8. MUST keep the repo public (GitHub Pages on the org Free plan will not serve
   a private repo) and MUST NOT hardcode the Pages base-href (it is derived
   from the repo slug in `pages.yml`).
9. Commits MUST be English Conventional Commits; PR titles/descriptions MUST
   be Spanish; docs and code comments MUST be English.

## What / where

- `packages/atomsn/` — the library (Dart package `atomsn`,
  `import 'package:atomsn/atomsn.dart'`). See `packages/atomsn/ARCHITECTURE.md`.
- `apps/demo/` — showcase app, consumes the library by `path` (changes are
  instant, no version bumps). See `apps/demo/ARCHITECTURE.md`.
- `.github/workflows/` — `ci.yml` (analyzer on both packages, required checks),
  `pages.yml` (deploys demo to Pages on push to `dev`), `release-please.yml`
  (release PRs/tags on push to `main`).

## Run / verify

Flutter may live off PATH at `/opt/flutter` (`export PATH="$PATH:/opt/flutter/bin"`).

```bash
make setup   # flutter pub get in both packages
make lint    # flutter analyze in both packages (mirrors CI)
make test    # flutter test in packages/atomsn and apps/demo
make check   # lint + test; must be green before any PR
```

Run the demo locally: `cd apps/demo && flutter run -d chrome` (no emulator or
Chrome in agent sandboxes — fall back to `flutter build web` and CI:
`gh run watch <id> -R UScoreNow/atom-sn-flutter`).

Live demo (deployed from `dev`): https://uscorenow.github.io/atom-sn-flutter/

## Flow

Branch from `dev` → PR to `dev` (GitHub proposes `main` as base — change it).
Merging to `dev` redeploys Pages. Promote with a PR `dev -> main`; on `main`,
release-please opens/updates the release PR and cuts the release when merged.
Details: [CONTRIBUTING.md](CONTRIBUTING.md).

## Read on demand

- [CONTRIBUTING.md](CONTRIBUTING.md) — branch model, PR lifecycle, protection
  rules; read before opening any PR.
- [CONSTRAINTS.md](CONSTRAINTS.md) — full constraint list with sources; read
  before changing theme, components, or workflows.
- [packages/atomsn/ARCHITECTURE.md](packages/atomsn/ARCHITECTURE.md) — layer
  rules and component conventions; read before touching the library.
- [apps/demo/ARCHITECTURE.md](apps/demo/ARCHITECTURE.md) — demo layout; read
  when adding demo coverage.
- [PROGRESS.md](PROGRESS.md) — current state; read at session start and update
  when finishing substantial work.
