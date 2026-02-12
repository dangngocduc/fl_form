import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class FlSegmentedButtonFormField<T> extends FormField<Set<T>> {
  FlSegmentedButtonFormField({
    super.key,
    required String label,
    bool isRequired = false,
    super.validator,
    super.initialValue,
    required List<FormFieldOption<T>> options,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    super.autovalidateMode,
    super.onSaved,
    ValueChanged<Set<T>>? onChanged,
    super.restorationId,
    super.enabled = true,
    String? helperText,
    String? placeholderText,
    bool vertical = true,
    bool multiSelectionEnabled = false,
  }) : super(
         builder: (state) {
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             helperText: helperText,
             errorText: state.errorText,
             content: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: SegmentedButton<T>(
                 emptySelectionAllowed: !isRequired,
                 multiSelectionEnabled: multiSelectionEnabled,
                 segments: options
                     .map((toElement) => ButtonSegment<T>(label: builder.buildForContent(state.context, toElement), value: toElement.value))
                     .toList(),
                 selected: state.value ?? {},
                 onSelectionChanged: enabled
                     ? (value) {
                         state.didChange(value);
                         onChanged?.call(value);
                       }
                     : null,
               ),
             ),
           );
         },
       );
}
