import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class FlTimeFormField extends FormField<TimeOfDay> {
  FlTimeFormField({
    super.validator,
    super.onSaved,
    ValueChanged<TimeOfDay?>? onChanged,
    super.autovalidateMode,
    super.initialValue,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    Widget? prefixIcon,
    bool enabled = true,
    String? helperText,
    super.key,
  }) : super(
         builder: (field) {
           final state = field as FlTimeFormFieldState;
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             onTap: enabled
                 ? () {
                     showTimePicker(context: state.context, initialTime: state.value ?? TimeOfDay.now()).then((value) {
                       if (value != null) {
                         state.didChange(value);
                         if (onChanged != null) {
                           onChanged(value);
                         }
                       }
                     });
                   }
                 : null,
             //             autofocus: autofocus,
             content: Text(state.value == null ? 'HH:MM' : state.value!.format(state.context)),
           );
         },
       );
  @override
  FlTimeFormFieldState createState() => FlTimeFormFieldState();
}

class FlTimeFormFieldState extends FormFieldState<TimeOfDay> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
