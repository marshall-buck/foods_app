import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class CirclePainter extends BaseShapePainter {
  const CirclePainter({
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
      ..strokeWidth = strokeWidth;

    final offset = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - strokeAdjusterToFit;

    canvas.drawCircle(offset, radius, paint);
  }
}
