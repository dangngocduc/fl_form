import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class ItemPickerDefaultWidget<T> extends StatefulWidget {
  final T data;
  final bool isSelected;
  const ItemPickerDefaultWidget({
    Key? key,
    required this.data,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ItemPickerDefaultWidget<T>> createState() =>
      _ItemPickerDefaultWidgetState<T>();
}

class _ItemPickerDefaultWidgetState<T>
    extends State<ItemPickerDefaultWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.data.toString(),
            ),
          ),
          if (widget.isSelected) const Icon(Icons.done)
        ],
      ),
    );
  }
}
