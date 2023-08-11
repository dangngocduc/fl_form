import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fl_form_field_theme.dart';

class FlDateFormField extends FormField<DateTime> {
  FlDateFormField({
    DateFormat? dateFormat,
    required DateTime firstDate,
    required DateTime lastDate,
    FormFieldValidator<DateTime>? validator,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode? autovalidateMode,
    DateTime? initialValue,
    required String label,
    required String placeholderText,
    bool isRequired = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as FlDateFormFieldState;
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
                    showDatePicker(
                            context: state.context,
                            initialDate: state.value ?? DateTime.now(),
                            firstDate: firstDate,
                            lastDate: lastDate)
                        .then((value) {
                      if (value != null) {
                        state.didChange(value);
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: placeholderText,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      enabledBorder: state.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .errorBorder
                          : null,
                      focusedBorder: state.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .focusedErrorBorder
                          : null,
                      border: state.hasError
                          ? Theme.of(field.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .errorBorder
                          : null,
                    ).applyDefaults(Theme.of(field.context)
                            .extension<FlFormFieldTheme>()
                            ?.inputDecorationTheme ??
                        Theme.of(field.context).inputDecorationTheme),
                    isEmpty: state.value == null,
                    child: state.value == null
                        ? null
                        : Text(
                            (dateFormat ??
                                    DateFormat(DateFormat.YEAR_MONTH_DAY))
                                .format(state.value!),
                            style: Theme.of(field.context)
                                .extension<FlFormFieldTheme>()
                                ?.style,
                          ),
                  ),
                ),
                if (state.hasError)
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
                            TextSpan(text: state.errorText),
                          ]),
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
  FlDateFormFieldState createState() => FlDateFormFieldState();
}

class FlDateFormFieldState extends FormFieldState<DateTime> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
