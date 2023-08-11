import 'package:flutter/material.dart';

typedef ContentSelectedBuilder<T> = Widget Function(
    T data, BuildContext context);

typedef ValueSelectorWidgetBuilder<T> = Widget Function(
    BuildContext context, T value, bool isSelected);

class SingleItemPickerBottomSheet<T> extends StatelessWidget {
  ///Show value selected on formfield
  final ValueSelectorWidgetBuilder<T> itemBuilder;

  ///List options of picker
  final List<T> options;

  ///current option selected of picker
  final T? currentOption;

  static Future<T?> show<T>(
    BuildContext context,
    ValueSelectorWidgetBuilder<T> itemBuilder,
    List<T> options,
    T? currentOption,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SingleItemPickerBottomSheet<T>(
          itemBuilder: itemBuilder,
          options: options,
          currentOption: currentOption,
        );
      },
    );
  }

  const SingleItemPickerBottomSheet({
    Key? key,
    required this.itemBuilder,
    required this.options,
    required this.currentOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Text('Empty Data'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: options[index] == currentOption
              ? null
              : () {
                  Navigator.pop(
                    context,
                    options[index],
                  );
                },
          child: itemBuilder(
            context,
            options[index],
            options[index] == currentOption,
          ),
        );
      },
    );
  }
}
