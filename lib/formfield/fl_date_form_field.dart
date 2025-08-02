import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fl_form_field_theme.dart';

class FlDateFormField extends FormField<DateTime> {
  FlDateFormField({
    DateFormat? dateFormat,
    required DateTime firstDate,
    required DateTime lastDate,
    FormFieldValidator<DateTime>? validator,
    FormFieldSetter<DateTime>? onSaved,
    AutovalidateMode? autovalidateMode,
    DateTime? initialValue,
    required String label,
    required String? placeholderText,
    bool isRequired = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? helperText,
    bool enabled = true,
    super.key,
  }) : super(
         builder: (field) {
           final state = field as FlDateFormFieldState;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: enabled
                     ? () {
                         showDatePicker(context: state.context, initialDate: state.value ?? DateTime.now(), firstDate: firstDate, lastDate: lastDate).then((
                           value,
                         ) {
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
                     suffixIcon: suffixIcon,
                   ).create(field.context),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : Text(
                           (dateFormat ?? DateFormat(DateFormat.YEAR_MONTH_DAY)).format(state.value!),
                           style: Theme.of(field.context).extension<FlFormFieldTheme>()?.style,
                         ),
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
         validator: validator,
         onSaved: onSaved,
         initialValue: initialValue,
         autovalidateMode: autovalidateMode,
       );
  @override
  FlDateFormFieldState createState() => FlDateFormFieldState();
}

class FlDateFormFieldState extends FormFieldState<DateTime> {
  bool isFocused = false;

  void setIsFocused(bool newValue) {
    setState(() {
      isFocused = newValue;
    });
  }
}
