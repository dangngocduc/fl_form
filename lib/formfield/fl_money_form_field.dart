import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';
import 'dart:developer' as developer;

class FlMoneyFormField extends FormField<double> {
  FlMoneyFormField({
    super.key,
    double? initialValue,
    FormFieldSetter<double>? onSaved,
    FormFieldValidator<double>? validator,
    AutovalidateMode? autovalidateMode,
    required String currency,
    required String label,
    required String placeholderText,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: RichText(
                    text: TextSpan(
                        style: Theme.of(state.context)
                            .extension<FlFormFieldTheme>()
                            ?.labelStyle,
                        children: [
                          TextSpan(text: label),
                          if (isRequired)
                            TextSpan(
                              text: ' *',
                              style: Theme.of(state.context)
                                  .extension<FlFormFieldTheme>()
                                  ?.labelStyle
                                  .copyWith(color: Colors.red),
                            ),
                        ]),
                  ),
                ),
                InputDecorator(
                  decoration: InputDecoration(
                          hintText: placeholderText,
                          prefixIcon: prefixIcon,
                          enabledBorder: state.hasError
                              ? Theme.of(state.context)
                                  .extension<FlFormFieldTheme>()
                                  ?.inputDecorationTheme
                                  .errorBorder
                              : null,
                          focusedBorder: state.hasError
                              ? Theme.of(state.context)
                                  .extension<FlFormFieldTheme>()
                                  ?.inputDecorationTheme
                                  .focusedErrorBorder
                              : null,
                          border: state.hasError
                              ? Theme.of(state.context)
                                  .extension<FlFormFieldTheme>()
                                  ?.inputDecorationTheme
                                  .errorBorder
                              : null,
                          contentPadding: EdgeInsets.zero)
                      .applyDefaults(Theme.of(state.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme ??
                          Theme.of(state.context).inputDecorationTheme),
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
                                state
                                    .didChange(double.tryParse(moneyText) ?? 0);
                              }
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [],
                          controller: state.controller,
                          style: Theme.of(state.context)
                              .extension<FlFormFieldTheme>()!
                              .style,
                          decoration: InputDecoration(
                            contentPadding: Theme.of(state.context)
                                .extension<FlFormFieldTheme>()
                                ?.inputDecorationTheme
                                .contentPadding,
                            hintText: placeholderText,
                            hintStyle: Theme.of(state.context)
                                .extension<FlFormFieldTheme>()!
                                .placeHolderStyle,
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
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border(
                                left: Divider.createBorderSide(state.context))),
                        child: Text(
                          currency,
                          style: Theme.of(state.context)
                              .extension<FlFormFieldTheme>()!
                              .style,
                        ),
                      )
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: (Theme.of(state.context)
                              .extension<FlFormFieldTheme>()
                              ?.inputDecorationTheme
                              .contentPadding as EdgeInsets)
                          .left,
                    ),
                    child: RichText(
                      text: TextSpan(
                          style: Theme.of(state.context)
                              .extension<FlFormFieldTheme>()
                              ?.errorStyle,
                          children: [
                            TextSpan(text: state.errorText),
                          ]),
                    ),
                  ),
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
    controller = FlMoneyTextController();
  }
}

class FlMoneyTextController extends TextEditingController {
  String _lastUpdatedText = '';

  FlMoneyTextController() {
    addListener(() {
      developer.log('update: ${this.text}', name: 'FlMoneyFormField');
      // var previous = this._lastUpdatedText;
      this.updateText(this.text);
    });
    updateText(this.text);
  }

  void moveCursorToEnd() {
    var text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: (text).length));
  }

  void updateText(String text) {
    if (text.isNotEmpty) {
      if (text.endsWith(',')) {
        this.text = _lastUpdatedText;
      } else {
        if (text.endsWith('.')) {
          if (_lastUpdatedText.contains('.')) {
            this.text = _lastUpdatedText;
          } else {
            this.text = text;
          }
        } else {}
      }
    }

    _lastUpdatedText = this.text;
    moveCursorToEnd();
  }

  @override
  void set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }
}

// MaskedTextController.getDefaultTranslator()
class MaskedTextController extends TextEditingController {
  MaskedTextController({
    required String text,
    required this.mask,
    required this.translator,
  }) : super(text: text) {
    addListener(() {
      var previous = this._lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        this.updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        this.updateText(this._lastUpdatedText);
      }
    });

    this.updateText(this.text);
  }

  String mask;

  final Map<String, RegExp> translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null) {
      this.text = this._applyMask(this.mask, text);
    } else {
      this.text = '';
    }

    this._lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    this.updateText(this.text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = this._lastUpdatedText;
    this.selection = new TextSelection.fromPosition(
        new TextPosition(offset: (text ?? '').length));
  }

  @override
  void set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': new RegExp(r'[A-Za-z]'),
      '0': new RegExp(r'[0-9]'),
      '@': new RegExp(r'[A-Za-z0-9]'),
      '*': new RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (this.translator.containsKey(maskChar)) {
        if (this.translator[maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

/**
 * Mask for monetary values.
 */
class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {double initialValue = 0.0,
      this.decimalSeparator = ',',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 2}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.parse(parts.join());
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
