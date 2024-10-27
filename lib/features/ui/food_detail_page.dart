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
    print('tileSize.dimension: ${tileSize.dimension}');
    print('tileSize.spacing: ${tileSize.spacing}');

    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: const [
              Icon(Icons.save_as),
              Icon(Icons.edit),
              Icon(Icons.refresh),
            ],
            pinned: true,
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.all(MagicSpacing.sp_4),
                  child: FoodDescriptionCard(tileSize: tileSize),
                ),
                preferredSize: Size(double.infinity, tileSize.dimension)),
          ),
          SliverPadding(
            padding: EdgeInsets.all(tileSize.spacing),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: tileSize.dimension,
                crossAxisSpacing: tileSize.spacing,
                mainAxisSpacing: tileSize.spacing,
                // mainAxisExtent: tileSize.dimension / 2,
              ),
              itemCount: food?.nutrientList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0.25,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Text(
                    food!.nutrientList[index].name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.tileSize,
    super.key,
  });

  final MagicTileDimension tileSize;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MagicDimensions.maxSearchBarWidth),
      child: Container(
        color: Colors.amber,
        // width: double.infinity,
        height: tileSize.dimension - MagicSpacing.sp_6,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AmountIndicator(),
            ),
            Expanded(
              child: Container(
                color: Colors.cyan,
                child: Column(
                  children: [Text('data datadatadatadatadatadatadatadatadata')],
                ),
                // height: tileSize.dimension,
                // width: double.infinity,
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
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _value =
                (_value + details.delta.dy / 100).clamp(0.0, double.infinity);
            dev.log('$_value', name: 'AmountIndicator: _value: ');
          });
        },
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

    // Draw the background circle
    final backgroundPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the stroke
    final strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, strokePaint);

    // Draw the arc representing the value
    final arcPaint = Paint()
      ..color = Colors.black // You can customize the arc color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start angle at the top
      2 * math.pi * value, // Sweep angle based on value
      false,
      arcPaint,
    );

    // Draw the handle
    final handleAngle = -math.pi / 2 + 2 * math.pi * value;
    final handleOffset = Offset(
      center.dx + radius * math.cos(handleAngle),
      center.dy + radius * math.sin(handleAngle),
    );
    canvas.drawCircle(handleOffset, 4, strokePaint);
  }

  @override
  bool shouldRepaint(_CircularRangeSliderPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}


// class AmountIndicator extends StatelessWidget {
//   const AmountIndicator({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(MagicSpacing.sp_2),
//         child: Container(
//             // height: tileSize.dimension,
//             // width: tileSize.dimension - MagicSpacing.sp_6,
//             decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.red,
//         )),
//       ),
//     );
//   }
// }

// class FoodDetailDescription extends StatelessWidget {
//   const FoodDetailDescription({required this.food, super.key});
//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;

//     final tileSize = MagicTileSize.tileSize(windowSize: width);
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Theme.of(context).colorScheme.primary,
//           width: 0.25,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         color: Theme.of(context).colorScheme.surfaceContainer,
//       ),
//       width: double.infinity,
//       height: MagicTileSize.sm,
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               '100 g',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               food.description,
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
