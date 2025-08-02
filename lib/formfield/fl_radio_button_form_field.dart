import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
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
    String? helperText,
    String? placeholderText,
  }) : super(
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         initialValue: initialValue,
         onSaved: onSaved,
         restorationId: restorationId,
         validator: validator,
         builder: (state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               InputDecorator(
                 decoration: InputDecorationBuilder(
                   enabled: enabled,
                   hasError: state.hasError,
                   helperText: helperText,
                   placeholderText: placeholderText,
                 ).create(state.context),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ...options.map((e) {
                       return Row(
                         children: [
                           Radio(
                             value: e,
                             groupValue: state.value,
                             onChanged: (value) {
                               state.didChange(value);
                             },
                           ),
                           const SizedBox(width: 4),
                           Expanded(
                             child: Text(
                               e.toString(),
                               style: Theme.of(state.context).extension<FlFormFieldTheme>()?.style ?? Theme.of(state.context).textTheme.bodyMedium,
                             ),
                           ),
                         ],
                       );
                     }),
                   ],
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );
}
