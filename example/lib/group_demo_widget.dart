import 'package:flutter/material.dart';

class GroupDemoWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const GroupDemoWidget({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ...children.map((e) => Padding(
                padding: const EdgeInsets.only(top: 12),
                child: e,
              ))
        ],
      ),
    );
  }
}
