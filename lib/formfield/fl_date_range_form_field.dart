import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'dialog/fl_date_range_picker_dialog.dart';
import 'fl_form_field_theme.dart';

class FlDateRangeFormField extends FormField<Tuple2<DateTime, DateTime>> {
  FlDateRangeFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    ValueChanged<Tuple2<DateTime, DateTime>?>? onChanged,
    EdgeInsetsGeometry? contentPadding,
    AutovalidateMode? autovalidateMode,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    bool isRequired = false,
    bool enabled = true,
    String fromText = 'From',
    String textSelectDate = 'Select dates',
    String textSelectEndDate = 'Select end date',
    String toText = 'To',
    String? helperText,
  }) : super(
         builder: (state) {
           String valueDisplay = '';
           if (state.value != null) {
             valueDisplay =
                 '${MaterialLocalizations.of(state.context).formatMediumDate(state.value!.item1)} - ${MaterialLocalizations.of(state.context).formatMediumDate(state.value!.item2)}';
           } else {
             valueDisplay = '';
           }
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             //             autofocus: autofocus,
             onTap: () {
               showDialog<DateTimeRange>(
                 context: state.context,
                 builder: (context) {
                   return CalendarPopUp(
                     initialStartDate: state.value?.item1,
                     initialEndDate: state.value?.item2,
                     maximumDate: DateTime.now().add(const Duration(days: 90)),
                     textSelectDate: textSelectDate,
                     textSelectEndDate: textSelectEndDate,
                     fromText: fromText,
                     toText: toText,
                     minimumDate: DateTime.now(),
                   );
                 },
               ).then((value) {
                 if (value != null) {
                   state.didChange(Tuple2(value.start, value.end));
                 }
               });
             },
             content: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Expanded(
                   child: DateInfo(icon: prefixIcon ?? SizedBox.shrink(), hint: 'Start date', dateTime: state.value?.item1),
                 ),
                 Container(
                   height: 16,
                   width: 2,
                   margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(right: 16),
                   color: Theme.of(state.context).dividerColor,
                 ),
                 Expanded(
                   child: DateInfo(icon: prefixIcon ?? SizedBox.shrink(), hint: 'End date', dateTime: state.value?.item2),
                 ),
               ],
             ),
           );
         },
       );
}

//////////////////////////////////////////////////////////////////////////////

class DateInfo extends StatelessWidget {
  final String hint;
  final DateTime? dateTime;
  final Widget icon;

  const DateInfo({super.key, required this.hint, this.dateTime, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 48, child: icon, alignment: Alignment.center),
        Expanded(
          child: dateTime == null
              ? Text(hint, style: Theme.of(context).extension<FlFormFieldTheme>()?.placeHolderStyle)
              : Text(
                  MaterialLocalizations.of(context).formatMediumDate(dateTime!),
                  style: Theme.of(context).extension<FlFormFieldTheme>()?.style.copyWith(height: 1),
                ),
        ),
      ],
    );
  }
}
