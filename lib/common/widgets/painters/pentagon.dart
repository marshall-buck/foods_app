import 'dart:math';
import 'package:flutter/material.dart';

class PentagonPainter extends CustomPainter {
  const PentagonPainter({
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

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    for (var i = 0; i < 5; i++) {
      final angle = (i * 72) * (3.141592653589793 / 180); // Convert degrees to radians
      final x = centerX + radius * cos(angle - 3.141592653589793 / 2);
      final y = centerY + radius * sin(angle - 3.141592653589793 / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
