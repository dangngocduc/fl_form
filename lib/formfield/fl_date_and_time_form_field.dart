import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlDateAndTimeFormField extends FormField<DateTime> {
  FlDateAndTimeFormField({
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    super.validator,
    super.onSaved,
    ValueChanged<DateTime?>? onChanged,
    super.autovalidateMode,
    super.initialValue,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    Widget? prefixIcon,
    String? helperText,
    bool enabled = true,
    bool utc = false,
    super.key,
  }) : super(
         builder: (field) {
           final state = field as FlDateAndTimeFormFieldState;
           dateFormat ??= DateFormat(DateFormat.YEAR_MONTH_DAY);
           return FlReadonlyField(
             label: label,
             placeholderText: placeholderText,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             //             autofocus: autofocus,
             content: Row(
               children: [
                 Expanded(
                   child: InkWell(
                     onTap: enabled
                         ? () {
                             showDatePicker(
                               context: state.context,
                               initialDate: state.value ?? DateTime.now(),
                               firstDate: firstDate ?? DateTime.now().add(Duration(days: -3650)),
                               lastDate: lastDate ?? DateTime.now().add(Duration(days: 3650)),
                             ).then((value) {
                               if (value == null) {
                                 // cancel
                                 return;
                               }
                               if (utc) {
                                 state.didChange(DateTime.utc(value.year, value.month, value.day, state.value?.hour ?? 0, state.value?.minute ?? 0));
                               } else {
                                 state.didChange(DateTime(value.year, value.month, value.day, state.value?.hour ?? 0, state.value?.minute ?? 0));
                               }
                               if (onChanged != null) {
                                 onChanged(state.value);
                               }
                             });
                           }
                         : null,
                     child: Text(state.value == null ? dateFormat?.pattern ?? 'YYYY/MM/DD' : dateFormat!.format(state.value!)),
                   ),
                 ),
                 const SizedBox(width: 32),
                 InkWell(
                   onTap: enabled
                       ? () {
                           if (state.value != null) {
                             showTimePicker(context: state.context, initialTime: TimeOfDay.fromDateTime(state.value!)).then((value) {
                               if (value == null) {
                                 // cancel
                                 return;
                               }
                               _change(state, value, utc, onChanged, firstDate, lastDate);
                             });
                           }
                         }
                       : null,
                   child: Text(state.value == null ? 'HH:MM' : TimeOfDay.fromDateTime(state.value!).format(state.context)),
                 ),
               ],
             ),
           );
         },
       );

  @override
  FlDateAndTimeFormFieldState createState() => FlDateAndTimeFormFieldState();
}

void _change(var state, TimeOfDay timeOfDay, bool utc, ValueChanged<DateTime?>? onChanged, DateTime? firstDate, DateTime? lastDate) {
  DateTime value;
  if (utc) {
    value = (DateTime.utc(state.value!.year, state.value!.month, state.value!.day, timeOfDay.hour, timeOfDay.minute));
  } else {
    value = (DateTime(state.value!.year, state.value!.month, state.value!.day, timeOfDay.hour, timeOfDay.minute));
  }
  if (firstDate != null && value.isBefore(firstDate)) {
    value = firstDate;
  } else if (lastDate != null && value.isAfter(lastDate)) {
    value = lastDate;
  }
  state.didChange(value);
  if (onChanged != null) {
    onChanged(state.value);
  }
}

class FlDateAndTimeFormFieldState extends FormFieldState<DateTime> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
