import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A painter for drawing a hexagon shape.
///
/// {@template HexagonPainter}
/// - [color] specifies the color of the hexagon.
/// - [fill] determines whether the hexagon is filled. Defaults to `false`.
/// - [stroke] determines whether the hexagon has a stroke. Defaults to `true`.
/// - [strokeWidth] specifies the width of the stroke. Defaults to `1.0`.
/// {@endtemplate}
class HexagonPainter extends BaseShapePainter {
  /// {@macro HexagonPainter}
  const HexagonPainter({
    required super.color,
    super.fill,
    super.stroke,
    super.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = (size.width / 2) - strokeAdjusterToFit;

    for (var i = 0; i < 6; i++) {
      final angle = (i * 60) * (pi / 180); // Convert degrees to radians
      final x = centerX + radius * cos(angle - pi / 2);
      final y = centerY + radius * sin(angle - pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }
}
