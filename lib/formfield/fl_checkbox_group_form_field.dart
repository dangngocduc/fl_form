import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';

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
    String? helperText,
    bool enabled = true,
  }) : super(
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         restorationId: restorationId,
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
                   //placeholderText: placeholderText,
                 ).create(state.context),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ...options.map((e) {
                       return Row(
                         children: [
                           Checkbox(
                             value: state.value?.contains(e) == true,
                             onChanged: (value) {
                               if (value == true) {
                                 state.didChange([...state.value ?? [], e]);
                               } else {
                                 state.didChange([...state.value!]..remove(e));
                               }
                             },
                           ),
                           const SizedBox(width: 4),
                           Expanded(
                             child: InkWell(
                               onTap: () {
                                 if (state.value?.contains(e) == true) {
                                   state.didChange([...state.value!]..remove(e));
                                 } else {
                                   state.didChange([...state.value ?? [], e]);
                                 }
                               },
                               child: itemBuilder(state.context, e, null),
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
