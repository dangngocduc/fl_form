import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/material.dart';

class FlReadonlyField extends StatelessWidget {
  final String label;

  final bool isRequired;

  final bool enabled;

  final bool hasError;

  final String? errorText;

  final String? helperText;

  final String? placeholderText;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final GestureTapCallback? onTap;

  final bool autofocus;

  final Widget? content;

  // Material states controller.
  final WidgetStatesController _statesController = WidgetStatesController();

  FlReadonlyField({
    super.key,
    required this.label,
    this.isRequired = true,
    this.enabled = true,
    this.hasError = false,
    this.errorText,
    this.helperText,
    this.placeholderText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.autofocus = false,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    _statesController.update(WidgetState.disabled, !enabled);
    // _statesController.update(WidgetState.hovered, _isHovering);
    // _statesController.update(WidgetState.focused, _effectiveFocusNode.hasFocus);
    _statesController.update(WidgetState.error, hasError);
    //WidgetStateProperty property = _m3StateInputStyle(context);
    //final TextStyle? providedStyle = WidgetStateProperty.resolveAs(property.resolve(_statesController.value), _statesController.value);
    final TextStyle providedStyle = _calculate(context, _statesController.value);
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        isEmpty: content == null,
        decoration: InputDecoration(
          enabled: enabled,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: content == null ? placeholderText : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: LabelWidget(label: label, isRequired: isRequired),
        ),
        child: content != null
            ? _IconMergeWidget(
                iconColor: providedStyle.color,
                child: DefaultTextStyle(style: providedStyle, child: content!),
              )
            : null,
      ),
    );
  }

  TextStyle _calculate(BuildContext context, Set<WidgetState> state) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;
    if (_statesController.value.contains(WidgetState.disabled)) {
      return TextStyle(inherit: true, fontSize: textStyle.fontSize, color: textStyle.color?.withOpacity(0.38));
    }
    return TextStyle(inherit: true, fontSize: textStyle.fontSize, color: textStyle.color);
  }

  // WidgetStateProperty<TextStyle> _m3StateInputStyle(BuildContext context) => WidgetStateProperty.resolveWith((Set<WidgetState> states) {
  //   if (states.contains(WidgetState.disabled)) {
  //     return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.38));
  //   }
  //   return TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color);
  // });
}

//////////////////////////////////////////////////////////////////////////////

class _IconMergeWidget extends StatelessWidget {
  final Widget child;

  final Color? iconColor;

  const _IconMergeWidget({required this.child, this.iconColor = null});

  @override
  Widget build(BuildContext context) {
    final IconButtonThemeData iconButtonTheme = IconButtonTheme.of(context);
    return IconTheme.merge(
      data: IconThemeData(color: iconColor),
      child: IconButtonTheme(
        data: IconButtonThemeData(style: ButtonStyle(foregroundColor: iconColor != null ? WidgetStatePropertyAll<Color>(iconColor!) : null)),
        child: Semantics(child: child),
      ),
    );
  }
}
