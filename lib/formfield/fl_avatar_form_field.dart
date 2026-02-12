import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';
import 'fl_raw_avatar_form_field.dart';

/// A form field for selecting and displaying an avatar from a file or network URL.
///
/// The [FlAvatarFormField] is a circular avatar widget that allows users to pick an
/// image from their gallery. It displays the selected image as a circular avatar
/// and provides an edit icon to change the selection.
///
/// This widget is designed to be used within a [Form] and supports validation
/// and error handling.
class FlAvatarFormField extends FormField<FileOrLink> {
  /// Creates a new instance of [FlAvatarFormField].
  ///
  /// The [label] is a required string that describes the avatar field.
  /// The [radius] determines the size of the circular avatar.
  /// The [borderWidth] sets the width of the border around the avatar.
  /// The [isRequired] flag indicates whether an avatar must be selected.
  FlAvatarFormField({
    TextStyle? textStyle,
    double radius = 32,
    double borderWidth = 2,
    required String label,
    String? placeholderText,
    String? helperText,
    bool isRequired = false,
    super.initialValue,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
         builder: (state) {
           Color borderColor = state.hasError
               ? Theme.of(state.context).extension<FlFormFieldTheme>()!.inputDecorationTheme.errorBorder!.borderSide.color
               : Theme.of(state.context).extension<FlFormFieldTheme>()!.inputDecorationTheme.enabledBorder!.borderSide.color;
           Widget child;
           if (state.value == null) {
             child = CircleAvatar(
               backgroundColor: borderColor,
               radius: radius + borderWidth,
               child: CircleAvatar(backgroundColor: borderColor, radius: radius),
             );
           } else {
             child = CircleAvatar(
               backgroundColor: borderColor,
               radius: radius + borderWidth,
               child: CircleAvatar(radius: radius, backgroundColor: borderColor, backgroundImage: state.value!.getImage()),
             );
           }
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             helperText: helperText,
             errorText: state.errorText,
             onTap: () {
               FlRawAvatarFormField.pickFile().then((value) {
                 if (value != null) {
                   state.didChange(value);
                 }
               });
             },
             content: Stack(
               alignment: Alignment.center,
               children: [
                 Positioned(child: child),
                 Positioned.fill(
                   child: Container(
                     decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
                     child: state.hasError ? Icon(Icons.warning, color: borderColor, size: 16) : const Icon(Icons.edit, color: Colors.white, size: 16),
                   ),
                 ),
               ],
             ),
           );
         },
       );
}
