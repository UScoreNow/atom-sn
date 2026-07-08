import 'package:atomsn/atomsn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => AsnApp(home: Center(child: child));

void main() {
  testWidgets('AsnTooltip opens on hover over a plain child', (tester) async {
    await tester.pumpWidget(
      _host(
        const AsnTooltip(
          message: 'Help text',
          child: Text('Trigger'),
        ),
      ),
    );

    expect(find.text('Help text'), findsNothing);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);
    await tester.pump();

    await gesture.moveTo(tester.getCenter(find.text('Trigger')));
    await tester.pumpAndSettle();

    expect(find.text('Help text'), findsOneWidget);
  });

  testWidgets('AsnPopover renders its content in the ElmsSans family', (
    tester,
  ) async {
    String? family;
    await tester.pumpWidget(
      _host(
        AsnPopover(
          visible: true,
          popover: Builder(
            builder: (context) {
              family = DefaultTextStyle.of(context).style.fontFamily;
              return const Text('Popover content');
            },
          ),
          child: const Text('Anchor'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Popover content'), findsOneWidget);
    expect(family, AsnTextTheme.fontFamily);
  });
}
