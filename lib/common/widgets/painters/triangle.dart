import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    this.fill = false,
    this.stroke = true,
    this.color = Colors.black,
    this.strokeWidth = MagicNumbers.defaultIconStroke,
  }) : assert(fill || stroke, 'Either fill or stroke must be true.');
  final bool fill;
  final bool stroke;
  final Color color;
  final double strokeWidth;

  double get _strokeAdjusterToFit => MagicNumbers.defaultIconStroke / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..moveTo(size.width / 2, _strokeAdjusterToFit) // Top center
      ..lineTo(
        0 + _strokeAdjusterToFit,
        size.height - _strokeAdjusterToFit,
      ) // Bottom left
      ..lineTo(
        size.width - _strokeAdjusterToFit,
        size.height - _strokeAdjusterToFit,
      ) // Bottom right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
