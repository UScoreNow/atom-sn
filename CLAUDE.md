# CLAUDE.md - AtomSN monorepo

Flutter design system "AtomSN".

## Layout
- `packages/atomsn/`: the library. Dart package `atomsn`, import `package:atomsn/atomsn.dart`. Widgets/classes prefixed `Asn*`, files `asn_*.dart`.
- `apps/demo/`: showcase app, depends on the library via path (changes are instant).
- `shadcn_ui` comes from the private fork `UScoreNow/atom-sn-flutter-shadcn-fork` (branch `usn/0.54.0-elms-huge`), NEVER from pub.dev. Icon changes shadcn does not expose as `IconData` params go in the fork; brand styling stays in `atomsn`.

## Pixel-perfect rules (first attempt, not after correction)
- Nested corner radius: `outerRadius = childRadius + padding` for every rounded surface wrapping rounded children (cards, select/dropdown menus, popovers, panels). Never reuse the child radius on the parent.
- Fonts: ElmsSans everywhere (asset path `packages/atomsn/ElmsSans`). Icons: HugeIcons only; `grep -rn LucideIcons lib` in the fork must stay empty.
- Overlay surfaces (menus, dropdowns, popovers): solid light color, not translucent, unless asked.
- Toast = transient auto-dismiss; Alert = persistent inline. Both exist on purpose; do not merge them.
- Selects/dropdowns: independent state per instance, working search, multi-select stays open on selection - match shadcn upstream behavior.
- Every variant needs its own trigger in `apps/demo`.

## Verify
`flutter analyze` in BOTH `packages/atomsn` and `apps/demo`, then `flutter test` and `flutter build web`. No emulator or Chrome available. Flutter may live at `/opt/flutter` (add `/opt/flutter/bin` to PATH). CI fallback: `gh run watch <id> -R UScoreNow/atom-sn-flutter`.

## Flow
Working branch (`feature|fix|refactor|update/<name>`) -> PR to `dev` (Spanish title/body, English Conventional Commits). Merging to `dev` redeploys Pages (https://uscorenow.github.io/atom-sn-flutter/). Promote with PR `dev` -> `main`, bumping `packages/atomsn/pubspec.yaml` version to cut a release. Never push to `main`/`dev` directly; never merge the owner's PRs.
