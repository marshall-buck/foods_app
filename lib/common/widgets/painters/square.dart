import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {
  const SquarePainter({
    this.fill = false,
    this.stroke = true,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
  }) : assert(fill || stroke, 'Either fill or stroke must be true.');
  final bool fill;
  final bool stroke;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
