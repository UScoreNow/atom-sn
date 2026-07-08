import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_ui/shadcn_ui.dart' as shad;

Widget _host(Widget child) => AsnApp(home: Center(child: child));

void main() {
  testWidgets('AsnTimePicker renders the 24-hour variant without a period', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(const AsnTimePicker(value: AsnTime(hour: 9, minute: 30))),
    );

    expect(find.byType(shad.ShadTimePicker), findsOneWidget);
    // No AM/PM selector in the 24-hour variant.
    expect(find.byType(shad.ShadSelect<shad.ShadDayPeriod>), findsNothing);
  });

  testWidgets('AsnTimePicker.period renders the AM/PM selector', (tester) async {
    await tester.pumpWidget(
      _host(
        const AsnTimePicker.period(
          value: AsnTime(hour: 9, minute: 30, period: AsnDayPeriod.pm),
        ),
      ),
    );

    expect(find.byType(shad.ShadTimePicker), findsOneWidget);
    // The period variant adds an AM/PM select that the 24-hour one lacks.
    expect(find.byType(shad.ShadSelect<shad.ShadDayPeriod>), findsOneWidget);
  });
}
