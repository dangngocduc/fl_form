import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fl_form_field_theme.dart';

class FlDateAndTimeFormField extends FormField<DateTime> {
  FlDateAndTimeFormField({
    DateFormat? dateFormat,
    required DateTime firstDate,
    required DateTime lastDate,
    FormFieldValidator<DateTime>? validator,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode? autovalidateMode,
    DateTime? initialValue,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    Widget? prefixIcon,
    String? helperText,
    bool enabled = true,
    super.key,
  }) : super(
         builder: (field) {
           final state = field as FlDateAndTimeFormFieldState;
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
                 onTap: () {},
                 child: InputDecorator(
                   decoration: InputDecoration(
                     hintText: placeholderText,
                     prefixIcon: prefixIcon,
                     enabledBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                     focusedBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                     border: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   ).applyDefaults(Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(field.context).inputDecorationTheme),
                   isEmpty: false,
                   child: Row(
                     children: [
                       Expanded(
                         child: GestureDetector(
                           behavior: HitTestBehavior.opaque,
                           onTap: enabled
                               ? () {
                                   showDatePicker(
                                     context: state.context,
                                     initialDate: state.value ?? DateTime.now(),
                                     firstDate: firstDate,
                                     lastDate: lastDate,
                                   ).then((value) {
                                     if (value != null) {
                                       if (state.value == null) {
                                         state.didChange(value);
                                       } else {
                                         state.didChange(DateTime(value.year, value.month, value.day, state.value!.hour, state.value!.minute));
                                       }
                                     }
                                   });
                                 }
                               : null,
                           child: Text(
                             state.value == null ? 'YYYY/MM/DD' : (dateFormat ?? DateFormat(DateFormat.YEAR_MONTH_DAY)).format(state.value!),
                             style: state.value == null
                                 ? Theme.of(field.context).extension<FlFormFieldTheme>()?.placeHolderStyle
                                 : Theme.of(field.context).extension<FlFormFieldTheme>()?.style,
                           ),
                         ),
                       ),
                       const SizedBox(width: 32),
                       GestureDetector(
                         behavior: HitTestBehavior.opaque,
                         onTap: enabled
                             ? () {
                                 if (state.value != null) {
                                   showTimePicker(context: state.context, initialTime: TimeOfDay.fromDateTime(state.value!)).then((value) {
                                     if (value != null) {
                                       state.didChange(DateTime(state.value!.year, state.value!.month, state.value!.day, value.hour, value.minute));
                                     }
                                   });
                                 }
                               }
                             : null,
                         child: Text(
                           state.value == null ? 'HH:MM' : TimeOfDay.fromDateTime(state.value!).format(state.context),
                           style: state.value == null
                               ? Theme.of(field.context).extension<FlFormFieldTheme>()?.placeHolderStyle
                               : Theme.of(field.context).extension<FlFormFieldTheme>()?.style,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               if (helperText != null && !state.hasError) Text(helperText, style: Theme.of(field.context).textTheme.bodySmall),
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
  FlDateAndTimeFormFieldState createState() => FlDateAndTimeFormFieldState();
}

class FlDateAndTimeFormFieldState extends FormFieldState<DateTime> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
