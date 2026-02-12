import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_field_utils.dart';

class FlDurationFormField extends FormField<Duration> {
  FlDurationFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    FormFieldSetter<Duration>? onChanged,
    super.validator,
    super.autovalidateMode,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    bool isRequired = false,
    super.enabled,
    CupertinoTimerPickerMode timerPickerMode = CupertinoTimerPickerMode.hms,
    String? helperText,
  }) : super(
         builder: (state) {
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             errorText: state.errorText,
             helperText: helperText,
             onTap: enabled
                 ? () {
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
                                             onChanged?.call(value);
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
                   }
                 : null,
             //             autofocus: autofocus,
             content: state.value == null ? null : Text(FormFieldUtils.formatDuration(state.value!, state.context)),
           );
         },
       );
}
