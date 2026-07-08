# AtomSN

A brand-neutral, themeable Flutter component library, organized by
**atomic design** + **clean architecture**. It wraps the
[`shadcn_ui`](https://pub.dev/packages/shadcn_ui) catalog and includes the
**AtomSN** editorial theme as the default preset.

- **Primary source:** `shadcn_ui` (the only UI dependency).
- **Gaps:** components that `shadcn_ui` does not offer are built as
  custom widgets on the same theme, using the design of
  [`shadcn_flutter`](https://pub.dev/packages/shadcn_flutter) as a reference (without depending on it).

## Architecture

Layers with an inward dependency rule (`foundations <- theme <- components`):

```
lib/
├── foundations/   # layer 0, brand-agnostic: color, typography, spacing, radius, border
├── theme/         # layer 1: ShadThemeData + AsnThemeScope + AtomSN preset + AsnApp
└── components/    # layer 2: atoms / molecules / organisms / templates
```

- Components are **stateless and controlled** (`value` + `onChanged`), with no
  business logic or state-management dependencies.
- The public API never exposes `Shad*` types: each component defines its own
  `Asn*` enums/models.
- `ShadColorScheme` does not cover all editorial roles (warning, link, success,
  highlightMark, borderSection...); those travel via `AsnThemeScope` and are read with
  `AsnTheme.of(context)`.

## Installation

It is part of the [`UScoreNow/atom-sn-flutter`](https://github.com/UScoreNow/atom-sn-flutter) monorepo.
Within the monorepo, apps consume it by `path`:

```yaml
dependencies:
  atomsn:
    path: ../../packages/atomsn
```

From an external repo, add the git dependency pointing to the monorepo:

```yaml
dependencies:
  atomsn:
    git:
      url: https://github.com/UScoreNow/atom-sn-flutter.git
      path: packages/atomsn
      ref: main
```

## Usage

```dart
import 'package:atomsn/atomsn.dart';
import 'package:flutter/material.dart' show ThemeMode;

void main() => runApp(
  AsnApp(
    themeMode: ThemeMode.system, // default: AtomSN preset light/dark
    home: const Home(),
  ),
);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AsnTheme.of(context);
    return Container(
      color: colors.bgBase,
      child: AsnButton(
        onPressed: () {},
        child: const Text('Hello'),
      ),
    );
  }
}
```

For `Router`/`go_router`, use `ShadApp.router` and wrap the tree with
`AsnThemeScopeBuilder` (it publishes the `AsnThemeScope` based on the active mode).

### Custom theme

`AsnApp` accepts `lightColors`/`darkColors` (`AsnSemanticColors`). Build your
own to re-skin the library without touching the components:

```dart
AsnApp(
  lightColors: AsnColors.light.copyWith(actionPrimary: const Color(0xFF1E66F5)),
  home: const Home(),
);
```

## Catalog

- **Atoms:** Button, IconButton, Badge, Checkbox, Switch, Input, Textarea,
  InputOTP, Slider, Progress, Separator, Avatar, Tooltip + Skeleton, Toggle,
  StarRating, NumberTicker, CodeSnippet (custom).
- **Molecules:** Select, Alert, Card, Accordion, Tabs, Breadcrumb, DatePicker,
  TimePicker, Popover, FormField + ChipInput, PhoneInput, AvatarGroup,
  Pagination, Collapsible, ColorPicker, Tracker, HoverCard (custom).
- **Organisms:** Dialog, Sheet, ContextMenu, Menubar, Table, Calendar,
  Resizable, Toast + Stepper, Steps, Timeline, Tree, NavigationMenu, Command,
  Carousel, DataTable, Drawer (custom).
- **Templates:** PageScaffold, DashboardLayout, AuthLayout.

## Demo

The demo app (all components live, with a light/dark toggle)
lives in this same monorepo, in `apps/demo`, and is published at
https://uscorenow.github.io/atom-sn-flutter/.

## Notes

- **Single-family** typography: `ElmsSans` (variable, minimalist),
  bundled as an asset under the OFL license. The heading hierarchy is achieved
  with size and weight, with no second family or runtime downloads.
