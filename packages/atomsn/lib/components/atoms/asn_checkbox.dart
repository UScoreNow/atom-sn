import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Controlled checkbox. Wraps `ShadCheckbox`.
class AsnCheckbox extends StatelessWidget {
  const AsnCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.sublabel,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? label;
  final Widget? sublabel;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ShadCheckbox(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      label: label,
      sublabel: sublabel,
      // Tick from Hugeicons (the system's single library) instead of shadcn's
      // default Lucide check. Color = primaryForeground (ink over fill).
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedTick02,
        size: 14,
        strokeWidth: 2,
        color: ShadTheme.of(context).colorScheme.primaryForeground,
      ),
      // The checkbox stays centered with the primary label; the sublabel
      // renders below it (handled by the fork's layout).
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
