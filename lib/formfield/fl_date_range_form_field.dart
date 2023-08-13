import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

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
                        return DateRangePickerDialog(
                          firstDate: DateTime.now(),
                          currentDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 90),
                          ),
                        );
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
                      prefixIcon: prefixIcon,
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
                    isEmpty: field.value == null,
                    child: field.value == null
                        ? null
                        : Text(
                            valueDisplay,
                            style: Theme.of(field.context)
                                .extension<FlFormFieldTheme>()
                                ?.style,
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
