import 'package:flutter/material.dart';

typedef FlRawBoolFormFieldBuilder = Widget Function(
  BuildContext context,
  bool? data,
  ValueChanged<bool?> didChange,
);

class FlRawBoolFormField extends FormField<bool> {
  FlRawBoolFormField({
    super.key,
    bool initialValue = false,
    required String title,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    String? restorationId,
    required FlRawBoolFormFieldBuilder rawBuilder,
  }) : super(
          initialValue: initialValue,
          enabled: enabled,
          onSaved: onSaved,
          restorationId: restorationId,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return rawBuilder(
              field.context,
              field.value,
              field.didChange,
            );
          },
        );
}
