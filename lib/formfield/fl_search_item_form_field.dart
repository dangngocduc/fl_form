import 'package:fl_form/formfield/bottom_sheet/single_item_picker_bottom_sheet.dart';
import 'package:fl_form/formfield/dialog/fl_search_page.dart';
import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlSearchItemFormField<T> extends FormField<T> {
  final OnSearch<T> onSearch;
  final ValueWidgetBuilder<T> itemBuilder;
  FlSearchItemFormField({
    super.key,
    required String label,
    String? placeholderText,
    ContentSelectedBuilder<T>? contentSelectedBuilder,
    ValueSelectorWidgetBuilder<T>? itemListBuilder,
    Widget? prefixIcon,
    super.validator,
    super.onSaved,
    super.autovalidateMode,
    EdgeInsetsGeometry? contentPadding,
    super.enabled,
    super.initialValue,
    required this.onSearch,
    required this.itemBuilder,
    String? helperText,
    bool isRequired = false,
  }) : super(
         builder: (field) {
           final state = field as FlSearchItemFormFieldState<T>;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {
                   Navigator.push<T>(
                     state.context,
                     MaterialPageRoute(
                       builder: (context) {
                         return FlSearchPage<T>(itemBuilder: itemBuilder, onSearch: onSearch);
                       },
                     ),
                   ).then((value) {
                     if (value != null) {
                       state.didChange(value);
                     }
                   });
                 },
                 child: InputDecorator(
                   decoration: InputDecorationBuilder(
                     enabled: enabled,
                     hasError: state.hasError,
                     helperText: helperText,
                     placeholderText: placeholderText,
                     prefixIcon: prefixIcon,
                     suffixIcon: field.value != null
                         ? GestureDetector(
                             onTap: () {
                               field.didChange(null);
                             },
                             child: const Icon(CupertinoIcons.clear_circled_solid),
                           )
                         : null,
                   ).create(field.context),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : contentSelectedBuilder != null
                       ? contentSelectedBuilder(state.value as T, state.context)
                       : defaultContentSelectedBuilder(state.value as T, state.context),
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );

  @override
  FormFieldState<T> createState() {
    return FlSearchItemFormFieldState<T>();
  }
}

class FlSearchItemFormFieldState<T> extends FormFieldState<T> {
  @override
  FlSearchItemFormField<T> get widget => super.widget as FlSearchItemFormField<T>;

  @override
  void didUpdateWidget(covariant FormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
    }
  }
}

Widget defaultContentSelectedBuilder<T>(T data, BuildContext context) {
  return Text(data.toString());
}
