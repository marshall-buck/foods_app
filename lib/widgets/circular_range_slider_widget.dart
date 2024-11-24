// import 'dart:developer' as dev;
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/features/features.dart';

// import 'package:foods_app/widgets/widgets.dart';
// import 'package:watch_it/watch_it.dart';

// class CircularRangeSlider extends WatchingStatefulWidget {
//   const CircularRangeSlider({required this.id, super.key, this.child});
//   final Widget? child;
//   final num id;

//   @override
//   State<StatefulWidget> createState() => _CircularRangeSliderState();
// }

// class _CircularRangeSliderState extends State<CircularRangeSlider> {
//   double _currentValue = 0;
//   bool _isPanningHandle = false;

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme.onSurface;

//     final amount =
//         watchPropertyValue((FoodDetailManager m) => m.amountsActual)[widget.id];
//     assert(amount != null, ' CircularRangeSlider amount is null');

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: Stack(
//           children: [
//             CustomPaint(
//               painter: CircularRangeSliderTrackPainter(color: color),
//               child: widget.child,
//             ),
//             GestureDetector(
//               onPanDown: (DragDownDetails details) {
//                 final radius = (context.size!.width / 2) - 32;
//                 final center = Offset(radius, radius);
//                 final handleAngle = -math.pi / 2 + 2 * math.pi * _currentValue;
//                 final handleOffset = Offset(
//                   center.dx + radius * math.cos(handleAngle),
//                   center.dy + radius * math.sin(handleAngle),
//                 );

//                 // Calculate handle bounds for hit testing
//                 final handleBounds =
//                     Rect.fromCircle(center: handleOffset, radius: radius);

//                 _isPanningHandle =
//                     handleBounds.contains(details.localPosition); // Hit test

//                 dev.log(
//                   '${context.size}',
//                   name: '_CircularRangeSliderState - onPanDown() context.size',
//                 );
//                 dev.log(
//                   '$center',
//                   name: '_CircularRangeSliderState - onPanDown() center',
//                 );
//                 dev.log(
//                   '$radius',
//                   name: '_CircularRangeSliderState - onPanDown() radius',
//                 );
//                 dev.log(
//                   '$handleAngle',
//                   name: '_CircularRangeSliderState - onPanDown() handleAngle',
//                 );
//                 dev.log(
//                   '$handleOffset',
//                   name: '_CircularRangeSliderState - onPanDown() handleOffset',
//                 );
//                 dev.log(
//                   '$handleBounds',
//                   name: '_CircularRangeSliderState - onPanDown() handleBounds',
//                 );
//                 dev.log(
//                   '$_isPanningHandle',
//                   name: 'onPanDown: _isPanningHandle',
//                 );
//               },
//               onPanStart: (DragStartDetails details) {
//                 final radius = (context.size!.width / 2) - 32;
//                 final center = Offset(radius, radius);
//                 final handleAngle = -math.pi / 2 + 2 * math.pi * _currentValue;
//                 final handleOffset = Offset(
//                   center.dx + radius * math.cos(handleAngle),
//                   center.dy + radius * math.sin(handleAngle),
//                 );

//                 // Calculate handle bounds for hit testing
//                 final handleBounds =
//                     Rect.fromCircle(center: handleOffset, radius: radius);

//                 _isPanningHandle =
//                     handleBounds.contains(details.localPosition); // Hit test

//                 dev.log(
//                   '$_isPanningHandle',
//                   name: 'onPanStart: _isPanningHandle',
//                 );
//                 dev.log('${context.size}', name: 'onPanStart');
//                 dev.log('$radius', name: 'onPanStart  - radius');
//                 dev.log('$handleBounds', name: 'onPanStart  - handleBounds');
//               },
//               onPanUpdate: (DragUpdateDetails details) {
//                 if (!_isPanningHandle) return;
//                 final radius = (context.size!.width / 2) - 16;
//                 final center = Offset(radius, radius);
//                 final direction = panHandler(details, radius);

//                 final mod = direction == RotationDirection.clockwise
//                     ? (amount! + details.delta.dy).clamp(0.0, double.infinity)
//                     : -(amount! + details.delta.dy).clamp(0.0, double.infinity);
//                 di.get<FoodDetailManager>().changeUnits(mod / 100);

//                 // Calculate the angle
//                 final handleAngle = (math.atan2(
//                           details.localPosition.dy - center.dy,
//                           details.localPosition.dx - center.dx,
//                         ) +
//                         math.pi / 2) %
//                     (2 * math.pi);

//                 // Convert angle to a value between 0.0 and 1.0
//                 _currentValue = handleAngle / (2 * math.pi);

//                 // Update the amount based on the new value
//                 di.get<FoodDetailManager>().changeUnits(_currentValue);

//                 setState(() {});
//                 dev.log(
//                   '${context.size}',
//                   name:
//                       '_CircularRangeSliderState - onPanUpdate() context.size',
//                 );
//                 dev.log(
//                   '$center',
//                   name: '_CircularRangeSliderState - onPanUpdate() center',
//                 );
//                 dev.log(
//                   '$radius',
//                   name: '_CircularRangeSliderState - onPanUpdate() radius',
//                 );
//                 dev.log(
//                   '$handleAngle',
//                   name: '_CircularRangeSliderState - onPanUpdate() handleAngle',
//                 );
//                 // dev.log(
//                 //   '$handleOffset',
//                 //   name: '_CircularRangeSliderState - onPanUpdate() handleOffset',
//                 // );
//                 // dev.log(
//                 //   '$handleBounds',
//                 //   name: '_CircularRangeSliderState - onPanUpdate() handleBounds',
//                 // );
//                 dev.log(
//                   '$_isPanningHandle',
//                   name: 'onPanUpdate: _isPanningHandle',
//                 );
//                 // _currentValue = _currentValue! + details.delta.dy / 100;
//               },
//               onPanEnd: (DragEndDetails details) {
//                 _isPanningHandle = false;
//                 dev.log('$_isPanningHandle', name: '_isPAnningHAndle');
//               },
//               child: CustomPaint(
//                 painter: CircularRangeSliderHandlePainter(
//                   delta: _currentValue,
//                   color: color,
//                 ),
//                 child: widget.child,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
