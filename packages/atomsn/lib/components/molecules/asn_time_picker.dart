import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Day period of the 12-hour [AsnTimePicker.period] variant. Adapts
/// `ShadDayPeriod` without leaking it in the public API.
enum AsnDayPeriod { am, pm }

/// Simple time exposed by [AsnTimePicker]. Own model that adapts
/// `ShadTimeOfDay` without leaking it in the public API.
@immutable
class AsnTime {
  const AsnTime({
    required this.hour,
    required this.minute,
    this.second = 0,
    this.period,
  });

  final int hour;
  final int minute;
  final int second;

  /// Only set by the 12-hour [AsnTimePicker.period] variant; null otherwise.
  final AsnDayPeriod? period;
}

ShadDayPeriod? _toShadPeriod(AsnDayPeriod? period) => switch (period) {
  AsnDayPeriod.am => ShadDayPeriod.am,
  AsnDayPeriod.pm => ShadDayPeriod.pm,
  null => null,
};

AsnDayPeriod _fromShadPeriod(ShadDayPeriod period) =>
    period == ShadDayPeriod.am ? AsnDayPeriod.am : AsnDayPeriod.pm;

ShadTimeOfDay? _toShadTime(AsnTime? time) => time == null
    ? null
    : ShadTimeOfDay(
        hour: time.hour,
        minute: time.minute,
        second: time.second,
        period: _toShadPeriod(time.period),
      );

AsnTime _fromShadTime(ShadTimeOfDay time, {required bool withPeriod}) => AsnTime(
  hour: time.hour,
  minute: time.minute,
  second: time.second,
  period: withPeriod ? _fromShadPeriod(time.period) : null,
);

/// Controlled time picker. Wraps `ShadTimePicker`.
///
/// The default constructor is the 24-hour variant; [AsnTimePicker.period] is
/// the 12-hour variant with an AM/PM segment.
class AsnTimePicker extends StatelessWidget {
  const AsnTimePicker({
    super.key,
    this.value,
    this.onChanged,
    this.enabled = true,
  }) : _period = false;

  /// 12-hour variant with an AM/PM segment. Its [onChanged] reports the chosen
  /// [AsnTime.period].
  const AsnTimePicker.period({
    super.key,
    this.value,
    this.onChanged,
    this.enabled = true,
  }) : _period = true;

  final AsnTime? value;
  final ValueChanged<AsnTime>? onChanged;
  final bool enabled;

  final bool _period;

  @override
  Widget build(BuildContext context) {
    final onChanged = this.onChanged;
    void handle(ShadTimeOfDay time) =>
        onChanged?.call(_fromShadTime(time, withPeriod: _period));

    if (_period) {
      return ShadTimePicker.period(
        enabled: enabled,
        initialValue: _toShadTime(value),
        onChanged: onChanged == null ? null : handle,
      );
    }
    return ShadTimePicker(
      enabled: enabled,
      initialValue: _toShadTime(value),
      onChanged: onChanged == null ? null : handle,
    );
  }
}
