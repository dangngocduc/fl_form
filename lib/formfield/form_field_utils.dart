import 'package:flutter/material.dart';

class FormFieldUtils {
  static InputDecoration kDefaultInputdecoration = InputDecoration(
      border: kInputborder.copyWith(
        borderSide: BorderSide(width: 1, color: Colors.grey[200]!),
      ),
      enabledBorder: kInputborder.copyWith(
        borderSide: const BorderSide(width: 1, color: Colors.black38),
      ),
      errorBorder: kInputborder.copyWith(
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedBorder: kInputborder.copyWith(
        borderSide: const BorderSide(width: 1, color: Colors.blue),
      ),
      disabledBorder: kInputborder.copyWith(
        borderSide: const BorderSide(width: 1, color: Colors.black26),
      ),
      hoverColor: Colors.blue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12));

  static OutlineInputBorder kInputborder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  static formatDuration(Duration duration, BuildContext context) {
    return '${duration.inHours} ${MaterialLocalizations.of(context).timePickerHourLabel} ${duration.inMinutes - duration.inHours * 60} ${MaterialLocalizations.of(context).timePickerMinuteLabel}';
  }
}
