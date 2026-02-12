import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/value_converter.dart';
import 'package:fl_form/formfield/widget/fl_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/default_error_builder.dart';

class FlIntFormField extends FormField<int> {
  final TextEditingController? textEditingController;

  final ValueConverter<int> intConverter;

  final ValueChanged<int?>? onChanged;

  FlIntFormField({
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
    this.intConverter = const IntConverter(),
  }) : super(
         builder: (field) {
           final state = field as FlIntFormFieldState;

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
             inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^([-+])?[0-9]*'))],
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
  FormFieldState<int> createState() => FlIntFormFieldState();
}

//////////////////////////////////////////////////////////////////////////////

class FlIntFormFieldState extends FormFieldState<int> {
  late TextEditingController textEditingController;

  @override
  FlIntFormField get widget => super.widget as FlIntFormField;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.intConverter.toUiString(widget.initialValue));
    textEditingController.addListener(listen);
    //    setValue(widget.initialValue);
  }

  @override
  void dispose() {
    textEditingController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    setValue((int.tryParse(textEditingController.text)));
    widget.onChanged?.call(value);
  }

  @override
  void didUpdateWidget(FlIntFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      textEditingController.removeListener(listen);
      textEditingController = widget.textEditingController ?? TextEditingController(text: widget.intConverter.toUiString(widget.initialValue));
      textEditingController.addListener(listen);
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
      textEditingController.text = widget.intConverter.toUiString(widget.initialValue) ?? "";
    }
  }
}

//////////////////////////////////////////////////////////////////////////////

class IntConverter implements ValueConverter<int> {
  const IntConverter();

  @override
  int? fromUiString(String? value) {
    if (value == null) return null;
    try {
      int? v = int.tryParse(value);
      return v;
    } catch (error) {
      // ignore the error, do nothing
      return null;
    }
  }

  @override
  String? toUiString(int? value) {
    if (value == null) return null;
    return "$value";
  }
}
