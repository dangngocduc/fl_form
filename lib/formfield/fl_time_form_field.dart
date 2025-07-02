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
    super.key,
  }) : super(
         builder: (field) {
           final state = field as FlTimeFormFieldState;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 4),
                 child: RichText(
                   text: TextSpan(
                     style: Theme.of(field.context).extension<FlFormFieldTheme>()?.labelStyle,
                     children: [
                       TextSpan(text: label),
                       if (isRequired)
                         TextSpan(
                           text: ' *',
                           style: Theme.of(field.context).extension<FlFormFieldTheme>()?.labelStyle.copyWith(color: Colors.red),
                         ),
                     ],
                   ),
                 ),
               ),
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
                   decoration: InputDecoration(
                     hintText: placeholderText,
                     prefixIcon: prefixIcon,
                     enabledBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                     focusedBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                     border: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   ).applyDefaults(Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(field.context).inputDecorationTheme),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : Text(state.value!.format(state.context), style: Theme.of(field.context).extension<FlFormFieldTheme>()?.style),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(
                     top: 4,
                     left: (Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets).left,
                   ),
                   child: RichText(
                     text: TextSpan(
                       style: Theme.of(field.context).extension<FlFormFieldTheme>()?.errorStyle,
                       children: [TextSpan(text: state.errorText)],
                     ),
                   ),
                 ),
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
