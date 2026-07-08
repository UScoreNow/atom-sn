# CONSTRAINTS.md — AtomSN monorepo

Hard rules in MUST / MUST NOT language. Each rule states its source and when it
applies. Style preferences live in ARCHITECTURE.md files, not here.

## Git / delivery

- MUST NOT push directly to `main` or `dev` (both protected: PR required, CI
  green, no force-push, no branch deletion). Applies always. Source: repo
  branch-protection settings.
- MUST branch from `dev` as `feature|fix|refactor|update/<name>` and open the
  PR against `dev` (GitHub proposes `main` — change the base). Applies to every
  change. Source: CONTRIBUTING.md.
- MUST NOT merge PRs authored by the repo owner (diegofercri); he merges his
  own. Applies always. Source: owner policy.
- Commits MUST be English Conventional Commits; PR titles/bodies MUST be
  Spanish; docs and code comments MUST be English. Source: org convention.
- Releases are cut by release-please on pushes to `main`; MUST NOT create tags
  or GitHub releases by hand. Source: `.github/workflows/release-please.yml`.

## Branding

- MUST NOT reintroduce the retired brand names "Newsprint", "Night Press", or
  "Paper" (as a theme name) in any doc, comment, string, or identifier. The
  design system is **AtomSN**; the themes are "AtomSN Light" / "AtomSN Dark".
  Applies to this repo and every repo depending on the design system.
  Source: brand decision 2026-07-08 (canonical in atom-sn-docs).
  - Exception: the `AsnPalette.paperXX` color-ramp identifiers (and matching
    `color.paper.*` tokens in atom-sn-docs) are a descriptive color name, not
    a brand name. They stay until a dedicated cross-repo breaking rename.
    Expiry: that rename.

## Dependencies

- MUST take `shadcn_ui` from the private fork
  `UScoreNow/atom-sn-flutter-shadcn-fork`, pinned to an immutable commit SHA in
  `packages/atomsn/pubspec.yaml` — NEVER from pub.dev. Icon changes that shadcn
  does not expose as `IconData` params go in the fork; brand styling stays in
  `atomsn`. Source: `packages/atomsn/pubspec.yaml` + fork split decision.
- `shadcn_ui` is the only UI dependency of the library. Components shadcn_ui
  lacks are custom widgets on the same theme (shadcn_flutter used as visual
  reference only, MUST NOT depend on it). Source: `packages/atomsn/README.md`.

## Design system (apply to any component/theme work)

- MUST prefix public widgets/classes `Asn*`, files `asn_*.dart`; the public
  API MUST NOT expose `Shad*` types.
- MUST use HugeIcons only; `grep -rn LucideIcons lib` in the fork must stay
  empty. Font is ElmsSans everywhere, asset path `packages/atomsn/ElmsSans`
  (the path must match the Dart package name).
- Nested corner radius: `outerRadius = childRadius + padding` for every
  rounded surface wrapping rounded children (cards, menus, popovers, panels).
- Overlay surfaces (menus, dropdowns, popovers): solid color, not translucent,
  unless explicitly asked.
- Toast is transient auto-dismiss; Alert is persistent inline. Both exist on
  purpose; MUST NOT merge them.
- Selects/dropdowns: independent state per instance, working search,
  multi-select stays open on selection (match shadcn upstream behavior).
- Every component variant MUST have its own trigger in `apps/demo`.
- Dependency direction is `foundations <- theme <- components`; a layer MUST
  NOT import from a layer above it.

## Infrastructure

- The repo MUST stay public: GitHub Pages does not serve private repos on the
  org's Free plan. Source: Pages deployment requirement.
- MUST NOT hardcode the Pages base-href; `pages.yml` derives it from the repo
  slug so renames never break the site. Source: PR #14.
