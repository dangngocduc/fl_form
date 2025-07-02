import 'package:fl_form/formfield/bottom_sheet/item_picker_default_widget.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet/multiple_item_picker_bottom_sheet.dart';
import 'fl_form_field_theme.dart';

class MultipleItemPickerFormField<T> extends FormField<List<T>> {
  MultipleItemPickerFormField({
    super.key,
    required String label,
    String? placeholderText,
    ContentSelectedBuilder<T>? contentSelectedBuilder,
    ValueSelectorWidgetBuilder<T>? itemListBuilder,
    Widget? prefixIcon,
    FormFieldValidator<List<T>>? validator,
    FormFieldSetter<List<T>>? onSaved,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    List<T>? initialValue,
    bool isRequired = false,
    required List<T> options,
  }) : super(
         initialValue: initialValue,
         validator: validator,
         onSaved: onSaved,
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         builder: (field) {
           final state = field as MultipleItemPickerFormFieldState<T>;
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
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {
                   MultipleItemPickerBottomSheet.show<T>(
                     state.context,
                     itemListBuilder ?? (context, value, isSelected) => ItemPickerDefaultWidget(data: value, isSelected: isSelected),
                     options,
                     state.value,
                   ).then((value) {
                     if (value != null) {
                       state.didChange(value);
                     }
                   });
                 },
                 child: InputDecorator(
                   decoration: InputDecoration(
                     hintText: placeholderText,
                     prefixIcon: prefixIcon,
                     suffixIcon: const Icon(Icons.keyboard_arrow_down),
                     enabledBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                     focusedBorder: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                     border: state.hasError ? Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   ).applyDefaults(Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(field.context).inputDecorationTheme),
                   isEmpty: state.value == null || state.value!.isEmpty,
                   child: state.value == null || state.value!.isEmpty
                       ? null
                       : (contentSelectedBuilder != null
                             ? contentSelectedBuilder(state.value ?? [], state.context)
                             : MultipleItemPickerDefaultDisplayValue(data: state.value!)),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(
                     top: 4,
                     left: (Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets).left,
                   ),
                   child: RichText(
                     text: TextSpan(
                       style: Theme.of(field.context).extension<FlFormFieldTheme>()?.errorStyle,
                       children: [TextSpan(text: state.errorText)],
                     ),
                   ),
                 ),
             ],
           );
         },
       );

  @override
  FormFieldState<List<T>> createState() {
    return MultipleItemPickerFormFieldState<T>();
  }
}

class MultipleItemPickerFormFieldState<T> extends FormFieldState<List<T>> {
  @override
  MultipleItemPickerFormField<T> get widget => super.widget as MultipleItemPickerFormField<T>;
}

class MultipleItemPickerDefaultDisplayValue extends StatelessWidget {
  final Object data;

  const MultipleItemPickerDefaultDisplayValue({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Text(data.toString());
  }
}
