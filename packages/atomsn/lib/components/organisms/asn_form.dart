import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// When the form fields auto-validate. Mirrors `ShadAutovalidateMode`.
enum AsnAutovalidateMode {
  /// Never auto-validate; only on explicit `validate()`.
  disabled,

  /// Auto-validate every field always.
  always,

  /// Auto-validate a field once it has been validated once.
  onUserInteraction,
}

ShadAutovalidateMode _toShadAutovalidate(AsnAutovalidateMode mode) =>
    switch (mode) {
      AsnAutovalidateMode.disabled => ShadAutovalidateMode.disabled,
      AsnAutovalidateMode.always => ShadAutovalidateMode.always,
      AsnAutovalidateMode.onUserInteraction =>
        ShadAutovalidateMode.alwaysAfterFirstValidation,
    };

/// Handle to the nearest [AsnForm], obtained with [AsnForm.of]. Thin wrapper
/// over `ShadFormState` that exposes validation/save/reset without leaking it.
class AsnFormHandle {
  const AsnFormHandle(this._state);

  final ShadFormState _state;

  /// Current values keyed by each field `id`.
  Map<String, dynamic> get value => _state.value;

  /// Validates every field; returns whether all are valid.
  bool validate() => _state.validate();

  /// Runs each field's `onSaved`.
  void save() => _state.save();

  /// Saves then validates; returns whether all are valid.
  bool saveAndValidate() => _state.saveAndValidate();

  /// Resets every field to its initial value.
  void reset() => _state.reset();
}

/// Form container that collects and validates its `AsnXFormField` descendants.
/// Wraps `ShadForm`.
///
/// Reach the form state from a descendant with `AsnForm.of(context)` to
/// validate, save or reset.
class AsnForm extends StatelessWidget {
  const AsnForm({
    super.key,
    required this.child,
    this.onChanged,
    this.enabled = true,
    this.initialValue = const {},
    this.autovalidateMode = AsnAutovalidateMode.onUserInteraction,
  });

  final Widget child;
  final VoidCallback? onChanged;
  final bool enabled;
  final Map<String, dynamic> initialValue;
  final AsnAutovalidateMode autovalidateMode;

  /// The nearest [AsnFormHandle] above [context].
  static AsnFormHandle of(BuildContext context) =>
      AsnFormHandle(ShadForm.of(context));

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      autovalidateMode: _toShadAutovalidate(autovalidateMode),
      child: child,
    );
  }
}
