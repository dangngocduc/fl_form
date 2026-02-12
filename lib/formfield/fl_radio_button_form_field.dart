import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

class FlRadioButtonFormField<T> extends FormField<T> {
  FlRadioButtonFormField({
    super.key,
    required String label,
    bool isRequired = false,
    super.validator,
    super.initialValue,
    required List<FormFieldOption<T>> options,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    super.autovalidateMode,
    super.onSaved,
    ValueChanged<T?>? onChanged,
    super.restorationId,
    super.enabled = true,
    String? helperText,
    String? placeholderText,
    bool vertical = true,
  }) : super(
         builder: (state) {
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             helperText: helperText,
             errorText: state.errorText,
             content: RadioGroup<T>(
               onChanged: (T? value) {
                 onChanged?.call(value);
                 state.didChange(value);
               },
               groupValue: state.value,
               child: vertical
                   ? _VerticalWidget(options: options, builder: builder, enabled: enabled)
                   : _HorizontalWidget(options: options, builder: builder, enabled: enabled),
             ),
           );
         },
       );

  static List<Widget> _buildChildren<T>(BuildContext context, List<FormFieldOption<T>> options, FormFieldWidgetBuilder builder, bool enabled) {
    return options.map((e) {
      return InkWell(
        onTap: enabled
            ? () {
                RadioGroup.maybeOf<T>(context)?.onChanged(e.value);
              }
            : null,
        child: Row(
          children: [
            Radio<T>(key: e.label != null ? Key(e.label!) : null, value: e.value, enabled: enabled),
            builder.buildForContent(context, e),
          ],
        ),
      );
    }).toList();

    // // intrinsic width is necessary for horizontal elements
    // return IntrinsicWidth(
    //   child: RadioListTile(
    //     value: e.value,
    //     //dense: true,
    //     enabled: enabled,
    //     //visualDensity: VisualDensity.compact,
    //     title: builder.buildForContent(state.context, e),
    //   ),
    // );
    //}).toList();
  }
}

//////////////////////////////////////////////////////////////////////////////

class _VerticalWidget<T> extends StatelessWidget {
  final List<FormFieldOption<T>> options;
  final FormFieldWidgetBuilder builder;

  final bool enabled;

  const _VerticalWidget({super.key, required this.options, required this.builder, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: FlRadioButtonFormField._buildChildren(context, options, builder, enabled));
  }
}
//////////////////////////////////////////////////////////////////////////////

class _HorizontalWidget<T> extends StatelessWidget {
  final List<FormFieldOption<T>> options;
  final FormFieldWidgetBuilder builder;

  final bool enabled;

  const _HorizontalWidget({super.key, required this.options, required this.builder, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: FlRadioButtonFormField._buildChildren(context, options, builder, enabled),
      ),
    );
  }
}
