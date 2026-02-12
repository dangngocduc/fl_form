import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/value_converter.dart';
import 'package:fl_form/formfield/widget/fl_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/default_error_builder.dart';

class FlDoubleFormField extends FormField<double> {
  final TextEditingController? textEditingController;

  final ValueConverter<double> doubleConverter;

  final ValueChanged<double?>? onChanged;
  FlDoubleFormField({
    super.key,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    super.validator,
    this.onChanged,
    super.initialValue,
    super.autovalidateMode,
    super.onSaved,
    super.restorationId,
    super.enabled,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool autofocus = false,
    TextInputType? keyboardType = TextInputType.number,
    Brightness? keyboardAppearance,
    TextInputAction? textInputAction,
    int? maxLength,
    bool autocorrect = false,
    bool enableSuggestions = false,
    Iterable<String>? autofillHints,
    String? helperText,
    ErrorBuilder errorBuilder = defaultErrorBuilder,
    this.textEditingController,
    this.doubleConverter = const DoubleConverter(),
  }) : super(
         builder: (field) {
           final state = field as FlDoubleFormFieldState;

           return FlTextfield(
             textEditingController: state.textEditingController,
             label: label,
             placeholderText: placeholderText,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             keyboardType: keyboardType,
             keyboardAppearance: keyboardAppearance,
             inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^([-+])?[0-9]*[.]?[0-9]*'))],
             textInputAction: textInputAction,
             maxLength: maxLength,
             autocorrect: autocorrect,
             enableSuggestions: enableSuggestions,
             autofillHints: autofillHints,
             prefixIcon: prefixIcon,
             suffixIcon: suffixIcon,
             autofocus: autofocus,
           );
         },
       );
  @override
  FormFieldState<double> createState() => FlDoubleFormFieldState();
}

//////////////////////////////////////////////////////////////////////////////

class FlDoubleFormFieldState extends FormFieldState<double> {
  late TextEditingController textEditingController;

  @override
  FlDoubleFormField get widget => super.widget as FlDoubleFormField;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.doubleConverter.toUiString(widget.initialValue));
    textEditingController.addListener(listen);
    //setValue(widget.initialValue);
  }

  @override
  void dispose() {
    textEditingController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    setValue((widget.doubleConverter.fromUiString(textEditingController.text)));
    widget.onChanged?.call(value);
  }

  @override
  void didUpdateWidget(FlDoubleFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      textEditingController.removeListener(listen);
      textEditingController = widget.textEditingController ?? TextEditingController(text: widget.doubleConverter.toUiString(widget.initialValue));
      textEditingController.addListener(listen);
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
      textEditingController.text = widget.doubleConverter.toUiString(widget.initialValue) ?? "";
    }
  }
}

//////////////////////////////////////////////////////////////////////////////

class DoubleConverter implements ValueConverter<double> {
  final int fractionDigits;

  const DoubleConverter({this.fractionDigits = 1});

  @override
  double? fromUiString(String? value) {
    if (value == null) return null;
    try {
      double? v = double.tryParse(value);
      return v;
    } catch (error) {
      // ignore the error, do nothing
      return null;
    }
  }

  @override
  String? toUiString(double? value) {
    if (value == null) return null;
    return value.toStringAsFixed(fractionDigits);
  }
}
