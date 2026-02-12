import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlTextfield extends StatelessWidget {
  final String label;

  final bool isRequired;

  final bool enabled;

  final bool hasError;

  final bool obscureText;

  final String? errorText;

  final String? helperText;

  final String? placeholderText;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final GestureTapCallback? onTap;

  final TextEditingController? textEditingController;

  final int minLines;

  final int maxLines;

  final bool autofocus;

  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final bool autocorrect;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;

  final List<TextInputFormatter>? inputFormatters;

  const FlTextfield({
    super.key,
    required this.label,
    this.isRequired = true,
    this.enabled = true,
    this.hasError = false,
    this.obscureText = false,
    this.errorText,
    this.helperText,
    this.placeholderText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.textEditingController,
    this.minLines = 1,
    this.maxLines = 1,
    this.autofocus = false,
    this.keyboardType,
    this.keyboardAppearance,
    this.textInputAction,
    this.maxLength,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.autofillHints,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      enabled: enabled,
      onTap: onTap,
      //style: enabled ? Theme.of(context).extension<FlFormFieldTheme>()?.style : Theme.of(context).extension<FlFormFieldTheme>()?.disableStyle,
      minLines: minLines,
      maxLines: maxLines,
      autofocus: autofocus,
      keyboardType: keyboardType,
      keyboardAppearance: keyboardAppearance,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      autofillHints: autofillHints,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabled: enabled,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: placeholderText,
        helperMaxLines: 2,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: LabelWidget(label: label, isRequired: isRequired),
      ),
    );
  }
}
