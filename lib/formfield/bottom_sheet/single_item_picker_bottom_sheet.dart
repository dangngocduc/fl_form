import 'package:flutter/material.dart';

import '../form_field_option.dart';

class SingleItemPickerBottomSheet<T> extends StatelessWidget {
  ///List options of picker
  final List<FormFieldOption<T>> options;

  ///current option selected of picker
  final T? currentOption;

  final FormFieldWidgetBuilder builder;

  static Future<T?> show<T>(BuildContext context, List<FormFieldOption<T>> options, T? currentOption, FormFieldWidgetBuilder builder) {
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SingleItemPickerBottomSheet<T>(options: options, currentOption: currentOption, builder: builder);
      },
    );
  }

  const SingleItemPickerBottomSheet({super.key, required this.options, required this.currentOption, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox(height: 200, child: Text('Empty Data'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: options[index] == currentOption
              ? null
              : () {
                  Navigator.pop(context, options[index].value);
                },
          child: builder.buildForList(context, options[index], options[index].value == currentOption),
        );
      },
    );
  }
}
