import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/value_converter.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fl_form_field_theme.dart';
import 'widget/default_error_builder.dart';

class FlDoubleFormField extends FormField<double> {
  final TextEditingController? textEditingController;

  final ValueConverter<double> doubleConverter;

  FlDoubleFormField({
    super.key,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    FormFieldValidator<double>? validator,
    ValueChanged<double>? onChanged,
    double? initialValue,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<double>? onSaved,
    String? restorationId,
    bool enabled = true,
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
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         enabled: enabled,
         builder: (field) {
           final state = field as FlDoubleFormFieldState;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               TextField(
                 controller: state.textEditingController,
                 cursorWidth: 1,
                 enabled: enabled,
                 autofocus: autofocus,
                 keyboardAppearance: keyboardAppearance,
                 keyboardType: keyboardType,
                 maxLength: maxLength,
                 textInputAction: textInputAction,
                 autocorrect: autocorrect,
                 enableSuggestions: enableSuggestions,
                 autofillHints: autofillHints,
                 inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^([-+])?[0-9]*[.]?[0-9]*'))],
                 onChanged: (value) {
                   double? v = doubleConverter.fromUiString(value);
                   if (v != null) {
                     onChanged?.call(v);
                     state.didChange(v);
                   }
                 },
                 style: enabled
                     ? Theme.of(field.context).extension<FlFormFieldTheme>()?.style
                     : Theme.of(field.context).extension<FlFormFieldTheme>()?.disableStyle,
                 decoration: InputDecorationBuilder(
                   enabled: enabled,
                   hasError: state.hasError,
                   helperText: helperText,
                   placeholderText: placeholderText,
                   prefixIcon: prefixIcon,
                   suffixIcon: suffixIcon,
                 ).create(field.context),
               ),
               if (state.hasError) errorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );
  @override
  FormFieldState<double> createState() => FlDoubleFormFieldState();
}

class FlDoubleFormFieldState extends FormFieldState<double> {
  late TextEditingController textEditingController;

  @override
  FlDoubleFormField get widget => super.widget as FlDoubleFormField;

  @override
  void initState() {
    super.initState();
    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.doubleConverter.toUiString(widget.initialValue));
  }

  @override
  void didUpdateWidget(FlDoubleFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
      textEditingController.text = widget.doubleConverter.toUiString(widget.initialValue) ?? "";
    }
  }
}

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
