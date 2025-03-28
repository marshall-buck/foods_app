import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class SquarePainter extends BaseShapePainter {
  const SquarePainter({
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
    ;

    final rect = Rect.fromLTWH(
      strokeAdjusterToFit,
      strokeAdjusterToFit,
      size.width - 2 * strokeAdjusterToFit,
      size.height - 2 * strokeAdjusterToFit,
    );

    canvas.drawRect(rect, paint);
  }
}
