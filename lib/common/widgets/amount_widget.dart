import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/common/widgets/painters/heptagon.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    required this.amount,
    required this.unit,
    required this.index,
    this.iconSize,
    super.key,
  });

  final double amount;
  final String unit;
  final int index;
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
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

//TODO: Figure out a way to make the icons stick with current foods.
class _Icon extends StatelessWidget {
  const _Icon({
    required this.index,
    required this.color,
    // ignore: unused_element_parameter
    this.size,
    // ignore: unused_element_parameter
    this.fill,
    // ignore: unused_element_parameter
    this.stroke,
    // ignore: unused_element_parameter
    this.strokeWidth,
  });

  final int index;
  final Color color;
  final bool? fill;
  final bool? stroke;
  final double? strokeWidth;
  final double? size;

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
