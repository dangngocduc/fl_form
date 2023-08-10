import 'package:flutter/material.dart';

import 'form_field_utils.dart';

typedef ContentDisplayBuilder<T> = String Function(
    BuildContext context, T value);

class DropDownFormField<T> extends FormField<T> {
  DropDownFormField({
    InputDecoration? decoration,
    TextStyle? textStyle,
    required ContentDisplayBuilder contentDisplayBuilder,
    super.key,
  }) : super(
          builder: (state) {
            InputDecoration effectiveInputDeco = (decoration ??
                    FormFieldUtils.kDefaultInputdecoration.copyWith())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme)
                .copyWith(
                    errorText: state.errorText,
                    prefixIcon: const Icon(Icons.keyboard_arrow_down));
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: InputDecorator(
                decoration: effectiveInputDeco,
                textAlignVertical: TextAlignVertical.center,
                isEmpty: false,
                child: state.value != null
                    ? Text(
                        contentDisplayBuilder(state.context, state.value),
                        style: textStyle,
                      )
                    : Text(
                        '${effectiveInputDeco.hintText}',
                        style: textStyle,
                      ),
              ),
            );
          },
        );
}
