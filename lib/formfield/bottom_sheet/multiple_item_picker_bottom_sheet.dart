import 'package:flutter/material.dart';

typedef ContentSelectedBuilder<T> = Widget Function(
    List<T>? datas, BuildContext context);

typedef ValueSelectorWidgetBuilder<T> = Widget Function(
    BuildContext context, T value, bool isSelected);

class MultipleItemPickerBottomSheet<T> extends StatefulWidget {
  ///Show value selected on formfield
  final ValueSelectorWidgetBuilder<T> itemBuilder;

  ///List options of picker
  final List<T> options;

  ///current option selected of picker
  final List<T>? currentOption;

  static Future<List<T>?> show<T>(
    BuildContext context,
    ValueSelectorWidgetBuilder<T> itemBuilder,
    List<T> options,
    List<T>? currentOption,
  ) {
    return showModalBottomSheet<List<T>>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return MultipleItemPickerBottomSheet<T>(
          itemBuilder: itemBuilder,
          options: options,
          currentOption: currentOption,
        );
      },
    );
  }

  const MultipleItemPickerBottomSheet({
    Key? key,
    required this.itemBuilder,
    required this.options,
    required this.currentOption,
  }) : super(key: key);

  @override
  State<MultipleItemPickerBottomSheet<T>> createState() => _State<T>();
}

class _State<T> extends State<MultipleItemPickerBottomSheet<T>> {
  late List<T> currentOption;

  @override
  void initState() {
    super.initState();
    currentOption = [...widget.currentOption ?? []];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Text('Empty Data'),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (currentOption.contains(widget.options[index])) {
                    setState(() {
                      currentOption.remove(widget.options[index]);
                    });
                  } else {
                    setState(() {
                      currentOption.add(widget.options[index]);
                    });
                  }
                },
                child: widget.itemBuilder(
                  context,
                  widget.options[index],
                  currentOption.contains(widget.options[index]),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, currentOption);
            },
            child: const Text('Submit'),
          ),
        )
      ],
    );
  }
}
