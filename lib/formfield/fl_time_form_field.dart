import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlTimeFormField extends FormField<TimeOfDay> {
  FlTimeFormField({
    FormFieldValidator<TimeOfDay>? validator,
    FormFieldSetter<TimeOfDay>? onSaved,
    AutovalidateMode? autovalidateMode,
    TimeOfDay? initialValue,
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
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {
                   showTimePicker(context: state.context, initialTime: state.value ?? TimeOfDay.now()).then((value) {
                     if (value != null) {
                       state.didChange(value);
                     }
                   });
                 },
                 child: InputDecorator(
                   decoration: InputDecorationBuilder(
                     enabled: enabled,
                     hasError: state.hasError,
                     helperText: helperText,
                     placeholderText: placeholderText,
                     prefixIcon: prefixIcon,
                   ).create(field.context),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : Text(state.value!.format(state.context), style: Theme.of(field.context).extension<FlFormFieldTheme>()?.style),
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
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
