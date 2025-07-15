import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlCheckboxGroupFormField<T> extends FormField<List<T>> {
  FlCheckboxGroupFormField({
    super.key,
    required String label,
    bool isRequired = false,
    FormFieldValidator<List<T>>? validator,
    List<T>? initialValue,
    required List<T> options,
    required ValueWidgetBuilder<T> itemBuilder,
    AutovalidateMode? autovalidateMode,
    FormFieldSetter<List<T>>? onSaved,
    String? restorationId,
    bool enabled = true,
  }) : super(
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         restorationId: restorationId,
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
                           Checkbox(
                             value: field.value?.contains(e) == true,
                             onChanged: (value) {
                               if (value == true) {
                                 field.didChange([...field.value ?? [], e]);
                               } else {
                                 field.didChange([...field.value!]..remove(e));
                               }
                             },
                           ),
                           const SizedBox(width: 4),
                           Expanded(
                             child: InkWell(
                               onTap: () {
                                 if (field.value?.contains(e) == true) {
                                   field.didChange([...field.value!]..remove(e));
                                 } else {
                                   field.didChange([...field.value ?? [], e]);
                                 }
                               },
                               child: itemBuilder(field.context, e, null),
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
