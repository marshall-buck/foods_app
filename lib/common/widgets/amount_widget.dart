// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/common/widgets/painters/heptagon.dart';

/// {@template amount_widget}
/// A widget that displays an amount with its unit and an associated icon.
///
/// The icon is determined by an [index] and can be customized in [iconSize].
/// {@endtemplate}
class AmountWidget extends StatelessWidget {
  /// {@macro amount_widget}
  const AmountWidget({
    required this.amount,
    required this.unit,
    required this.index,
    this.iconSize,
    super.key,
  });

  /// The numerical amount.
  final double amount;

  /// The unit of the amount.
  final String unit;

  /// The index used to determine the icon shape.
  final int index;

  /// The size of the icon. If null, a default size is used.
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Icon(
          index: index,
          color: Theme.of(context).colorScheme.primary,
          size: iconSize,
        ),
        Text(
          '${amount.convertAmountToString()}  $unit',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

/// {@template icon_widget}
/// A private widget that renders a custom-shaped icon.
///
/// The shape of the icon is determined by the [index] and can be one of
/// several predefined shapes in [getPainter] .
/// {@endtemplate}
class _Icon extends StatelessWidget {
  /// {@macro icon_widget}
  const _Icon({
    required this.index,
    required this.color,
    this.size,
    this.fill,
    this.stroke,
    this.strokeWidth,
  });

  /// The index used to determine the shape of the icon.
  final int index;

  /// The color of the icon.
  final Color color;

  /// Whether the icon should be filled. Defaults to null.
  final bool? fill;

  /// Whether the icon should have a stroke. Defaults to null.
  final bool? stroke;

  /// The width of the stroke, if applicable. Defaults to null.
  final double? strokeWidth;

  /// The size of the icon. If null, a default size is used.
  final double? size;

  /// Returns the appropriate [CustomPainter] based on the [index].
  ///
  /// The painter determines the shape of the icon.
  CustomPainter getPainter() {
    final painters = [
      SquarePainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
      TrianglePainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
      CirclePainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
      PentagonPainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
      HexagonPainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
      HeptagonPainter(
        color: color,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
      ),
    ];

    final painterIndex = index % painters.length;
    return painters[painterIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size ?? MagicNumbers.defaultAmountWidgetIconSize,
      child: CustomPaint(
        painter: getPainter(),
      ),
    );
  }
}
