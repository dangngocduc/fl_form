import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

/// A form field that displays a switch to toggle a boolean value.
///
/// The [FlSwitchFormField] is a simple and effective way to get a true/false
/// input from the user. It is designed to be used within a [Form] and supports
/// validation and error handling.
class FlSwitchFormField extends FormField<bool> {
  /// Creates a new instance of [FlSwitchFormField].
  ///
  /// The [label] is a required string that describes the switch field.
  /// The [initialValue] sets the initial state of the switch.
  /// The [onChanged] callback is triggered when the switch is toggled.
  FlSwitchFormField({
    super.key,
    super.initialValue = false,
    ValueChanged<bool>? onChanged,
    required String label,
    super.enabled,
    bool isRequired = false,
    super.autovalidateMode,
    super.onSaved,
    super.validator,
    super.restorationId,
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
                 Switch(
                   padding: EdgeInsets.zero,
                   value: state.value ?? false,
                   onChanged: enabled
                       ? (value) {
                           state.didChange(value);
                           onChanged?.call(value);
                         }
                       : null,
                 ),
               ],
             ),
           );
         },
       );
}
