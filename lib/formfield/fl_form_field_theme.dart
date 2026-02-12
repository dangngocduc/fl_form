import 'package:flutter/material.dart';

/// A custom theme extension for `FlFormField` widgets.
///
/// This theme provides centralized styling for all `FlFormField` widgets in the app,
/// ensuring a consistent look and feel. It includes styles for labels, input decorations,
/// text, errors, and placeholders.
///
/// To use this theme, add it to your `MaterialApp`'s theme extensions:
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData.light().copyWith(
///     extensions: [
///       FlFormFieldTheme.light(context),
///     ],
///   ),
///   // ...
/// );
/// ```
class FlFormFieldTheme extends ThemeExtension<FlFormFieldTheme> {
  final TextStyle labelStyle;
  final InputDecorationTheme inputDecorationTheme;
  final TextStyle style;
  final TextStyle disableStyle;
  final TextStyle errorStyle;
  final TextStyle placeHolderStyle;
  final Color fillColorDisable;

  /// Creates a new instance of [FlFormFieldTheme].
  ///
  /// The [labelStyle] defines the style for the field's label.
  /// The [inputDecorationTheme] provides the base decoration for the input field.
  /// The [style] is the main text style for the input.
  /// The [disableStyle] is used when the field is disabled.
  /// The [errorStyle] is applied when a validation error occurs.
  /// The [placeHolderStyle] is for the placeholder text.
  /// The [fillColorDisable] is the background color when the field is disabled.
  FlFormFieldTheme({
    required this.labelStyle,
    required this.inputDecorationTheme,
    required this.style,
    required this.disableStyle,
    required this.errorStyle,
    required this.placeHolderStyle,
    required this.fillColorDisable,
  });

  factory FlFormFieldTheme.dark(BuildContext context) {
    var radius = 6.0;
    return FlFormFieldTheme(
      fillColorDisable: Colors.black,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      disableStyle: const TextStyle(fontSize: 16, color: Colors.white),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
      placeHolderStyle: const TextStyle(
          fontSize: 16, color: Colors.white24, fontWeight: FontWeight.w300),
      labelStyle: const TextStyle(fontSize: 12, color: Colors.white70),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
            fontSize: 16, color: Colors.white24, fontWeight: FontWeight.w300),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:
                Divider.createBorderSide(context, color: Colors.white30)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:
                Divider.createBorderSide(context, color: Colors.white70)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.blue)),
        outlineBorder: Divider.createBorderSide(context),
        activeIndicatorBorder: Divider.createBorderSide(context),
      ),
    );
  }

  factory FlFormFieldTheme.light(BuildContext context) {
    var radius = 6.0;
    return FlFormFieldTheme(
      fillColorDisable: Colors.grey[200]!,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      disableStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
      placeHolderStyle: const TextStyle(
          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w300),
      labelStyle: const TextStyle(fontSize: 12, color: Colors.black87),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
            fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w300),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: Divider.createBorderSide(context, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:
                Divider.createBorderSide(context, color: Colors.black87)),
        outlineBorder: Divider.createBorderSide(context),
        activeIndicatorBorder: Divider.createBorderSide(context),
      ),
    );
  }

  @override
  ThemeExtension<FlFormFieldTheme> copyWith({
    TextStyle? labelStyle,
    InputDecorationTheme? inputDecorationTheme,
    TextStyle? style,
    TextStyle? disableStyle,
    TextStyle? errorStyle,
    TextStyle? placeHolderStyle,
    Color? fillColorDisable,
  }) {
    return FlFormFieldTheme(
      disableStyle: disableStyle ?? this.disableStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      fillColorDisable: fillColorDisable ?? this.fillColorDisable,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      labelStyle: labelStyle ?? this.labelStyle,
      placeHolderStyle: placeHolderStyle ?? this.placeHolderStyle,
      style: style ?? this.style,
    );
  }

  @override
  ThemeExtension<FlFormFieldTheme> lerp(
      covariant ThemeExtension<FlFormFieldTheme>? other, double t) {
    return this;
  }
}
