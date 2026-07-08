import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../foundations/color/asn_semantic_colors.dart';
import '../foundations/radius/asn_radius.dart';
import 'asn_color_scheme.dart';
import 'asn_text_theme.dart';
import 'asn_theme_extension.dart';

/// Access point to the `AtomSN` theme.
///
/// - [buildTheme] builds the `ShadThemeData` that `ShadApp` consumes.
/// - [of] returns the active [AsnSemanticColors] (full editorial roles),
///   useful for custom components that need colors outside of
///   `ShadColorScheme`.
abstract final class AsnTheme {
  /// Offset (gap) between the element's border and its focus ring.
  static const double _focusOffset = 4;

  /// Builds the shadcn_ui `ShadThemeData` from [colors].
  static ShadThemeData buildTheme(AsnSemanticColors colors) {
    final ring = colors.actionPrimary;

    // Focus ring concentric with the element's corner:
    // R_ring = R_element + offset. shadcn uses radius*1.5 by default, which
    // misaligns the corners (especially when the element has a small radius).
    ShadBorder focusRing(double childRadius) => ShadBorder.all(
      width: 2,
      color: ring,
      radius: AsnRadius.brConcentric(childRadius, _focusOffset),
      offset: _focusOffset,
    );

    return ShadThemeData(
      colorScheme: AsnColorScheme.fromSemantic(colors),
      brightness: colors.brightness,
      radius: AsnRadius.brMd,
      textTheme: AsnTextTheme.build(),
      // Global ring for md-radius elements (inputs, select, textarea,
      // buttons).
      decoration: ShadDecoration(
        secondaryFocusedBorder: focusRing(AsnRadius.md),
      ),
      // The active tab uses sm radius (8) to stay concentric within the
      // track (md radius); the focus ring goes to 8 + offset.
      tabsTheme: ShadTabsTheme(
        tabDecoration: ShadDecoration(
          border: ShadBorder.all(radius: AsnRadius.brSm, width: 0),
          secondaryFocusedBorder: focusRing(AsnRadius.sm),
        ),
      ),
      // The active menu button uses sm radius (8) for its corners; we also
      // enable the concentric focus ring (shadcn disables it).
      menubarTheme: ShadMenubarTheme(
        buttonDecoration: ShadDecoration(
          disableSecondaryBorder: false,
          border: ShadBorder.all(radius: AsnRadius.brSm, width: 0),
          secondaryFocusedBorder: focusRing(AsnRadius.sm),
        ),
      ),
      // Highlighted options sit inside a md-radius (12) popover with 4px of
      // options padding, so their own radius must drop to sm (12 - 4 = 8) to
      // stay concentric; otherwise the square-ish corners poke out.
      optionTheme: const ShadOptionTheme(radius: AsnRadius.brSm),
      // Items defaulted their highlight radius to the menu radius (md, 12), so
      // their corners poked out. Drop them to sm (8) to nest inside the menu.
      contextMenuTheme: ShadContextMenuTheme(
        itemDecoration: ShadDecoration(
          border: ShadBorder.all(radius: AsnRadius.brSm, width: 0),
        ),
      ),
    );
  }

  /// Active semantic colors. Requires an ancestor [AsnThemeScope]
  /// (injected by `AsnApp`).
  static AsnSemanticColors of(BuildContext context) {
    final colors = AsnThemeScope.maybeOf(context);
    assert(
      colors != null,
      'No AsnThemeScope found. Wrap the app in AsnApp or place an '
      'AsnThemeScope under your ShadApp.',
    );
    return colors!;
  }

  /// Same as [of] but returns null if there is no scope.
  static AsnSemanticColors? maybeOf(BuildContext context) =>
      AsnThemeScope.maybeOf(context);
}
