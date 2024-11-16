import 'dart:developer' as dev;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class CircularRangeSlider extends WatchingStatefulWidget {
  const CircularRangeSlider({required this.id, super.key, this.child});
  final Widget? child;
  final num id;

  @override
  State<StatefulWidget> createState() => _CircularRangeSliderState();
}

class _CircularRangeSliderState extends State<CircularRangeSlider> {
  double? _currentValue = 0;
  bool _isPanningHandle = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;

    final amount =
        watchPropertyValue((FoodDetailManager m) => m.amount)[widget.id];
    assert(amount != null, ' CircularRangeSlider amount is null');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: CircularRangeSliderTrackPainter(color: color),
              child: widget.child,
            ),
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                final radius = (context.size!.width / 2);
                final center = Offset(radius, radius);
                final handleAngle = -math.pi / 2 + 2 * math.pi * _currentValue!;
                final handleOffset = Offset(
                  center.dx + radius * math.cos(handleAngle),
                  center.dy + radius * math.sin(handleAngle),
                );

                // Calculate handle bounds for hit testing
                final handleBounds =
                    Rect.fromCircle(center: handleOffset, radius: radius);

                _isPanningHandle =
                    handleBounds.contains(details.localPosition); // Hit test

                dev.log('$_isPanningHandle', name: '_isPAnningHAndle');
              },
              onPanUpdate: (DragUpdateDetails details) {
                if (!_isPanningHandle) return;
                final radius = (context.size!.width / 2);
                final center = Offset(radius, radius);
                final direction = panHandler(details, radius);

                final mod = direction == RotationDirection.clockwise
                    ? (amount! + details.delta.dy).clamp(0.0, double.infinity)
                    : -(amount! + details.delta.dy).clamp(0.0, double.infinity);
                di.get<FoodDetailManager>().changeUnits(mod / 100);

                // Calculate the angle
                final angle = (math.atan2(
                          details.localPosition.dy - center.dy,
                          details.localPosition.dx - center.dx,
                        ) +
                        math.pi / 2) %
                    (2 * math.pi);

                // Convert angle to a value between 0.0 and 1.0
                _currentValue = angle / (2 * math.pi);

                // Update the amount based on the new value
                di.get<FoodDetailManager>().changeUnits(_currentValue!);

                setState(() {});
                // _currentValue = _currentValue! + details.delta.dy / 100;
              },
              onPanEnd: (DragEndDetails details) {
                _isPanningHandle = false;
                dev.log('$_isPanningHandle', name: '_isPAnningHAndle');
              },
              child: CustomPaint(
                painter: CircularRangeSliderHandlePainter(
                  delta: _currentValue!,
                  color: color,
                ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
