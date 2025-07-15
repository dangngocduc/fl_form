import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlRadioButtonFormField<T> extends FormField<T> {
  FlRadioButtonFormField({
    super.key,
    required String label,
    bool isRequired = false,
    FormFieldValidator<T>? validator,
    T? initialValue,
    required List<T> options,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<T>? onSaved,
    String? restorationId,
    bool enabled = true,
  }) : super(
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         initialValue: initialValue,
         onSaved: onSaved,
         restorationId: restorationId,
         validator: validator,
         builder: (field) {
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
               InputDecorator(
                 decoration: InputDecoration(
                   contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                   enabledBorder: field.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   focusedBorder: field.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                   border: field.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                 ).applyDefaults(Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(field.context).inputDecorationTheme),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ...options.map((e) {
                       return Row(
                         children: [
                           Radio(
                             value: e,
                             groupValue: field.value,
                             onChanged: (value) {
                               field.didChange(value);
                             },
                           ),
                           const SizedBox(width: 4),
                           Expanded(
                             child: Text(
                               e.toString(),
                               style: Theme.of(field.context).extension<FlFormFieldTheme>()?.style ?? Theme.of(field.context).textTheme.bodyMedium,
                             ),
                           ),
                         ],
                       );
                     }),
                   ],
                 ),
               ),
               if (field.hasError)
                 Padding(
                   padding: EdgeInsets.only(
                     top: 4,
                     left: (Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets).left,
                   ),
                   child: RichText(
                     text: TextSpan(
                       style: Theme.of(field.context).extension<FlFormFieldTheme>()?.errorStyle,
                       children: [TextSpan(text: field.errorText)],
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
