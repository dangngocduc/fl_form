import 'package:fl_form/formfield/fl_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'fl_form_field_theme.dart';

class FlPasswordFormField extends FormField<String> {
  final TextEditingController? textEditingController;

  final bool obscureText;

  FlPasswordFormField({
    super.key,
    required String label,
    bool isRequired = false,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<String>? onSaved,
    String? restorationId,
    bool enabled = true,
    Widget? prefixIcon,
    bool autofocus = false,
    Brightness? keyboardAppearance,
    TextInputAction? textInputAction,
    double? paddingLeftError,
    Tuple2<Widget, Widget>? iconObscureText,
    ErrorBuilder? errorBuilder,
    this.textEditingController,
    this.obscureText = true,
  }) : super(
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         enabled: enabled,
         builder: (field) {
           final state = field as FlPasswordFormFieldState;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 4),
                 child: RichText(
                   text: TextSpan(
                     style: Theme.of(field.context).extension<FlFormFieldTheme>()?.labelStyle,
                     children: [
                       TextSpan(text: label),
                       if (isRequired)
                         TextSpan(
                           text: ' *',
                           style: Theme.of(field.context).extension<FlFormFieldTheme>()?.labelStyle.copyWith(color: Colors.red),
                         ),
                     ],
                   ),
                 ),
               ),
               TextField(
                 controller: state.textEditingController,
                 cursorWidth: 1,
                 obscureText: state.obscureText,
                 enabled: enabled,
                 autofocus: autofocus,
                 keyboardAppearance: keyboardAppearance,
                 textInputAction: textInputAction,
                 autocorrect: false,
                 enableSuggestions: false,
                 onChanged: (value) {
                   onChanged?.call(value);
                   state.didChange(value);
                 },
                 style: enabled
                     ? Theme.of(field.context).extension<FlFormFieldTheme>()?.style
                     : Theme.of(field.context).extension<FlFormFieldTheme>()?.disableStyle,
                 decoration: InputDecoration(
                   prefixIcon: prefixIcon,
                   fillColor: enabled
                       ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.fillColor
                       : Theme.of(field.context).extension<FlFormFieldTheme>()?.fillColorDisable,
                   suffixIcon: GestureDetector(
                     onTap: () {
                       state.toglgleShowPass();
                     },
                     child: state.obscureText
                         ? (iconObscureText?.item1 ?? const Icon(Icons.visibility_outlined))
                         : (iconObscureText?.item2 ?? const Icon(Icons.visibility_off_outlined)),
                   ),
                   enabledBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   focusedBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                   disabledBorder: Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.disabledBorder,
                   border: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                 ).applyDefaults(Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(field.context).inputDecorationTheme),
               ),
               if (state.hasError)
                 errorBuilder != null
                     ? errorBuilder(field.context, state.errorText!, state)
                     : Padding(
                         // todo: use Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding completely instead of just the left-property
                         padding: EdgeInsets.only(
                           top: 4,
                           left:
                               paddingLeftError ??
                               (Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding != null
                                       ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets
                                       : null)
                                   ?.left ??
                               4,
                         ),
                         child: RichText(
                           text: TextSpan(
                             style: Theme.of(field.context).extension<FlFormFieldTheme>()?.errorStyle,
                             children: [TextSpan(text: state.errorText)],
                           ),
                         ),
                       ),
             ],
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

  void toglgleShowPass() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void didUpdateWidget(covariant FormField<String> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != (oldWidget as FlPasswordFormField).obscureText) obscureText = widget.obscureText;
  }

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;

    textEditingController = widget.textEditingController ?? TextEditingController(text: widget.initialValue);
  }
}
