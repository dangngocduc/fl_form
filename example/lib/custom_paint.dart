import 'package:flutter/material.dart';

class AppCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final matrix4 = Matrix4.identity()..setEntry(3, 2, 0.003);
    matrix4.rotateX(12);
    canvas.transform(matrix4.storage);
    canvas.drawRRect(
        RRect.fromLTRBR(
            0, 0, size.width, size.height, const Radius.circular(4)),
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
