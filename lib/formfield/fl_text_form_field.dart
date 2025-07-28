import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'fl_form_field_theme.dart';
import 'widget/default_error_builder.dart';

typedef ErrorBuilder = Widget Function(BuildContext context, String errorText);

class FlTextFormField extends FormField<String> {
  @Deprecated("Use FlPasswordFormField instead.")
  final bool isPassword;
  final TextEditingController? textEditingController;

  FlTextFormField({
    super.key,
    required String label,
    String? placeholderText,
    bool isRequired = false,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<String>? onSaved,
    String? restorationId,
    bool enabled = true,
    @Deprecated("Use FlPasswordFormField instead.") this.isPassword = false,
    int maxLines = 1,
    Widget? prefixIcon,
    bool autofocus = false,
    TextInputType? keyboardType,
    Brightness? keyboardAppearance,
    TextInputAction? textInputAction,
    int? maxLength,
    bool autocorrect = true,
    bool enableSuggestions = true,
    Iterable<String>? autofillHints,
    double? paddingLeftError,
    String? helperText,
    @Deprecated("Use FlPasswordFormField instead.") Tuple2<Widget, Widget>? iconObscureText,
    ErrorBuilder errorBuilder = defaultErrorBuilder,
    this.textEditingController,
  }) : super(
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         enabled: enabled,
         builder: (field) {
           final state = field as FlTextFormFieldState;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               TextField(
                 controller: state.textEditingController,
                 cursorWidth: 1,
                 obscureText: state.obscureText,
                 enabled: enabled,
                 maxLines: maxLines,
                 minLines: maxLines,
                 autofocus: autofocus,
                 keyboardAppearance: keyboardAppearance,
                 keyboardType: keyboardType,
                 maxLength: maxLength,
                 textInputAction: textInputAction,
                 autocorrect: autocorrect,
                 enableSuggestions: enableSuggestions,
                 autofillHints: autofillHints,
                 onChanged: (value) {
                   onChanged?.call(value);
                   state.didChange(value);
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
                   suffixIcon: isPassword
                       ? GestureDetector(
                           onTap: () {
                             state.toglgleShowPass();
                           },
                           child: state.obscureText
                               ? (iconObscureText?.item1 ?? const Icon(Icons.visibility_outlined))
                               : (iconObscureText?.item2 ?? const Icon(Icons.visibility_off_outlined)),
                         )
                       : null,
                 ).create(field.context),
               ),
               if (state.hasError) errorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );
  @override
  FormFieldState<String> createState() => FlTextFormFieldState();
}

class FlTextFormFieldState extends FormFieldState<String> {
  late TextEditingController textEditingController;

  late bool obscureText;

  @override
  FlTextFormField get widget => super.widget as FlTextFormField;

  void toglgleShowPass() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      obscureText = true;
    } else {
      obscureText = false;
    }

    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(FlTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
      textEditingController.text = widget.initialValue ?? '';
    }
  }
}
