import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/bottom_sheet/single_item_picker_bottom_sheet.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class SingleItemPickerFormField<T> extends FormField<T> {
  SingleItemPickerFormField({
    super.key,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    super.validator,
    super.onSaved,
    ValueChanged<T>? onChanged,
    super.autovalidateMode,
    super.enabled,
    super.initialValue,
    bool isRequired = false,
    required List<FormFieldOption<T>> options,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    String? helperText,
  }) : super(
         builder: (field) {
           final state = field as SingleItemPickerFormFieldState<T>;
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             onTap: enabled
                 ? () {
                     SingleItemPickerBottomSheet.show<T>(state.context, options, state.value, builder).then((value) {
                       if (value != null) {
                         onChanged?.call(value);
                         state.didChange(value);
                       }
                     });
                   }
                 : null,
             helperText: helperText,
             errorText: state.errorText,
             content: state.value == null ? null : builder.buildForContent(state.context, options.firstWhere((test) => test.value == state.value)),
             suffixIcon: const Icon(Icons.keyboard_arrow_down),
           );
         },
       );

  @override
  FormFieldState<T> createState() {
    return SingleItemPickerFormFieldState<T>();
  }
}

//////////////////////////////////////////////////////////////////////////////

class SingleItemPickerFormFieldState<T> extends FormFieldState<T> {
  @override
  SingleItemPickerFormField<T> get widget => super.widget as SingleItemPickerFormField<T>;
}
