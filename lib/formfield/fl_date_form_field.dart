import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// todo pattern for date field (dd/mm/yyyy versus yyyy-mm-dd)
/// A form field for selecting a date.
///
/// The [FlDateFormField] displays a read-only field that, when tapped, opens a
/// date picker dialog. It is designed to be used within a [Form] and supports
/// validation and error handling.
class FlDateFormField extends FormField<DateTime> {
  /// Creates a new instance of [FlDateFormField].
  ///
  /// The [label] is a required string that describes the date field.
  /// The [dateFormat] allows for custom date formatting.
  /// The [firstDate] and [lastDate] define the selectable date range.
  FlDateFormField({
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    super.validator,
    super.onSaved,
    ValueChanged<DateTime?>? onChanged,
    super.autovalidateMode,
    super.initialValue,
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
           DateFormat _dateFormat = dateFormat ?? DateFormat('dd/MM/yyyy');
           final state = field as FlDateFormFieldState;
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             onTap: enabled
                 ? () {
                     showDatePicker(
                       context: state.context,
                       initialDate: state.value ?? DateTime.now(),
                       firstDate: firstDate ?? DateTime.now().add(Duration(days: -3650)),
                       lastDate: lastDate ?? DateTime.now().add(Duration(days: 3650)),
                     ).then((value) {
                       if (value != null) {
                         state.didChange(value);
                         if (onChanged != null) {
                           onChanged(value);
                         }
                       }
                     });
                   }
                 : null,
             //             autofocus: autofocus,
             content: Text(state.value == null ? _dateFormat.pattern ?? 'YYYY/MM/DD' : _dateFormat.format(state.value!)),
           );
         },
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
