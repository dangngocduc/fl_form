import 'package:flutter/material.dart';

typedef FlRawBoolFormFieldBuilder = Widget Function(BuildContext context, bool? data, ValueChanged<bool?> didChange);

class FlRawBoolFormField extends FormField<bool> {
  FlRawBoolFormField({
    super.key,
    bool super.initialValue = false,
    required String title,
    super.enabled,
    super.autovalidateMode,
    super.onSaved,
    super.validator,
    super.restorationId,
    required FlRawBoolFormFieldBuilder rawBuilder,
  }) : super(
         builder: (field) {
           return rawBuilder(field.context, field.value, field.didChange);
         },
       );
}
