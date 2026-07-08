import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../foundations/radius/asn_radius.dart';

/// Entry of an [AsnBreadcrumb] dropdown menu. Own model (no `Shad*` leak).
@immutable
class AsnBreadcrumbMenuItem {
  const AsnBreadcrumbMenuItem({required this.label, this.onTap});

  final Widget label;
  final VoidCallback? onTap;
}

enum _AsnBreadcrumbItemKind { link, ellipsis, dropdown }

/// Item of an [AsnBreadcrumb]. Custom model (does not leak `Shad*` types).
///
/// Three kinds: a navigable [AsnBreadcrumbItem.link] (also the default
/// constructor), a collapsed [AsnBreadcrumbItem.ellipsis] indicator (which can
/// open a menu of hidden levels), or an [AsnBreadcrumbItem.dropdown] whose
/// labelled trigger reveals alternative paths in a menu.
@immutable
class AsnBreadcrumbItem {
  /// A navigable link. Equivalent to [AsnBreadcrumbItem.link].
  const AsnBreadcrumbItem({required this.label, this.onTap})
    : _kind = _AsnBreadcrumbItemKind.link,
      trigger = null,
      menuItems = const [];

  /// A navigable link.
  const AsnBreadcrumbItem.link({required this.label, this.onTap})
    : _kind = _AsnBreadcrumbItemKind.link,
      trigger = null,
      menuItems = const [];

  /// A "…" indicator for collapsed levels. When [menuItems] is non-empty the
  /// ellipsis becomes the trigger of a dropdown (no chevron, matching shadcn);
  /// otherwise it is a static indicator.
  const AsnBreadcrumbItem.ellipsis({this.menuItems = const []})
    : _kind = _AsnBreadcrumbItemKind.ellipsis,
      label = null,
      onTap = null,
      trigger = null;

  /// A labelled [trigger] that opens a dropdown listing the [menuItems]. Shows
  /// the dropdown chevron next to the trigger.
  const AsnBreadcrumbItem.dropdown({
    required Widget this.trigger,
    required this.menuItems,
  }) : _kind = _AsnBreadcrumbItemKind.dropdown,
       label = null,
       onTap = null;

  final _AsnBreadcrumbItemKind _kind;
  final Widget? label;
  final VoidCallback? onTap;
  final Widget? trigger;
  final List<AsnBreadcrumbMenuItem> menuItems;

  List<ShadBreadcrumbDropMenuItem> _menu() => menuItems
      .map(
        (item) =>
            ShadBreadcrumbDropMenuItem(onPressed: item.onTap, child: item.label),
      )
      .toList();

  Widget _build() {
    return switch (_kind) {
      _AsnBreadcrumbItemKind.link => ShadBreadcrumbLink(
        onPressed: onTap,
        child: label!,
      ),
      // A bare ellipsis, or an ellipsis that triggers a dropdown. The chevron
      // is hidden so only the "…" shows, as in shadcn's collapsed breadcrumb.
      _AsnBreadcrumbItemKind.ellipsis => menuItems.isEmpty
          ? const ShadBreadcrumbEllipsis()
          : ShadBreadcrumbDropdown(
              showDropdownArrow: false,
              items: _menu(),
              child: const ShadBreadcrumbEllipsis(),
            ),
      _AsnBreadcrumbItemKind.dropdown => ShadBreadcrumbDropdown(
        items: _menu(),
        child: trigger!,
      ),
    };
  }
}

/// Hierarchical navigation path. Wraps `ShadBreadcrumb`.
class AsnBreadcrumb extends StatelessWidget {
  const AsnBreadcrumb({super.key, required this.items, this.separator});

  final List<AsnBreadcrumbItem> items;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final ghost = theme.ghostButtonTheme;
    // The dropdown menu items are ghost ShadButtons whose corner radius (and
    // there is no breadcrumb-theme hook for it) defaults to the menu radius
    // (md), so they did not nest in the rounded menu. Drop the ghost radius to
    // sm just for this subtree (and its popover); links have no fill, so they
    // are unaffected.
    return ShadTheme(
      data: theme.copyWith(
        ghostButtonTheme: ghost.copyWith(
          decoration: (ghost.decoration ?? const ShadDecoration()).merge(
            ShadDecoration(border: ShadBorder.all(radius: AsnRadius.brSm, width: 0)),
          ),
        ),
      ),
      child: ShadBreadcrumb(
        separator: separator,
        children: items.map((item) => item._build()).toList(),
      ),
    );
  }
}
