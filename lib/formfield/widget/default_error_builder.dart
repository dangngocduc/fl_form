import 'package:fl_form/formfield/fl_form_field_theme.dart';
import 'package:flutter/material.dart';

Widget defaultErrorBuilder(BuildContext context, String errorText) {
  return Padding(
    // todo: use Theme.of(field.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding completely instead of just the left-property
    padding: EdgeInsets.only(
      top: 4,
      left:
          (Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding != null
                  ? Theme.of(context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets
                  : null)
              ?.left ??
          4,
    ),
    child: Text(errorText, style: Theme.of(context).extension<FlFormFieldTheme>()?.errorStyle ?? TextStyle(color: Theme.of(context).colorScheme.error)),
  );
}
