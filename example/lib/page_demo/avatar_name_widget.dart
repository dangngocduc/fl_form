import 'dart:developer' as developer;
import 'package:flutter/material.dart';

List<Color> _colors = [
  Colors.blueAccent,
  Colors.red,
  Colors.yellow,
  Colors.black,
  Colors.teal,
  Colors.brown,
  Colors.orange,
  Colors.grey,
  Colors.indigo,
  Colors.amber,
  Colors.purple,
  Colors.lime,
];

class AvatarNameWidget extends StatelessWidget {
  final String name;
  final double radius;
  const AvatarNameWidget({
    Key? key,
    required this.name,
    this.radius = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String contentName;

    contentName = name
        .split(' ')
        .where((element) => element.isNotEmpty)
        .map((e) => e.characters.first)
        .join('');

    contentName = contentName.characters.take(2).join();
    return Container(
      width: radius * 2,
      height: radius * 2,
      padding: EdgeInsets.all(radius / 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _colors[name.codeUnitAt(0) % _colors.length],
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          contentName.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
