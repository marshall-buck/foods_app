import 'package:flutter/material.dart';

/// A base class for shape painters that provides common properties and methods.
abstract class BaseShapePainter extends CustomPainter {
  const BaseShapePainter({
    required this.color,
    bool? fill,
    bool? stroke,
    double? strokeWidth,
  })  : fill = fill ?? false,
        stroke = stroke ?? true,
        strokeWidth = strokeWidth ?? 1.0,
        assert((fill ?? false) || (stroke ?? true), 'Either fill or stroke must be true.');

  final bool fill;
  final bool stroke;
  final Color color;
  final double strokeWidth;

  /// Adjusts the stroke to simulate an inside stroke effect.
  double get strokeAdjusterToFit => strokeWidth / 2;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
