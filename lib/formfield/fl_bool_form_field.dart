import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

/// Todo rename to FlSwitchFormField since bool is just the type of the property whereas swich is the ui type (all other form fields are also named according to their ui type)
class FlBoolFormField extends FormField<bool> {
  FlBoolFormField({
    super.key,
    EdgeInsetsGeometry? padding,
    bool initialValue = false,
    double spacing = 0,
    bool switchAtStart = false,

    /// todo rename to label
    required String title,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    String? restorationId,
    String? helperText,
  }) : super(
         initialValue: initialValue,
         enabled: enabled,
         onSaved: onSaved,
         restorationId: restorationId,
         validator: validator,
         autovalidateMode: autovalidateMode,
         builder: (field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 padding: padding,
                 child: switchAtStart
                     ? _SwitchStart(field: field, title: title, spacing: spacing, value: field.value!, enabled: enabled)
                     : _SwitchEnd(field: field, title: title, spacing: spacing, value: field.value!, enabled: enabled),
               ),
               if (helperText != null) Text(helperText, style: Theme.of(field.context).textTheme.bodySmall),
             ],
           );
         },
       );
}

//////////////////////////////////////////////////////////////////////////////

class _SwitchStart extends StatelessWidget {
  final String title;

  final double spacing;

  final bool value;

  final bool enabled;

  final FormFieldState<bool> field;

  const _SwitchStart({super.key, this.title = '', this.spacing = 0, this.value = false, this.enabled = true, required this.field});

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Switch(
          value: value,
          onChanged: enabled
              ? (value) {
                  field.didChange(value);
                }
              : null,
        ),
        SizedBox(width: spacing),
        Text(title, style: Theme.of(context).extension<FlFormFieldTheme>()?.style),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////

class _SwitchEnd extends StatelessWidget {
  final String title;

  final double spacing;

  final bool value;

  final bool enabled;

  final FormFieldState<bool> field;

  const _SwitchEnd({super.key, this.title = '', this.spacing = 0, this.value = false, this.enabled = true, required this.field});

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: Theme.of(context).extension<FlFormFieldTheme>()?.style),
        Spacer(),
        Switch(
          value: value,
          onChanged: enabled
              ? (value) {
                  field.didChange(value);
                }
              : null,
        ),
      ],
    );
  }
}
