import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../theme/asn_text_theme.dart';

/// Floating panel anchored to a [child]. Wraps `ShadPopover`.
///
/// Controlled: visibility is dictated by [visible] and changes (including
/// closing by tapping outside) are reported via [onVisibleChanged]. An internal
/// `ShadPopoverController` is managed to keep the API controlled.
class AsnPopover extends StatefulWidget {
  const AsnPopover({
    super.key,
    required this.child,
    required this.popover,
    this.visible = false,
    this.onVisibleChanged,
  });

  final Widget child;
  final Widget popover;
  final bool visible;
  final ValueChanged<bool>? onVisibleChanged;

  @override
  State<AsnPopover> createState() => _AsnPopoverState();
}

class _AsnPopoverState extends State<AsnPopover> {
  late final ShadPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShadPopoverController(isOpen: widget.visible);
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(AsnPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != _controller.isOpen) {
      widget.visible ? _controller.show() : _controller.hide();
    }
  }

  void _handleControllerChanged() {
    if (_controller.isOpen != widget.visible) {
      widget.onVisibleChanged?.call(_controller.isOpen);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      controller: _controller,
      // ShadPopover wraps the content in a DefaultTextStyle that sets only the
      // color, replacing the ambient style and dropping the ElmsSans family.
      // Re-apply the family so popover text matches the rest of the system.
      popover: (context) => DefaultTextStyle.merge(
        style: const TextStyle(fontFamily: AsnTextTheme.fontFamily),
        child: widget.popover,
      ),
      child: widget.child,
    );
  }
}
