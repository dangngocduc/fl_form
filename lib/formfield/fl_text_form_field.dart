import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlTextFormField extends FormField<String> {
  final bool isPassword;
  FlTextFormField({
    super.key,
    required String label,
    required String placeholderText,
    bool isRequired = false,
    FormFieldValidator<String>? validator,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<String>? onSaved,
    String? restorationId,
    bool enabled = true,
    this.isPassword = false,
    int maxLines = 1,
    Widget? prefixIcon,
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
                TextField(
                  controller: state.textEditingController,
                  cursorWidth: 1,
                  obscureText: state.obscureText,
                  enabled: enabled,
                  maxLines: maxLines,
                  minLines: maxLines,
                  onChanged: (value) {
                    state.didChange(value);
                  },
                  decoration: InputDecoration(
                    hintText: placeholderText,
                    prefixIcon: prefixIcon,
                    suffixIcon: isPassword
                        ? GestureDetector(
                            onTap: () {
                              state.toglgleShowPass();
                            },
                            child: state.obscureText
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          )
                        : null,
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

    textEditingController = TextEditingController(text: widget.initialValue);
  }
}
