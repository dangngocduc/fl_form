import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'dialog/fl_date_range_picker.dart';
import 'dialog/fl_date_range_picker_dialog.dart';
import 'fl_form_field_theme.dart';

class FlDateRangeFormField extends FormField<Tuple2<DateTime, DateTime>> {
  FlDateRangeFormField({
    super.key,
    Tuple2<DateTime, DateTime>? initialValue,
    FormFieldSetter<Tuple2<DateTime, DateTime>>? onSaved,
    FormFieldValidator<Tuple2<DateTime, DateTime>>? validator,
    AutovalidateMode? autovalidateMode,
    required String label,
    required String placeholderText,
    Widget? prefixIcon,
    bool isRequired = false,
    bool enabled = true,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (field) {
            String valueDisplay = '';
            if (field.value != null) {
              valueDisplay =
                  '${MaterialLocalizations.of(field.context).formatMediumDate(field.value!.item1)} - ${MaterialLocalizations.of(field.context).formatMediumDate(field.value!.item2)}';
            } else {
              valueDisplay = '';
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: RichText(
                    text: TextSpan(
                        style: Theme.of(field.context)
                            .extension<FlFormFieldTheme>()
                            ?.labelStyle,
                        children: [
                          TextSpan(text: label),
                          if (isRequired)
                            TextSpan(
                              text: ' *',
                              style: Theme.of(field.context)
                                  .extension<FlFormFieldTheme>()
                                  ?.labelStyle
                                  .copyWith(color: Colors.red),
                            ),
                        ]),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showDialog<DateTimeRange>(
                      context: field.context,
                      builder: (context) {
                        return CalendarPopUp(
                          initialStartDate: field.value?.item1,
                          initialEndDate: field.value?.item2,
                          maximumDate: DateTime.now().add(
                            const Duration(days: 90),
                          ),
                          minimumDate: DateTime.now(),
                        );
                        // return DateRangePickerDialog(
                        //   firstDate: DateTime.now(),
                        //   currentDate: DateTime.now(),
                        //   lastDate: DateTime.now().add(
                        //     const Duration(days: 90),
                        //   ),
                        // );
                      },
                    ).then((value) {
                      if (value != null) {
                        field.didChange(Tuple2(value.start, value.end));
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: placeholderText,
                      enabledBorder: field.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .errorBorder
                          : null,
                      focusedBorder: field.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .focusedErrorBorder
                          : null,
                      border: field.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .errorBorder
                          : null,
                    ).applyDefaults(Theme.of(field.context)
                            .extension<FlFormFieldTheme>()
                            ?.inputDecorationTheme ??
                        Theme.of(field.context).inputDecorationTheme),
                    isEmpty: false,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: DateInfo(
                          icon: prefixIcon ?? SizedBox.shrink(),
                          hint: 'Start date',
                          dateTime: field.value?.item1,
                        )),
                        Container(
                          height: 24,
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 8)
                              .copyWith(right: 16),
                          color: Theme.of(field.context).dividerColor,
                        ),
                        Expanded(
                            child: DateInfo(
                          icon: prefixIcon ?? SizedBox.shrink(),
                          hint: 'End date',
                          dateTime: field.value?.item2,
                        )),
                      ],
                    ),
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: (Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .contentPadding as EdgeInsets)
                          .left,
                    ),
                    child: RichText(
                      text: TextSpan(
                          style: Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.errorStyle,
                          children: [
                            TextSpan(text: field.errorText),
                          ]),
                    ),
                  ),
              ],
            );
          },
        );
}

class DateInfo extends StatelessWidget {
  final String hint;
  final DateTime? dateTime;
  final Widget icon;

  const DateInfo({
    super.key,
    required this.hint,
    this.dateTime,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: dateTime == null
              ? Text(
                  hint,
                  style: Theme.of(context)
                      .extension<FlFormFieldTheme>()
                      ?.placeHolderStyle,
                )
              : Text(
                  MaterialLocalizations.of(context).formatMediumDate(dateTime!),
                  style: Theme.of(context)
                      .extension<FlFormFieldTheme>()
                      ?.style
                      .copyWith(height: 1),
                ),
        )
      ],
    );
  }
}
