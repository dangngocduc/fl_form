import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef FlRawAvatarFormFieldBuilder = Widget Function({
  required BuildContext context,
  FileOrLink? data,
  required ValueChanged<FileOrLink?> didChange,
  String? error,
});

/// A raw, unstyled form field for handling avatar selection.
///
/// The [FlRawAvatarFormField] provides the basic functionality for picking an image
/// and managing its state. It is intended to be used as a base for creating
/// custom avatar form fields with specific styling.
///
/// The [builder] function is required and is used to construct the UI for the
/// avatar field.
class FlRawAvatarFormField extends FormField<FileOrLink> {
  static Future<FileOrLink?> pickFile() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return FileOrLink.file(
        File(file.path),
      );
    } else {
      return null;
    }
  }

  FlRawAvatarFormField({
    TextStyle? textStyle,
    double radius = 32,
    double borderWidth = 2,
    FileOrLink? initialValue,
    FormFieldSetter<FileOrLink>? onSaved,
    FormFieldValidator<FileOrLink>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    required FlRawAvatarFormFieldBuilder builder,
    super.key,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          restorationId: restorationId,
          builder: (state) {
            return builder(
              context: state.context,
              data: state.value,
              didChange: state.didChange,
              error: state.errorText,
            );
          },
        );
}

/// A class that represents either a local file or a network URL.
///
/// The [FileOrLink] class is used to handle images from different sources.
/// It can hold either a [File] object for local images or a [String] URL for
/// network images.
class FileOrLink {
  final String? link;
  final File? file;

  FileOrLink({this.link, this.file});

  factory FileOrLink.link(String link) {
    return FileOrLink(link: link);
  }

  factory FileOrLink.file(File file) {
    return FileOrLink(file: file);
  }

  ImageProvider getImage() {
    if (link == null) {
      return FileImage(
        file!,
      );
    } else {
      return NetworkImage(link!);
    }
  }
}
