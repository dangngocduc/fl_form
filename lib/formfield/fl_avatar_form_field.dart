import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';
import 'fl_raw_avatar_form_field.dart';

class FlAvatarFormField extends FormField<FileOrLink> {
  FlAvatarFormField({
    TextStyle? textStyle,
    double radius = 32,
    double borderWidth = 2,
    FileOrLink? initialValue,
    FormFieldSetter<FileOrLink>? onSaved,
    FormFieldValidator<FileOrLink>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    super.key,
  }) : super(
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         restorationId: restorationId,
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
           return Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               GestureDetector(
                 onTap: () {
                   FlRawAvatarFormField.pickFile().then((value) {
                     if (value != null) {
                       state.didChange(value);
                     }
                   });
                 },
                 child: Stack(
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
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );
}
