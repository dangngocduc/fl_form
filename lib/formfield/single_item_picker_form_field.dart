import 'package:fl_form/formfield/bottom_sheet/item_picker_default_widget.dart';
import 'package:fl_form/formfield/bottom_sheet/single_item_picker_bottom_sheet.dart';
import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';

class SingleItemPickerFormField<T> extends FormField<T> {
  SingleItemPickerFormField({
    super.key,
    required String label,
    String? placeholderText,
    ContentSelectedBuilder<T>? contentSelectedBuilder,
    ValueSelectorWidgetBuilder<T>? itemListBuilder,
    Widget? prefixIcon,
    FormFieldValidator<T>? validator,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    T? initialValue,
    bool isRequired = false,
    required List<T> options,
    String? helperText,
  }) : super(
         initialValue: initialValue,
         validator: validator,
         onSaved: onSaved,
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         builder: (field) {
           final state = field as SingleItemPickerFormFieldState<T>;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: enabled
                     ? () {
                         SingleItemPickerBottomSheet.show<T>(
                           state.context,
                           itemListBuilder ?? (context, value, isSelected) => ItemPickerDefaultWidget(data: value, isSelected: isSelected),
                           options,
                           state.value,
                         ).then((value) {
                           if (value != null) {
                             state.didChange(value);
                           }
                         });
                       }
                     : null,
                 child: InputDecorator(
                   decoration: InputDecorationBuilder(
                     enabled: enabled,
                     hasError: state.hasError,
                     helperText: helperText,
                     placeholderText: placeholderText,
                     prefixIcon: prefixIcon,
                     suffixIcon: const Icon(Icons.keyboard_arrow_down),
                   ).create(state.context),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : (contentSelectedBuilder != null
                             ? contentSelectedBuilder(state.value as T, state.context)
                             : SingleItemPickerDefaultDisplayValue(data: state.value!)),
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );

  @override
  FormFieldState<T> createState() {
    return SingleItemPickerFormFieldState<T>();
  }
}

class SingleItemPickerFormFieldState<T> extends FormFieldState<T> {
  @override
  SingleItemPickerFormField<T> get widget => super.widget as SingleItemPickerFormField<T>;
}

class SingleItemPickerDefaultDisplayValue extends StatelessWidget {
  final Object data;

  const SingleItemPickerDefaultDisplayValue({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Text(data.toString());
  }
}
