import 'package:fl_form/fl_form.dart';
import 'package:flutter/material.dart';

class MultipleItemPickerBottomSheet<T> extends StatefulWidget {
  ///List options of picker
  final List<FormFieldOption<T>> options;

  ///current option selected of picker
  final List<T>? currentOption;

  final FormFieldWidgetBuilder builder;

  static Future<List<T>?> show<T>(BuildContext context, List<FormFieldOption<T>> options, List<T>? currentOption, FormFieldWidgetBuilder builder) {
    return showModalBottomSheet<List<T>>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return MultipleItemPickerBottomSheet<T>(options: options, currentOption: currentOption, builder: builder);
      },
    );
  }

  const MultipleItemPickerBottomSheet({super.key, required this.options, required this.currentOption, required this.builder});

  @override
  State<MultipleItemPickerBottomSheet<T>> createState() => _State<T>();
}

//////////////////////////////////////////////////////////////////////////////

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
      return const SizedBox(height: 200, child: Text('Empty Data'));
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
                  if (currentOption.contains(widget.options[index].value)) {
                    setState(() {
                      currentOption.remove(widget.options[index].value);
                    });
                  } else {
                    setState(() {
                      currentOption.add(widget.options[index].value);
                    });
                  }
                },
                child: widget.builder.buildForList(context, widget.options[index], currentOption.contains(widget.options[index].value)),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, currentOption.isEmpty ? null : currentOption);
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
