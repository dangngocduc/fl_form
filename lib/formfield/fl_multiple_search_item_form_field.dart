import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/dialog/fl_search_page.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class FlMultipleSearchItemFormField<T> extends FormField<List<T>> {
  final OnSearch<T> onSearch;

  FlMultipleSearchItemFormField({
    super.key,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    super.validator,
    super.onSaved,
    ValueChanged<List<T>?>? onChanged,
    ValueChanged<T>? onDelete,
    super.autovalidateMode,
    EdgeInsetsGeometry? contentPadding,
    super.enabled,
    super.initialValue,
    required this.onSearch,
    String? helperText,
    bool isRequired = false,
  }) : super(
         builder: (field) {
           final state = field as FlMultipleSearchItemFormFieldState<T>;
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             onTap: enabled
                 ? () {
                     Navigator.push<T>(
                       state.context,
                       _MaterialTransparentRoute(
                         builder: (context) {
                           return FlSearchPage<T>(builder: builder, onSearch: onSearch);
                         },
                       ),
                     ).then((value) {
                       if (value != null) {
                         List<T> v = state.value ?? [];
                         v.add(value);
                         onChanged?.call(v);
                         state.didChange(v);
                       }
                     });
                   }
                 : null,
             helperText: helperText,
             errorText: state.errorText,
             content: state.value == null || state.value!.isEmpty
                 ? null
                 : Wrap(
                     spacing: 4,
                     runSpacing: 4,
                     children: state.value!
                         .map(
                           (v) => Chip(
                             onDeleted: onDelete != null
                                 ? () {
                                     onDelete(v);
                                   }
                                 : null,
                             label: builder.buildForContent(state.context, FormFieldOption(value: v)),
                           ),
                         )
                         .toList(),
                   ),
             suffixIcon: const Icon(Icons.keyboard_arrow_down),
           );
         },
       );

  @override
  FormFieldState<List<T>> createState() {
    return FlMultipleSearchItemFormFieldState<T>();
  }
}

//////////////////////////////////////////////////////////////////////////////

class FlMultipleSearchItemFormFieldState<T> extends FormFieldState<List<T>> {
  @override
  FlMultipleSearchItemFormField<T> get widget => super.widget as FlMultipleSearchItemFormField<T>;

  @override
  void didUpdateWidget(covariant FormField<List<T>> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
    }
  }
}

//////////////////////////////////////////////////////////////////////////////

class _MaterialTransparentRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  _MaterialTransparentRoute({required this.builder, super.settings, this.maintainState = true, super.fullscreenDialog});

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool get opaque => false;

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
