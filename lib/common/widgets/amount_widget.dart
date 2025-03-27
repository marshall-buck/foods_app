import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A widget that displays an amount with a unit, adjusted by a modifier from the AdjustAmountBloc.
/// The amount passed is the original food/nutrient amount, and is multiplied by the original amount.
class AmountWidget extends StatelessWidget {
  const AmountWidget({
    // required this.textColor,
    required this.amount,
    required this.unit,
    required this.index,
    super.key,
  });
  // final Color textColor;
  final double amount;
  final String unit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Icon(index: index, color: Theme.of(context).colorScheme.onSecondaryContainer),
        Text(
          '${amount.convertAmountToString()}  $unit',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
          maxLines: 1, //Limit the number of lines
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.index,
    required this.color,
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
    ];

    final painterIndex = index % painters.length;
    return painters[painterIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 48,
      child: CustomPaint(
        painter: getPainter(),
      ),
    );
  }
}

// ShapeCornersPainter(
//               numberOfCorners: index + 1,
//               color: Theme.of(context).colorScheme.onSecondaryContainer,
//               radius: 8,
//             ),

// class _ShapePainterSelector {
//   const _ShapePainterSelector({
//     required this.index,
//     required this.color,
//     // ignore: unused_element_parameter
//     this.fill,
//     // ignore: unused_element_parameter
//     this.stroke,
//     // ignore: unused_element_parameter
//     this.strokeWidth,
//   });
//   final int index;
//   final Color color;
//   final bool? fill;
//   final bool? stroke;
//   final double? strokeWidth;

//   CustomPainter getPainter() {
//     final painters = [
//       CirclePainter(
//         color: color,
//         fill: fill,
//         stroke: stroke,
//         strokeWidth: strokeWidth,
//       ),
//       SquarePainter(
//         color: color,
//         fill: fill,
//         stroke: stroke,
//         strokeWidth: strokeWidth,
//       ),
//       TrianglePainter(
//         color: color,
//         fill: fill,
//         stroke: stroke,
//         strokeWidth: strokeWidth,
//       ),
//       PentagonPainter(
//         color: color,
//         fill: fill,
//         stroke: stroke,
//         strokeWidth: strokeWidth,
//       ),
//       HexagonPainter(
//         color: color,
//         fill: fill,
//         stroke: stroke,
//         strokeWidth: strokeWidth,
//       ),
//     ];

//     final painterIndex = index % painters.length;
//     return painters[painterIndex];
//   }
// }
