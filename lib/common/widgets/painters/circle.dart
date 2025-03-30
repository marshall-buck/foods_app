import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A painter for drawing a circle shape.
///
/// {@template CirclePainter}
/// - [color] specifies the color of the circle.
/// - [fill] determines whether the circle is filled. Defaults to `false`.
/// - [stroke] determines whether the circle has a stroke. Defaults to `true`.
/// - [strokeWidth] specifies the width of the stroke. Defaults to `1.0`.
/// {@endtemplate}
class CirclePainter extends BaseShapePainter {
  /// {@macro CirclePainter}
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
