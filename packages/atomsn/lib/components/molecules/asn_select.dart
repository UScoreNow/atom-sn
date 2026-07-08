import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Option of an [AsnSelect] / [AsnMultiSelect]. Own model (no `Shad*` leak).
@immutable
class AsnSelectOption<T> {
  const AsnSelectOption({required this.value, required this.label});

  final T value;
  final String label;
}

/// Dimmed Hugeicons chevron shared by the select variants, instead of
/// shadcn's default Lucide chevronDown.
Widget asnSelectTrailing(BuildContext context) => HugeIcon(
  icon: HugeIcons.strokeRoundedArrowDown01,
  size: 16,
  strokeWidth: 1.5,
  color: ShadTheme.of(context).colorScheme.foreground.withValues(alpha: .5),
);

/// Builds the popover option widgets for a select.
///
/// Mirrors shadcn's search pattern: every option stays mounted and the ones
/// that do not match [query] are hidden with [Offstage] (keeps focus stable as
/// results change). When [searchable] is false [query] is ignored and the raw
/// options are returned. A "no results" row is appended when nothing matches.
List<Widget> _optionWidgets<T>(
  List<AsnSelectOption<T>> options,
  String query, {
  required bool searchable,
}) {
  ShadOption<T> option(AsnSelectOption<T> o) =>
      ShadOption<T>(value: o.value, child: Text(o.label));

  if (!searchable) return [for (final o in options) option(o)];

  final normalized = query.trim().toLowerCase();
  final widgets = <Widget>[];
  var anyVisible = false;
  for (final o in options) {
    final matches = o.label.toLowerCase().contains(normalized);
    anyVisible |= matches;
    widgets.add(Offstage(offstage: !matches, child: option(o)));
  }
  if (!anyVisible) {
    widgets.add(
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('No results', textAlign: TextAlign.center),
      ),
    );
  }
  return widgets;
}

/// Controlled single-value dropdown selector. Wraps `ShadSelect`.
///
/// Use [AsnSelect.withSearch] to add a search field that filters the options by
/// their label as the user types (and also reports the query through
/// [onSearchChanged]); for multi-value selection see [AsnMultiSelect].
class AsnSelect<T> extends StatefulWidget {
  const AsnSelect({
    super.key,
    required this.options,
    this.value,
    this.placeholder,
    this.onChanged,
    this.enabled = true,
  }) : searchable = false,
       onSearchChanged = null,
       searchPlaceholder = null;

  /// Single-value selector with a search field at the top of the popover that
  /// filters the options by their label.
  const AsnSelect.withSearch({
    super.key,
    required this.options,
    this.value,
    this.placeholder,
    this.onChanged,
    this.enabled = true,
    this.onSearchChanged,
    this.searchPlaceholder,
  }) : searchable = true;

  final List<AsnSelectOption<T>> options;
  final T? value;
  final String? placeholder;
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  /// Called with the search query as the user types (only with [withSearch]).
  /// The options are filtered internally regardless of this callback.
  final ValueChanged<String>? onSearchChanged;
  final String? searchPlaceholder;

  final bool searchable;

  @override
  State<AsnSelect<T>> createState() => _AsnSelectState<T>();
}

class _AsnSelectState<T> extends State<AsnSelect<T>> {
  String _query = '';

  void _onSearchChanged(String value) {
    setState(() => _query = value);
    widget.onSearchChanged?.call(value);
  }

  Widget _selected(BuildContext context, T selected) {
    for (final option in widget.options) {
      if (option.value == selected) return Text(option.label);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget.placeholder;
    final options = _optionWidgets(
      widget.options,
      _query,
      searchable: widget.searchable,
    );

    if (widget.searchable) {
      final searchPlaceholder = widget.searchPlaceholder;
      return ShadSelect<T>.withSearch(
        enabled: widget.enabled,
        initialValue: widget.value,
        placeholder: placeholder == null ? null : Text(placeholder),
        searchPlaceholder: searchPlaceholder == null
            ? null
            : Text(searchPlaceholder),
        onChanged: widget.onChanged,
        onSearchChanged: _onSearchChanged,
        trailing: asnSelectTrailing(context),
        options: options,
        selectedOptionBuilder: _selected,
      );
    }
    return ShadSelect<T>(
      enabled: widget.enabled,
      initialValue: widget.value,
      placeholder: placeholder == null ? null : Text(placeholder),
      onChanged: widget.onChanged,
      trailing: asnSelectTrailing(context),
      options: options,
      selectedOptionBuilder: _selected,
    );
  }
}

/// Controlled multi-value dropdown selector. Wraps `ShadSelect.multiple`.
///
/// The popover stays open while picking (shadcn's multi-select behaviour). Use
/// [AsnMultiSelect.withSearch] to add a search field that filters the options
/// by their label (and reports the query through [onSearchChanged]).
class AsnMultiSelect<T> extends StatefulWidget {
  const AsnMultiSelect({
    super.key,
    required this.options,
    this.values = const [],
    this.placeholder,
    this.onChanged,
    this.enabled = true,
  }) : searchable = false,
       onSearchChanged = null,
       searchPlaceholder = null;

  /// Multi-value selector with a search field at the top of the popover that
  /// filters the options by their label.
  const AsnMultiSelect.withSearch({
    super.key,
    required this.options,
    this.values = const [],
    this.placeholder,
    this.onChanged,
    this.enabled = true,
    this.onSearchChanged,
    this.searchPlaceholder,
  }) : searchable = true;

  final List<AsnSelectOption<T>> options;
  final List<T> values;
  final String? placeholder;
  final ValueChanged<List<T>>? onChanged;
  final bool enabled;

  /// Called with the search query as the user types (only with [withSearch]).
  /// The options are filtered internally regardless of this callback.
  final ValueChanged<String>? onSearchChanged;
  final String? searchPlaceholder;

  final bool searchable;

  @override
  State<AsnMultiSelect<T>> createState() => _AsnMultiSelectState<T>();
}

class _AsnMultiSelectState<T> extends State<AsnMultiSelect<T>> {
  String _query = '';

  void _onSearchChanged(String value) {
    setState(() => _query = value);
    widget.onSearchChanged?.call(value);
  }

  void Function(Set<T>)? get _onChanged => widget.onChanged == null
      ? null
      : (set) => widget.onChanged!(set.toList());

  Widget _selected(BuildContext context, List<T> selected) {
    final labels = <String>[];
    for (final option in widget.options) {
      if (selected.contains(option.value)) labels.add(option.label);
    }
    return Text(labels.join(', '));
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = widget.placeholder;
    final options = _optionWidgets(
      widget.options,
      _query,
      searchable: widget.searchable,
    );

    if (widget.searchable) {
      final searchPlaceholder = widget.searchPlaceholder;
      return ShadSelect<T>.multipleWithSearch(
        enabled: widget.enabled,
        closeOnSelect: false,
        initialValues: widget.values.toSet(),
        placeholder: placeholder == null ? null : Text(placeholder),
        searchPlaceholder: searchPlaceholder == null
            ? null
            : Text(searchPlaceholder),
        onChanged: _onChanged,
        onSearchChanged: _onSearchChanged,
        trailing: asnSelectTrailing(context),
        options: options,
        selectedOptionsBuilder: _selected,
      );
    }
    return ShadSelect<T>.multiple(
      enabled: widget.enabled,
      closeOnSelect: false,
      initialValues: widget.values.toSet(),
      placeholder: placeholder == null ? null : Text(placeholder),
      onChanged: _onChanged,
      trailing: asnSelectTrailing(context),
      options: options,
      selectedOptionsBuilder: _selected,
    );
  }
}
