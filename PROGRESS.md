# PROGRESS.md — AtomSN monorepo

State as of 2026-07-08. Update when finishing substantial work.

## Done

- Full coverage of the shadcn fork catalog: remaining widgets wrapped as
  `Asn*` components with demo triggers (PR #16).
- Rebrand complete: repo `atom-sn-flutter`, package `atomsn`, prefix `Asn*`,
  themes "AtomSN Light"/"AtomSN Dark"; retired names scrubbed from prose
  (PR #15 and follow-ups).
- Release automation migrated to release-please (`release-please.yml`,
  config + manifest); v1.0.0 released from `main`.
- Pages deploy from `dev` with slug-derived base-href; demo live at
  https://uscorenow.github.io/atom-sn-flutter/.
- Long tail of component fixes merged to `dev`: menu concentric radius,
  breadcrumb variants, select variants/behavior, time-picker period,
  checkbox/radio sublabel alignment, tooltip hover, ElmsSans defaults.

## In progress

- Agent source-of-truth docs (this branch): AGENTS.md router, CONSTRAINTS.md,
  ARCHITECTURE.md per module, PROGRESS.md, Makefile.

## Known gaps / planned

- `packages/atomsn/pubspec.yaml` still points `shadcn_ui` at the old fork URL
  `atom-sn-shadcn-fork.git` (repo renamed to `atom-sn-flutter-shadcn-fork`;
  old URL redirects, so it works). Update on the next dependency bump.
- The pinned fork SHA is behind the tip of branch `usn/0.54.0-elms-huge`;
  bump deliberately when the newer fork commits are needed.
- Future breaking rename of the `paper` color ramp (`AsnPalette.paperXX` here,
  `color.paper.*` in atom-sn-docs); new ramp name not yet decided. Branding-only
  scrub was done first on purpose.
- `dev` shows pre-release version metadata (e.g. `pubspec.yaml` 0.1.0 vs
  1.0.0 released on `main`) until the next `main -> dev` back-merge; expected
  with the merge-commit promotion flow.
