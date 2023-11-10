import 'package:fl_form/formfield/bottom_sheet/item_picker_default_widget.dart';
import 'package:fl_form/formfield/bottom_sheet/single_item_picker_bottom_sheet.dart';
import 'package:fl_form/formfield/dialog/fl_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';
import 'multiple_item_picker_form_field.dart';

class FlSearchItemFormField<T> extends FormField<T> {
  final OnSearch<T> onSearch;
  final ValueWidgetBuilder<T> itemBuilder;
  FlSearchItemFormField({
    super.key,
    required String label,
    required String placeholderText,
    ContentSelectedBuilder<T>? contentSelectedBuilder,
    ValueSelectorWidgetBuilder<T>? itemListBuilder,
    Widget? prefixIcon,
    FormFieldValidator<T>? validator,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode? autovalidateMode,
    EdgeInsetsGeometry? contentPadding,
    bool enabled = true,
    T? initialValue,
    required this.onSearch,
    required this.itemBuilder,
    bool isRequired = false,
    required List<T> options,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: (field) {
            final state = field as FlSearchItemFormFieldState<T>;
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
                    Navigator.push<T>(
                      state.context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FlSearchPage<T>(
                            itemBuilder: itemBuilder,
                            onSearch: onSearch,
                          );
                        },
                      ),
                    ).then((value) {
                      if (value != null) {
                        state.didChange(value);
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: placeholderText,
                      contentPadding: contentPadding,
                      prefixIcon: prefixIcon,
                      suffixIcon: field.value != null
                          ? GestureDetector(
                              onTap: () {
                                field.didChange(null);
                              },
                              child: const Icon(
                                  CupertinoIcons.clear_circled_solid))
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
    return FlSearchItemFormFieldState<T>();
  }
}

class FlSearchItemFormFieldState<T> extends FormFieldState<T> {
  @override
  FlSearchItemFormField<T> get widget =>
      super.widget as FlSearchItemFormField<T>;
}
