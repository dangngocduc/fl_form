import 'package:fl_form/formfield/form_field_utils.dart';
import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:fl_form/formfield/widget/input_decoration_builder.dart';
import 'package:fl_form/formfield/widget/label_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fl_form_field_theme.dart';

class FlDurationFormField extends FormField<Duration> {
  FlDurationFormField({
    super.key,
    Duration? initialValue,
    FormFieldSetter<Duration>? onSaved,
    FormFieldValidator<Duration>? validator,
    AutovalidateMode? autovalidateMode,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    bool isRequired = false,
    bool enabled = true,
    CupertinoTimerPickerMode timerPickerMode = CupertinoTimerPickerMode.hms,
    String? helperText,
  }) : super(
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         autovalidateMode: autovalidateMode,
         enabled: enabled,
         builder: (state) {
           //
           //showCupertinoModalPopup(context: field.context, builder: builder);
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               LabelWidget(label: label, isRequired: isRequired),
               GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {
                   showCupertinoModalPopup<Duration>(
                     context: state.context,
                     builder: (context) {
                       Duration duration = state.value ?? const Duration();
                       return StatefulBuilder(
                         builder: (context, setState) {
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                             children: [
                               Container(
                                 padding: const EdgeInsets.only(bottom: 12),
                                 decoration: ShapeDecoration(
                                   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                                   color: Theme.of(context).dialogBackgroundColor,
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                   children: [
                                     Material(
                                       color: Colors.transparent,
                                       child: Container(
                                         height: 48,
                                         width: MediaQuery.of(context).size.width,
                                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).copyWith(bottom: 0),
                                         child: NavigationToolbar(
                                           middle: Text(label, style: Theme.of(context).dialogTheme.titleTextStyle),
                                           trailing: TextButton(
                                             onPressed: () {
                                               Navigator.pop(context, duration);
                                             },
                                             child: Text(MaterialLocalizations.of(context).okButtonLabel),
                                           ),
                                         ),
                                       ),
                                     ),
                                     CupertinoTimerPicker(
                                       mode: timerPickerMode,
                                       initialTimerDuration: duration,
                                       alignment: Alignment.bottomCenter,
                                       onTimerDurationChanged: (value) {
                                         setState(() {
                                           duration = value;
                                         });
                                       },
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           );
                         },
                       );
                     },
                   ).then((value) {
                     if (value != null) {
                       state.didChange(value);
                     }
                   });
                 },
                 child: InputDecorator(
                   decoration: InputDecorationBuilder(
                     enabled: enabled,
                     hasError: state.hasError,
                     helperText: helperText,
                     placeholderText: placeholderText,
                     prefixIcon: prefixIcon,
                   ).create(state.context),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : Text(FormFieldUtils.formatDuration(state.value!, state.context), style: Theme.of(state.context).extension<FlFormFieldTheme>()?.style),
                 ),
               ),
               if (state.hasError) defaultErrorBuilder(state.context, state.errorText!),
             ],
           );
         },
       );
}
