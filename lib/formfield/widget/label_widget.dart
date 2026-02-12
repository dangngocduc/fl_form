import 'package:fl_form/formfield/fl_form_field_theme.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;

  final bool isRequired;

  const LabelWidget({super.key, required this.label, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).extension<FlFormFieldTheme>()?.labelStyle ?? Theme.of(context).inputDecorationTheme.floatingLabelStyle,
        children: [
          TextSpan(text: label),
          if (isRequired)
            TextSpan(
              text: ' *',
              style:
                  Theme.of(context).extension<FlFormFieldTheme>()?.labelStyle.copyWith(color: Colors.red) ??
                  Theme.of(context).inputDecorationTheme.floatingLabelStyle?.copyWith(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
