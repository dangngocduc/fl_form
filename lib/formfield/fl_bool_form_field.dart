import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlBoolFormField extends FormField<bool> {
  FlBoolFormField({
    super.key,
    EdgeInsetsGeometry? padding,
    bool initialValue = false,
    double spacing = 0,
    required String title,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    String? restorationId,
  }) : super(
          initialValue: initialValue,
          enabled: enabled,
          onSaved: onSaved,
          restorationId: restorationId,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (field) {
            return Container(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: Theme.of(field.context)
                        .extension<FlFormFieldTheme>()!
                        .style,
                  ),
                  SizedBox(
                    width: spacing,
                  ),
                  Switch(
                    value: field.value!,
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  )
                ],
              ),
            );
          },
        );
}
