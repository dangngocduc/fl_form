import 'package:flutter/material.dart';

class FlFormFieldTheme extends ThemeExtension<FlFormFieldTheme> {
  final TextStyle labelStyle;
  final InputDecorationTheme inputDecorationTheme;
  final TextStyle style;
  final TextStyle errorStyle;
  final TextStyle placeHolderStyle;

  FlFormFieldTheme({
    required this.labelStyle,
    required this.inputDecorationTheme,
    required this.style,
    required this.errorStyle,
    required this.placeHolderStyle,
  });

  factory FlFormFieldTheme.dark(BuildContext context) {
    var radius = 4.0;
    return FlFormFieldTheme(
      style: const TextStyle(fontSize: 16, color: Colors.white),
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

  @override
  ThemeExtension<FlFormFieldTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<FlFormFieldTheme> lerp(
      covariant ThemeExtension<FlFormFieldTheme>? other, double t) {
    return this;
  }
}
