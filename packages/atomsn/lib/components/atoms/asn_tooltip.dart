import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Text tooltip over [child]. Wraps `ShadTooltip`.
///
/// `ShadTooltip` is driven by the hover/long-press of a `ShadGestureDetector`
/// in its subtree; plain children (text, icons, badges) provide none, so the
/// tooltip never opens. The child is wrapped in a bare `ShadGestureDetector`
/// here so the tooltip triggers on hover (and long-press) for any content.
class AsnTooltip extends StatelessWidget {
  const AsnTooltip({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShadTooltip(
      builder: (context) => Text(message),
      child: ShadGestureDetector(child: child),
    );
  }
}
