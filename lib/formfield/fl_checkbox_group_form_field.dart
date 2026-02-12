import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class FlCheckboxGroupFormField<T> extends FormField<List<T>> {
  FlCheckboxGroupFormField({
    super.key,
    required String label,
    bool isRequired = false,
    super.validator,
    super.initialValue,
    required List<FormFieldOption<T>> options,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    super.autovalidateMode,
    super.onSaved,
    super.restorationId,
    String? helperText,
    super.enabled,
  }) : super(
         builder: (state) {
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             //placeholderText: placeholderText,
             helperText: helperText,
             errorText: state.errorText,
             content: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: options.map((e) {
                 return Row(
                   children: [
                     Checkbox(
                       key: e.label != null ? Key(e.label!) : null,
                       value: state.value?.contains(e.value) == true,
                       onChanged: (value) {
                         if (value == true) {
                           state.didChange([...state.value ?? [], e.value]);
                         } else {
                           state.didChange([...state.value!]..remove(e.value));
                         }
                       },
                     ),
                     const SizedBox(width: 4),
                     Expanded(
                       child: InkWell(
                         onTap: () {
                           if (state.value?.contains(e.value) == true) {
                             state.didChange([...state.value!]..remove(e.value));
                           } else {
                             state.didChange([...state.value ?? [], e.value]);
                           }
                         },
                         child: builder.buildForContent(state.context, e),
                       ),
                     ),
                   ],
                 );
               }).toList(),
             ),
           );
         },
       );
}
