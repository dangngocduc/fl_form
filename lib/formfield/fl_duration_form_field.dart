import 'package:fl_form/formfield/form_field_utils.dart';
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
               Padding(
                 padding: const EdgeInsets.only(bottom: 4),
                 child: RichText(
                   text: TextSpan(
                     style: Theme.of(state.context).extension<FlFormFieldTheme>()?.labelStyle,
                     children: [
                       TextSpan(text: label),
                       if (isRequired)
                         TextSpan(
                           text: ' *',
                           style: Theme.of(state.context).extension<FlFormFieldTheme>()?.labelStyle.copyWith(color: Colors.red),
                         ),
                     ],
                   ),
                 ),
               ),
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
                                       mode: CupertinoTimerPickerMode.hms,
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
                   decoration: InputDecoration(
                     hintText: placeholderText,
                     prefixIcon: prefixIcon,
                     enabledBorder: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                     focusedBorder: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.focusedErrorBorder : null,
                     border: state.hasError ? Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.errorBorder : null,
                   ).applyDefaults(Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme ?? Theme.of(state.context).inputDecorationTheme),
                   isEmpty: state.value == null,
                   child: state.value == null
                       ? null
                       : Text(FormFieldUtils.formatDuration(state.value!, state.context), style: Theme.of(state.context).extension<FlFormFieldTheme>()?.style),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsets.only(
                     top: 4,
                     left: (Theme.of(state.context).extension<FlFormFieldTheme>()?.inputDecorationTheme.contentPadding as EdgeInsets).left,
                   ),
                   child: RichText(
                     text: TextSpan(
                       style: Theme.of(state.context).extension<FlFormFieldTheme>()?.errorStyle,
                       children: [TextSpan(text: state.errorText)],
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
