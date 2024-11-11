import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularRangeSliderPainter extends CustomPainter {
  CircularRangeSliderPainter(this.value);
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the stroke
    final strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, strokePaint);

    // Draw the handle
    final handleAngle = -math.pi / 2 + 2 * math.pi * value;
    final handleOffset = Offset(
      center.dx + radius * math.cos(handleAngle),
      center.dy + radius * math.sin(handleAngle),
    );

    // handle
    canvas.drawCircle(handleOffset, 4, strokePaint);
  }

  @override
  bool shouldRepaint(CircularRangeSliderPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
