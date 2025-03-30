import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A painter for drawing a square shape.
///
/// {@template SquarePainter}
/// - [color] specifies the color of the square.
/// - [fill] determines whether the square is filled. Defaults to `false`.
/// - [stroke] determines whether the square has a stroke. Defaults to `true`.
/// - [strokeWidth] specifies the width of the stroke. Defaults to `1.0`.
/// {@endtemplate}
class SquarePainter extends BaseShapePainter {
  /// {@macro SquarePainter}
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

    final rect = Rect.fromLTWH(
      strokeAdjusterToFit,
      strokeAdjusterToFit,
      size.width - 2 * strokeAdjusterToFit,
      size.height - 2 * strokeAdjusterToFit,
    );

    canvas.drawRect(rect, paint);
  }
}
