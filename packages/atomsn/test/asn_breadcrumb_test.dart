import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart' as shad;

Widget _host(Widget child) => AsnApp(home: Center(child: child));

void main() {
  testWidgets('AsnBreadcrumb renders its links', (tester) async {
    await tester.pumpWidget(
      _host(
        AsnBreadcrumb(
          items: [
            AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
            AsnBreadcrumbItem(label: const Text('Components'), onTap: () {}),
            const AsnBreadcrumbItem(label: Text('Breadcrumb')),
          ],
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Components'), findsOneWidget);
    expect(find.text('Breadcrumb'), findsOneWidget);
  });

  testWidgets('AsnBreadcrumb places a custom separator between items', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        AsnBreadcrumb(
          separator: const Text('/'),
          items: [
            AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
            AsnBreadcrumbItem(label: const Text('Components'), onTap: () {}),
            const AsnBreadcrumbItem(label: Text('Breadcrumb')),
          ],
        ),
      ),
    );

    // One separator between each of the three items.
    expect(find.text('/'), findsNWidgets(2));
  });

  testWidgets('AsnBreadcrumb.dropdown shows a labelled trigger with a chevron', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        AsnBreadcrumb(
          items: [
            AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
            AsnBreadcrumbItem.dropdown(
              trigger: const Text('Components'),
              menuItems: [
                AsnBreadcrumbMenuItem(label: const Text('Themes'), onTap: () {}),
              ],
            ),
            const AsnBreadcrumbItem(label: Text('Breadcrumb')),
          ],
        ),
      ),
    );

    expect(find.byType(shad.ShadBreadcrumbDropdown), findsOneWidget);
    expect(find.text('Components'), findsOneWidget);
    expect(_chevron(), findsOneWidget);
  });

  testWidgets('AsnBreadcrumb.ellipsis with a menu hides the dropdown chevron', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        AsnBreadcrumb(
          items: [
            AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
            AsnBreadcrumbItem.ellipsis(
              menuItems: [
                AsnBreadcrumbMenuItem(label: const Text('Themes'), onTap: () {}),
              ],
            ),
            const AsnBreadcrumbItem(label: Text('Breadcrumb')),
          ],
        ),
      ),
    );

    // It opens a dropdown built around the ellipsis indicator, but the "…"
    // must stand alone without the dropdown chevron next to it.
    expect(find.byType(shad.ShadBreadcrumbDropdown), findsOneWidget);
    expect(find.byType(shad.ShadBreadcrumbEllipsis), findsOneWidget);
    expect(_chevron(), findsNothing);
  });

  testWidgets('dropdown menu items nest with a concentric sm radius', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        AsnBreadcrumb(
          items: [
            AsnBreadcrumbItem(label: const Text('Home'), onTap: () {}),
            AsnBreadcrumbItem.dropdown(
              trigger: const Text('Components'),
              menuItems: [
                AsnBreadcrumbMenuItem(label: const Text('Docs'), onTap: () {}),
                AsnBreadcrumbMenuItem(label: const Text('Themes'), onTap: () {}),
              ],
            ),
            const AsnBreadcrumbItem(label: Text('End')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Components'));
    await tester.pumpAndSettle();

    // Items must round to sm (8), not the md (12) of the menu they sit in.
    expect(_highlightRadius(tester, 'Docs'), AsnRadius.brSm);
    expect(_highlightRadius(tester, 'Themes'), AsnRadius.brSm);
  });
}

/// The dropdown chevron icon used by `ShadBreadcrumbDropdown`.
Finder _chevron() => find.byWidgetPredicate(
  (w) => w is HugeIcon && w.icon == HugeIcons.strokeRoundedArrowDown01,
);

/// Closest rounded `DecoratedBox` ancestor radius of the widget showing [label].
BorderRadius? _highlightRadius(WidgetTester tester, String label) {
  for (final box in tester.widgetList<DecoratedBox>(
    find.ancestor(of: find.text(label), matching: find.byType(DecoratedBox)),
  )) {
    final decoration = box.decoration;
    if (decoration is BoxDecoration && decoration.borderRadius != null) {
      return decoration.borderRadius as BorderRadius?;
    }
  }
  return null;
}
