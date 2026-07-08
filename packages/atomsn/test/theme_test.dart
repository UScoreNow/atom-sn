import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('AtomSN preset respects the system hard rules', () {
    // No pure black or white.
    const forbidden = [Color(0xFF000000), Color(0xFFFFFFFF)];
    for (final c in [AsnColors.light, AsnColors.dark]) {
      expect(forbidden.contains(c.bgBase), isFalse);
      expect(forbidden.contains(c.textPrimary), isFalse);
    }
    // Correct brightnesses.
    expect(AsnColors.light.brightness, Brightness.light);
    expect(AsnColors.dark.brightness, Brightness.dark);
  });

  test('AsnColorScheme derives ShadColorScheme from the semantic roles', () {
    final scheme = AsnColorScheme.fromSemantic(AsnColors.light);
    expect(scheme.background, AsnColors.light.bgBase);
    expect(scheme.primary, AsnColors.light.actionPrimary);
    // Extra editorial roles travel in the custom map.
    expect(scheme.custom['link'], AsnColors.light.link);
    expect(scheme.custom['warning'], AsnColors.light.statusWarning);
  });

  test('Dropdown menu items nest with a concentric sm radius', () {
    final theme = AsnTheme.buildTheme(AsnColors.light);
    // Options and context-menu items sit in a md (12) menu, so their own
    // highlight radius drops to sm (8) to nest instead of poking out.
    expect(theme.optionTheme.radius, AsnRadius.brSm);
    expect(theme.contextMenuTheme.itemDecoration?.border?.radius, AsnRadius.brSm);
  });

  testWidgets('AsnTheme.of returns the active mode colors under AsnApp', (
    tester,
  ) async {
    late AsnSemanticColors seen;
    await tester.pumpWidget(
      AsnApp(
        home: Builder(
          builder: (context) {
            seen = AsnTheme.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(seen.brightness, Brightness.light);
    expect(seen.bgBase, AsnColors.light.bgBase);
  });

  testWidgets('Plain text inherits the ElmsSans family from the theme', (
    tester,
  ) async {
    late TextStyle defaultStyle;
    await tester.pumpWidget(
      AsnApp(
        home: Builder(
          builder: (context) {
            defaultStyle = DefaultTextStyle.of(context).style;
            return const Text('x');
          },
        ),
      ),
    );
    // Without the family in the app root textStyle, a plain Text fell back to
    // the system font (Roboto) instead of ElmsSans.
    expect(defaultStyle.fontFamily, AsnTextTheme.fontFamily);
  });
}
