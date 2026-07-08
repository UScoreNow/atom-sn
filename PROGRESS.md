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
- Paper-ramp naming resolved (2026-07-08): the `AsnPalette.paperXX` /
  `color.paper.*` ramp keeps the `paper` name permanently; the cross-repo
  breaking rename considered after the rebrand was rejected.

## In progress

- Agent source-of-truth docs (this branch): AGENTS.md router, CONSTRAINTS.md,
  ARCHITECTURE.md per module, PROGRESS.md, Makefile.

## Known gaps / planned

- `packages/atomsn/pubspec.yaml` still points `shadcn_ui` at the old fork URL
  `atom-sn-shadcn-fork.git` (repo renamed to `atom-sn-flutter-shadcn-fork`;
  old URL redirects, so it works). Update on the next dependency bump.
- The pinned fork SHA is behind the tip of branch `usn/0.54.0-elms-huge`;
  bump deliberately when the newer fork commits are needed.
- `dev` shows pre-release version metadata (e.g. `pubspec.yaml` 0.1.0 vs
  1.0.0 released on `main`) until the next `main -> dev` back-merge; expected
  with the merge-commit promotion flow.
