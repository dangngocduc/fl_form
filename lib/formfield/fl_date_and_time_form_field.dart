import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
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
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {},
                 child: InputDecorator(
                   decoration: InputDecorationBuilder(
                     enabled: enabled,
                     hasError: state.hasError,
                     helperText: helperText,
                     placeholderText: placeholderText,
                   ).create(field.context),
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
