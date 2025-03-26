import 'dart:math';

import 'package:flutter/material.dart';

class ShapeCornersPainter extends CustomPainter {
  const ShapeCornersPainter({
    required this.numberOfCorners,
    required this.radius,
    required this.color,
  }) : assert(numberOfCorners > 0, 'Number of corners must be greater than 0.');
  final int numberOfCorners;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Calculate the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);
    final shapeRadius = min(size.width, size.height) / 3;

    if (numberOfCorners == 1) {
      // Draw a single circle at the top center
      final topCenter = Offset(size.width / 2, center.dy - shapeRadius);
      canvas.drawCircle(topCenter, radius, paint);
    } else if (numberOfCorners == 2) {
      // Draw two circles: one at the top center and one at the bottom center
      final topCenter = Offset(size.width / 2, center.dy - shapeRadius);
      final bottomCenter = Offset(size.width / 2, center.dy + shapeRadius);
      canvas
        ..drawCircle(topCenter, radius, paint)
        ..drawCircle(bottomCenter, radius, paint);
    } else {
      // Draw circles at the corners of the shape for numbers greater than 2
      const startingAngle = -pi / 2; // Ensure one point is at the top center
      for (var i = 0; i < numberOfCorners; i++) {
        final angle = startingAngle + (2 * pi / numberOfCorners) * i;
        final x = center.dx + shapeRadius * cos(angle);
        final y = center.dy + shapeRadius * sin(angle);
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
