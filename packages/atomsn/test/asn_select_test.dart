import 'package:atomsn/atomsn.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => AsnApp(home: Center(child: child));

const _teams = <AsnSelectOption<String>>[
  AsnSelectOption(value: 'avengers', label: 'The Avengers'),
  AsnSelectOption(value: 'liga', label: 'Justice League'),
  AsnSelectOption(value: 'guardianes', label: 'Guardians of the Galaxy'),
];

/// Opens [trigger]'s popover and taps the option labelled [option].
Future<void> _pick(
  WidgetTester tester, {
  required String trigger,
  required String option,
}) async {
  await tester.tap(find.text(trigger));
  await tester.pumpAndSettle();
  await tester.tap(find.text(option).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('AsnSelect reports the picked value and shows its label', (
    tester,
  ) async {
    String? picked;
    await tester.pumpWidget(
      _host(
        AsnSelect<String>(
          options: _teams,
          placeholder: 'Select a team',
          onChanged: (value) => picked = value,
        ),
      ),
    );

    await _pick(tester, trigger: 'Select a team', option: 'The Avengers');

    expect(picked, 'avengers');
    expect(find.text('The Avengers'), findsOneWidget);
    expect(find.text('Select a team'), findsNothing);
  });

  testWidgets('AsnSelect.withSearch reports the picked value', (tester) async {
    String? picked;
    await tester.pumpWidget(
      _host(
        AsnSelect<String>.withSearch(
          options: _teams,
          placeholder: 'Search a team',
          onChanged: (value) => picked = value,
        ),
      ),
    );

    await _pick(tester, trigger: 'Search a team', option: 'Justice League');

    expect(picked, 'liga');
  });

  testWidgets('AsnSelect.withSearch filters the options by their label', (
    tester,
  ) async {
    var lastQuery = '';
    await tester.pumpWidget(
      _host(
        AsnSelect<String>.withSearch(
          options: _teams,
          placeholder: 'Search a team',
          onSearchChanged: (value) => lastQuery = value,
        ),
      ),
    );

    await tester.tap(find.text('Search a team'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), 'just');
    await tester.pumpAndSettle();

    // Only the matching option stays visible; the query is reported out too.
    expect(lastQuery, 'just');
    expect(find.text('Justice League'), findsOneWidget);
    expect(find.text('The Avengers'), findsNothing);
    expect(find.text('Guardians of the Galaxy'), findsNothing);

    // A query that matches nothing falls back to the empty-state row.
    await tester.enterText(find.byType(EditableText), 'zzz');
    await tester.pumpAndSettle();
    expect(find.text('No results'), findsOneWidget);
  });

  testWidgets('AsnMultiSelect stays open and accumulates picks', (
    tester,
  ) async {
    List<String>? picked;
    await tester.pumpWidget(
      _host(
        AsnMultiSelect<String>(
          options: _teams,
          placeholder: 'Select teams',
          onChanged: (values) => picked = values,
        ),
      ),
    );

    await tester.tap(find.text('Select teams'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('The Avengers').last);
    await tester.pumpAndSettle();
    expect(picked, ['avengers']);

    // closeOnSelect is false: the popover is still open, so the remaining
    // options stay tappable without reopening.
    expect(find.text('Justice League'), findsOneWidget);
    await tester.tap(find.text('Guardians of the Galaxy').last);
    await tester.pumpAndSettle();
    expect(picked, ['avengers', 'guardianes']);
  });

  testWidgets('AsnSelect renders and picks from a long, scrollable list', (
    tester,
  ) async {
    final zones = [
      for (var i = 0; i < 20; i++)
        AsnSelectOption(value: 'tz$i', label: 'Timezone $i'),
    ];
    String? picked;
    await tester.pumpWidget(
      _host(
        AsnSelect<String>(
          options: zones,
          placeholder: 'Select a timezone',
          onChanged: (value) => picked = value,
        ),
      ),
    );

    await _pick(tester, trigger: 'Select a timezone', option: 'Timezone 0');
    expect(picked, 'tz0');
  });

  testWidgets('sibling AsnSelect variants keep independent selections', (
    tester,
  ) async {
    await tester.pumpWidget(_host(const _TwoSelects()));

    await _pick(tester, trigger: 'First', option: 'The Avengers');

    // The first now shows its pick; the second is untouched.
    expect(find.text('The Avengers'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);

    await _pick(tester, trigger: 'Second', option: 'Justice League');

    // Both selections coexist; neither overwrote the other.
    expect(find.text('The Avengers'), findsOneWidget);
    expect(find.text('Justice League'), findsOneWidget);
  });
}

/// Two single selects, each bound to its own state, mirroring the demo screen.
class _TwoSelects extends StatefulWidget {
  const _TwoSelects();

  @override
  State<_TwoSelects> createState() => _TwoSelectsState();
}

class _TwoSelectsState extends State<_TwoSelects> {
  String? _first;
  String? _second;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AsnSelect<String>(
          value: _first,
          placeholder: 'First',
          options: _teams,
          onChanged: (value) => setState(() => _first = value),
        ),
        AsnSelect<String>(
          value: _second,
          placeholder: 'Second',
          options: _teams,
          onChanged: (value) => setState(() => _second = value),
        ),
      ],
    );
  }
}
