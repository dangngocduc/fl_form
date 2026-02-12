import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'form_field_utils.dart';

class DateRangeFormField extends FormField<DateTimeRange> {
  DateRangeFormField({
    InputDecoration? decoration,
    DateFormat? dateFormat,
    TextStyle? textStyle,
    required DateTime firstDate,
    required DateTime lastDate,
    FormFieldValidator<DateTimeRange>? validator,
    FormFieldSetter<DateTimeRange>? onSaved,
    AutovalidateMode? autovalidateMode,
    DateTimeRange? initialValue,
    super.key,
  }) : super(
         builder: (stateField) {
           final state = stateField as DateRangeFormFieldState;
           InputDecoration effectiveInputDeco = (decoration ?? FormFieldUtils.kDefaultInputdecoration.copyWith()).applyDefaults(
             Theme.of(state.context).inputDecorationTheme,
           );
           return GestureDetector(
             onTap: () {
               showDateRangePicker(context: state.context, firstDate: firstDate, lastDate: lastDate).then((value) {
                 if (value != null) {
                   state.didChange(value);
                 }
               });
             },
             behavior: HitTestBehavior.translucent,
             onTapDown: (event) {
               state.setIsFocused(true);
             },
             onTapUp: (event) {
               state.setIsFocused(false);
             },
             onTapCancel: () {
               state.setIsFocused(false);
             },
             child: InputDecorator(
               decoration: effectiveInputDeco,
               isEmpty: state.value == null,
               child: state.value != null
                   ? Text(
                       '${(dateFormat ?? DateFormat.MEd()).format(state.value!.start)} - ${(dateFormat ?? DateFormat.MEd()).format(state.value!.end)}',
                       style: textStyle,
                     )
                   : const SizedBox.shrink(),
             ),
           );
         },
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
       );
  @override
  DateRangeFormFieldState createState() => DateRangeFormFieldState();
}

class DateRangeFormFieldState extends FormFieldState<DateTimeRange> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
