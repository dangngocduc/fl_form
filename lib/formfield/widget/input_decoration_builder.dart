import 'package:fl_form/formfield/fl_form_field_theme.dart';
import 'package:flutter/material.dart';

class InputDecorationBuilder {
  final String? placeholderText;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final String? helperText;

  final bool enabled;

  final bool hasError;

  const InputDecorationBuilder({this.placeholderText, this.prefixIcon, this.suffixIcon, this.helperText, this.enabled = true, required this.hasError})
    : super();

  InputDecoration create(BuildContext context) {
    return InputDecoration(
      hintText: placeholderText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      enabledBorder: hasError ? Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
      focusedBorder: hasError ? Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
      disabledBorder: Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.disabledBorder,
      border: hasError ? Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
      helperText: helperText,
      fillColor: enabled
          ? Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.fillColor
          : Theme.of(context).extension<FlFormFieldTheme>()?.fillColorDisable,
      enabled: enabled,
    ).applyDefaults(Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(context).inputDecorationTheme);
  }
}
