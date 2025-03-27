import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class TrianglePainter extends BaseShapePainter {
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
