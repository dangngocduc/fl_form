import 'dart:developer' as developer;

import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fl_form_field_theme.dart';

/// A form field for entering monetary values.
///
/// The [FlMoneyFormField] displays a text input field with a currency symbol and
/// provides formatting for monetary values. It is designed to be used within a
/// [Form] and supports validation and error handling.
class FlMoneyFormField extends FormField<double> {
  /// Creates a new instance of [FlMoneyFormField].
  ///
  /// The [label] is a required string that describes the money field.
  /// The [currency] is the currency symbol to be displayed.
  /// The [initialValue] is the initial value of the field.
  FlMoneyFormField({
    super.key,
    double? initialValue,
    FormFieldSetter<double>? onSaved,
    FormFieldValidator<double>? validator,
    AutovalidateMode? autovalidateMode,
    required String currency,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    bool isRequired = false,
    bool enabled = true,
  }) : super(
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         builder: (field) {
           final state = field as _FlMoneyFormFieldState;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               InputDecorator(
                 decoration: InputDecoration(
                   hintText: placeholderText,
                   prefixIcon: prefixIcon,
                   enabledBorder: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   focusedBorder: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                   border: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   contentPadding: EdgeInsets.zero,
                 ).applyDefaults(Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(state.context).inputDecorationTheme),
                 isEmpty: false,
                 child: Row(
                   children: [
                     Expanded(
                       child: TextField(
                         onChanged: (value) {
                           if (value.isNotEmpty) {
                             var moneyText = value.replaceAll(',', '');

                             if (moneyText.endsWith('.')) {
                               moneyText = moneyText.replaceAll('.', '');
                             }

                             if (moneyText.isNotEmpty) {
                               state.didChange(double.tryParse(moneyText) ?? 0);
                             }
                           }
                         },
                         keyboardType: TextInputType.number,
                         controller: state.controller,
                         style: Theme.of(state.context).extension<FlFormFieldTheme>()!.style,
                         decoration: InputDecoration(
                           contentPadding: Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding,
                           hintText: placeholderText,
                           hintStyle: Theme.of(state.context).extension<FlFormFieldTheme>()!.placeHolderStyle,
                           border: InputBorder.none,
                           focusedBorder: InputBorder.none,
                           errorBorder: InputBorder.none,
                           enabledBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,
                           focusedErrorBorder: InputBorder.none,
                         ),
                       ),
                     ),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12),
                       decoration: BoxDecoration(border: Border(left: Divider.createBorderSide(state.context))),
                       child: Text(currency, style: Theme.of(state.context).extension<FlFormFieldTheme>()!.style),
                     ),
                   ],
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );

  @override
  FormFieldState<double> createState() {
    return _FlMoneyFormFieldState();
  }
}

class _FlMoneyFormFieldState extends FormFieldState<double> {
  late TextEditingController controller;

  @override
  FlMoneyFormField get widget => super.widget as FlMoneyFormField;

  @override
  void initState() {
    super.initState();
    // controller = MoneyMaskedTextController(
    //     initialValue: widget.initialValue ?? 0,
    //     decimalSeparator: '.',
    //     thousandSeparator: ',');
    controller = FlMoneyTextController(widget.initialValue ?? 0);
  }
}

class FlMoneyTextController extends TextEditingController {
  String _lastUpdatedText = '';

  FlMoneyTextController(double value) {
    addListener(() {
        // var previous = this._lastUpdatedText;
      updateText(text);
    });
    text = NumberFormat.decimalPattern().format(value);
    updateText(text);
  }

  void moveCursorToEnd() {
    var text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: (text).length));
  }

  void updateText(String text) {
    if (text.isNotEmpty) {
      if (text.endsWith(',')) {
        setText(_lastUpdatedText);
      } else {
        if (text.endsWith('.')) {
          if (_lastUpdatedText.endsWith('.')) {
            setText(_lastUpdatedText);
          } else {
            setText(text);
          }
        } else {
          setText(text);
        }
      }
    }

    _lastUpdatedText = this.text;
    moveCursorToEnd();
  }

  void setText(String text) {
    final newText = text.replaceAll(',', '');
    if (newText.contains('.')) {
      final first = newText.split('.').first;
      final sencond = newText.split('.')[1];
      this.text = '${NumberFormat.decimalPattern().format(int.parse(first))}.$sencond';
    } else {
      if (newText.isNotEmpty) {
        this.text = NumberFormat.decimalPattern().format(int.parse(newText));
      } else {
        this.text = newText;
      }
    }
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }
}

// MaskedTextController.getDefaultTranslator()
