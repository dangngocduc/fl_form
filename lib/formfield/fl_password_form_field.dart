import 'package:fl_form/formfield/fl_text_form_field.dart';
import 'package:fl_form/formfield/widget/fl_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'widget/default_error_builder.dart';

/// A specialized text form field for entering passwords.
///
/// The [FlPasswordFormField] obscures the entered text and provides an icon to
/// toggle text visibility. It is designed to be used within a [Form] and
/// supports validation and error handling.
class FlPasswordFormField extends FormField<String> {
  final TextEditingController? textEditingController;

  final bool obscureText;

  /// Creates a new instance of [FlPasswordFormField].
  ///
  /// The [label] is a required string that describes the input field.
  ///
  /// The [isRequired] flag indicates whether the field must be filled.
  ///
  /// The [validator] function allows for custom validation logic.
  ///
  /// The [onChanged] callback is invoked when the value of the field changes.
  FlPasswordFormField({
    super.key,
    required String label,
    bool isRequired = false,
    super.validator,
    ValueChanged<String>? onChanged,
    super.initialValue,
    super.autovalidateMode,
    super.onSaved,
    super.restorationId,
    super.enabled,
    Widget? prefixIcon,
    bool autofocus = false,
    Brightness? keyboardAppearance,
    TextInputAction? textInputAction,
    double? paddingLeftError,
    Tuple2<Widget, Widget>? iconObscureText,
    ErrorBuilder errorBuilder = defaultErrorBuilder,
    this.textEditingController,
    this.obscureText = true,
    String? helperText,
    String? placeholderText,
  }) : super(
         builder: (field) {
           final state = field as FlPasswordFormFieldState;

           return FlTextfield(
             textEditingController: state.textEditingController,
             label: label,
             placeholderText: placeholderText,
             isRequired: isRequired,
             enabled: enabled,
             obscureText: state.obscureText,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             keyboardAppearance: keyboardAppearance,
             textInputAction: textInputAction,
             prefixIcon: prefixIcon,
             suffixIcon: InkWell(
               onTap: () {
                 state.toggleShowPass();
               },
               child: state.obscureText
                   ? (iconObscureText?.item1 ?? const Icon(Icons.visibility_outlined))
                   : (iconObscureText?.item2 ?? const Icon(Icons.visibility_off_outlined)),
             ),
             autofocus: autofocus,
           );
         },
       );
  @override
  FormFieldState<String> createState() => FlPasswordFormFieldState();
}

class FlPasswordFormFieldState extends FormFieldState<String> {
  late TextEditingController textEditingController;

  late bool obscureText;

  @override
  FlPasswordFormField get widget => super.widget as FlPasswordFormField;

  void toggleShowPass() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void didUpdateWidget(FlPasswordFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) obscureText = widget.obscureText;
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
      textEditingController.text = widget.initialValue ?? '';
    }
  }

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;

    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.initialValue);
    textEditingController.addListener(listen);
    setValue(widget.initialValue);
  }

  @override
  void dispose() {
    textEditingController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    setValue(textEditingController.text);
  }
}
