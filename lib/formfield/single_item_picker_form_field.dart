import 'package:fl_form/formfield/bottom_sheet/item_picker_default_widget.dart';
import 'package:fl_form/formfield/bottom_sheet/single_item_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class SingleItemPickerFormField<T> extends FormField<T> {
  SingleItemPickerFormField({
    super.key,
    required String label,
    required String placeholderText,
    ContentSelectedBuilder<T>? contentSelectedBuilder,
    ValueSelectorWidgetBuilder<T>? itemListBuilder,
    Widget? prefixIcon,
    FormFieldValidator<T>? validator,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    T? initialValue,
    bool isRequired = false,
    required List<T> options,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: (field) {
            final state = field as SingleItemPickerFormFieldState<T>;
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
                    SingleItemPickerBottomSheet.show<T>(
                      state.context,
                      itemListBuilder ??
                          (context, value, isSelected) =>
                              ItemPickerDefaultWidget(
                                data: value,
                                isSelected: isSelected,
                              ),
                      options,
                      state.value,
                    ).then((value) {
                      if (value != null) {
                        state.didChange(value);
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: placeholderText,
                      prefixIcon: prefixIcon,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
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
                        : (contentSelectedBuilder != null
                            ? contentSelectedBuilder(
                                state.value as T,
                                state.context,
                              )
                            : SingleItemPickerDefaultDisplayValue(
                                data: state.value!)),
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
        );

  @override
  FormFieldState<T> createState() {
    return SingleItemPickerFormFieldState<T>();
  }
}

class SingleItemPickerFormFieldState<T> extends FormFieldState<T> {
  @override
  SingleItemPickerFormField<T> get widget =>
      super.widget as SingleItemPickerFormField<T>;
}

class SingleItemPickerDefaultDisplayValue extends StatelessWidget {
  final Object data;

  const SingleItemPickerDefaultDisplayValue({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Text(data.toString());
  }
}
