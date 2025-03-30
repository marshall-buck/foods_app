import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A painter for drawing a triangle shape.
///
/// {@template TrianglePainter}
/// - [color] specifies the color of the triangle.
/// - [fill] determines whether the triangle is filled. Defaults to `false`.
/// - [stroke] determines whether the triangle has a stroke. Defaults to `true`.
/// - [strokeWidth] specifies the width of the stroke. Defaults to `1.0`.
/// {@endtemplate}
class TrianglePainter extends BaseShapePainter {
  /// {@macro TrianglePainter}
  const TrianglePainter({
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
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..moveTo(size.width / 2, strokeAdjusterToFit) // Top center
      ..lineTo(
        strokeAdjusterToFit,
        size.height - strokeAdjusterToFit,
      ) // Bottom left
      ..lineTo(
        size.width - strokeAdjusterToFit,
        size.height - strokeAdjusterToFit,
      ) // Bottom right
      ..close();

    canvas.drawPath(path, paint);
  }
}
