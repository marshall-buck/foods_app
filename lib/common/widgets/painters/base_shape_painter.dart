import 'package:flutter/material.dart';

/// A base class for shape painters that provides common properties and methods.
///
/// {@template BaseShapePainter}
/// - [color] specifies the color of the shape.
/// - [fill] determines whether the shape is filled. Defaults to `false`.
/// - [stroke] determines whether the shape has a stroke. Defaults to `true`.
/// - [strokeWidth] specifies the width of the stroke. Defaults to `1.0`.
/// {@endtemplate}
abstract class BaseShapePainter extends CustomPainter {
  /// {@macro BaseShapePainter}
  const BaseShapePainter({
    required this.color,
    bool? fill,
    bool? stroke,
    double? strokeWidth,
  })  : fill = fill ?? false,
        stroke = stroke ?? true,
        strokeWidth = strokeWidth ?? 1.0,
        assert((fill ?? false) || (stroke ?? true), 'Either fill or stroke must be true.');

  /// Determines whether the shape is filled.
  final bool fill;

  /// Determines whether the shape has a stroke.
  final bool stroke;

  /// The color of the shape.
  final Color color;

  /// The width of the stroke.
  final double strokeWidth;

  /// Adjusts the stroke to simulate an inside stroke effect.
  ///
  /// This is useful for ensuring the stroke fits within the bounds of the shape.
  double get strokeAdjusterToFit => strokeWidth / 2;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
