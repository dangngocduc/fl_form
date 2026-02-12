import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

/// Checkbox with tristate support
class FlCheckboxFormField extends FormField<bool?> {
  FlCheckboxFormField({
    super.key,
    EdgeInsetsGeometry? padding,
    super.initialValue = false,
    double spacing = 0,
    bool iconAtStart = false,
    required String label,
    super.enabled,
    bool isRequired = false,
    super.autovalidateMode,
    super.onSaved,
    ValueChanged<bool?>? onChanged,
    super.validator,
    super.restorationId,
    bool tristate = false,
    String? helperText,
  }) : super(
         builder: (state) {
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             //             autofocus: autofocus,
             content: Row(
               children: [
                 Checkbox(
                   value: state.value,
                   onChanged: enabled
                       ? (value) {
                           onChanged?.call(value);
                           state.didChange(value);
                         }
                       : null,
                   tristate: tristate,
                 ),
               ],
             ),
           );
         },
       );
}
