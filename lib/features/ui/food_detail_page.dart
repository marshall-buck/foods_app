import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingStatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    ///(dimension of a side, spacing)
    final tileSize = MagicTileDimension.tileSize(windowSize: width);

    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(MagicSpacing.sp_4),
              child: FoodDescriptionCard(
                tileSize: tileSize,
                food: food!,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // SliverAppBar(

                  SliverPadding(
                    padding: EdgeInsets.all(tileSize.spacing),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: tileSize.dimension,
                        crossAxisSpacing: tileSize.spacing,
                        mainAxisSpacing: tileSize.spacing,
                        // mainAxisExtent: tileSize.dimension / 2,
                      ),
                      itemCount: food.nutrientList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 0.25,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          child: Text(
                            food.nutrientList[index].name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.tileSize,
    required this.food,
    super.key,
  });

  final MagicTileDimension tileSize;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxWidth: MagicDimensions.maxSearchBarWidth),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(MagicSpacing.sp_4)),

        // width: double.infinity,
        height: tileSize.dimension - MagicSpacing.sp_6,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: AmountIndicator(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(MagicSpacing.sp_2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.save_as),
                        Icon(Icons.edit),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AmountIndicator extends StatefulWidget {
  const AmountIndicator({super.key});

  @override
  State<AmountIndicator> createState() => _AmountIndicatorState();
}

class _AmountIndicatorState extends State<AmountIndicator> {
  double _value = 0.5; // Initial value, representing 50%

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _panHandler(details, context.size!.width);
          _value =
              (_value + details.delta.dy / 100).clamp(0.0, double.infinity);
          dev.log('$_value', name: 'AmountIndicator: _value: ');
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: _CircularRangeSliderPainter(_value),
          child: Center(
            child: Text(
              '${(_value * 100).toInt()}%', // Display value as percentage
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularRangeSliderPainter extends CustomPainter {
  _CircularRangeSliderPainter(this.value);
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the stroke
    final strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, strokePaint);

    // Draw the handle
    final handleAngle = -math.pi / 2 + 2 * math.pi * value;
    final handleOffset = Offset(
      center.dx + radius * math.cos(handleAngle),
      center.dy + radius * math.sin(handleAngle),
    );

    // handle
    canvas.drawCircle(handleOffset, 4, strokePaint);
  }

  @override
  bool shouldRepaint(_CircularRangeSliderPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

void _panHandler(DragUpdateDetails d, double radius) {
  /// Pan location on the wheel
  final onTop = d.localPosition.dy <= radius;
  final onLeftSide = d.localPosition.dx <= radius;
  final onRightSide = !onLeftSide;
  final onBottom = !onTop;

  /// Pan movements
  final panUp = d.delta.dy <= 0.0;
  final panLeft = d.delta.dx <= 0.0;
  final panRight = !panLeft;
  final panDown = !panUp;

  /// Absoulte change on axis
  final yChange = d.delta.dy.abs();
  final xChange = d.delta.dx.abs();

  /// Directional change on wheel
  final verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
      ? yChange
      : yChange * -1;

  final horizontalRotation =
      (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

  // Total computed change
  final rotationalChange = verticalRotation + horizontalRotation;

  final movingClockwise = rotationalChange > 0;
  final movingCounterClockwise = rotationalChange < 0;

  dev.log('onTop: $onTop', name: '_panHandler');
  dev.log('onLeftSide: $onLeftSide', name: '_panHandler');
  dev.log('onRightSide: $onRightSide', name: '_panHandler');
  dev.log('onBottom: $onBottom', name: '_panHandler');
  dev.log('panUp: $panUp', name: '_panHandler');
  dev.log('panLeft: $panLeft', name: '_panHandler');
  dev.log('panRight: $panRight', name: '_panHandler');
  dev.log('panDown: $panDown', name: '_panHandler');
  dev.log('yChange: $yChange', name: '_panHandler');
  dev.log('xChange: $xChange', name: '_panHandler');
  dev.log('verticalRotation: $verticalRotation', name: '_panHandler');
  dev.log('horizontalRotation: $horizontalRotation', name: '_panHandler');
  dev.log('rotationalChange: $rotationalChange', name: '_panHandler');
  dev.log('movingClockwise: $movingClockwise', name: '_panHandler');
  dev.log('movingCounterClockwise: $movingCounterClockwise',
      name: '_panHandler');
}
