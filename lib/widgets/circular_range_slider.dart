import 'dart:developer' as dev;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:watch_it/watch_it.dart';

// TODO:use speed indicator icons to adjust speed.
class CircularRangeSlider extends StatefulWidget {
  const CircularRangeSlider({
    required this.trackStroke,
    required this.handleRadius,
    required this.trackDiameter,
    required this.trackColor,
    required this.handleColor,
    required this.id,
    required this.child,
    super.key,
  });

  final double trackStroke;
  final double handleRadius;
  final double trackDiameter;
  final Color trackColor;
  final Color handleColor;
  final Widget child;
  final int id;

  @override
  State<CircularRangeSlider> createState() => _CircularRangeSliderState();
}

class _CircularRangeSliderState extends State<CircularRangeSlider> {
  double _angle = math.pi * 1.5;
  bool _shouldPan = false;

  bool _isPointInsideHandle(Offset circleCenter, double radius, Offset point) {
    final distance = math.sqrt(
      math.pow(point.dx - circleCenter.dx, 2) +
          math.pow(point.dy - circleCenter.dy, 2),
    );
    return distance <= radius;
  }

  @override
  Widget build(BuildContext context) {
    final wrapperSize = widget.trackDiameter + (widget.handleRadius * 2);

    return SizedBox.square(
      dimension: wrapperSize,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (DragStartDetails details) {
          // Center of the actual GesturedDetector
          final center = Offset(wrapperSize / 2, wrapperSize / 2);

          // Radius of the canvas.
          final radius = (wrapperSize / 2) - widget.handleRadius;

          final handleOffset = Offset(
            center.dx + radius * math.cos(_angle),
            center.dy + radius * math.sin(_angle),
          );

          if (_isPointInsideHandle(
            handleOffset,
            widget.handleRadius,
            details.localPosition,
          )) {
            setState(() {
              _shouldPan = true;
            });
          }
          // _logOnPanStart(details, center, radius, handleOffset);
        },
        onPanUpdate: (DragUpdateDetails details) {
          if (!_shouldPan) return;

          final center =
              Offset(widget.trackDiameter / 2, widget.trackDiameter / 2);

          final dx = details.localPosition.dx - center.dx;
          final dy = details.localPosition.dy - center.dy;
          final newAngle = math.atan2(dy, dx);

          final direction = panHandler(details, widget.trackDiameter / 2);

          di.get<FoodDetailManager>().changeUnits(direction);

          setState(() {
            _angle = newAngle;
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            _shouldPan = false;
          });
        },
        child: Stack(
          //
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.square(widget.trackDiameter),
              painter: CircularRangeSliderTrackPainter(
                color: widget.trackColor,
                trackStroke: widget.trackStroke,
              ),
            ),
            CustomPaint(
              size: Size.square(widget.trackDiameter),
              painter: CircularRangeSliderHandlePainter(
                angle: _angle,
                color: widget.handleColor,
                handleRadius: widget.handleRadius,
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }

  // helper logging method for onPanStart.
  // ignore: unused_element
  void _logOnPanStart(
    DragStartDetails details,
    Offset center,
    double radius,
    Offset handleOffset,
  ) {
    dev.log(
      // ignore: lines_longer_than_80_chars
      '${_isPointInsideHandle(handleOffset, widget.handleRadius, details.localPosition)}',
      name: 'onPanStart: isPointInsideCircle',
    );
    dev.log('$handleOffset', name: 'onPanStart : handleOffset');
    dev.log(
      '${details.localPosition}',
      name: 'onPanStart: details.localPosition',
    );
    dev.log('$_shouldPan', name: 'onPanStart : _shouldPan');
    dev.log('$_angle', name: 'onPanStart : _angle');
    dev.log('$radius', name: 'onPanStart: radius');
    dev.log('$center', name: 'onPanStart: center');
  }

  // helper logging method for onPanUpdate.
  // ignore: unused_element
  void _logOnPanUpdate(
    DragUpdateDetails details,
    double dx,
    double dy,
    double newAngle,
  ) {
    dev.log(
      '${details.localPosition}',
      name: 'onPanUpdate: details.localPosition',
    );
    dev.log('$dx', name: 'onPanUpdate: dx');
    dev.log('$dy', name: 'onPanUpdate: dy');
    dev.log('$newAngle', name: 'onPanUpdate: newAngle');
    // dev.log('$constrainedAngle', name: 'onPanUpdate: constrainedAngle');
  }
}

class CircularRangeSliderTrackPainter extends CustomPainter {
  const CircularRangeSliderTrackPainter({
    required this.color,
    required this.trackStroke,
  });

  final Color color;
  final double trackStroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final circularTrackPaint = Paint()
      ..color = color
      ..strokeWidth = trackStroke
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circularTrackPaint);

    // dev.log('$sie', name: 'CirularRangeSliderTrackPainter: size');
    // dev.log('$radius', name: 'CircularRangeSliderTrackPainter: radius');
    // dev.log('$center', name: 'CircularRangeSliderTrackPainter: center');
  }

  @override
  bool shouldRepaint(CircularRangeSliderTrackPainter oldDelegate) {
    return false;
  }
}

class CircularRangeSliderHandlePainter extends CustomPainter {
  const CircularRangeSliderHandlePainter({
    required this.angle,
    required this.color,
    required this.handleRadius,
  });
  final double angle;
  final Color color;
  final double handleRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final handlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final handleOffset = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // handle
    canvas.drawCircle(handleOffset, handleRadius, handlePaint);
  }

  @override
  bool shouldRepaint(CircularRangeSliderHandlePainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
  // dev.log('$size', name: 'CircularRangeSliderHandlePainter: size');
  // dev.log('$radius', name: 'CircularRangeSliderHandlePainter: radius');
  // dev.log('$center', name: 'CircularRangeSliderHandlePainter: center');

  // dev.log('$handleOffset',
  //     name: 'CircularRangeSliderHandlePainter handleOffsets');
}

enum RotationDirection { clockwise, counterclockwise }

RotationDirection panHandler(DragUpdateDetails d, double radius) {
  /// Location of the pointer
  final onTop = d.localPosition.dy <= radius;
  final onLeftSide = d.localPosition.dx <= radius;
  final onRightSide = !onLeftSide;
  final onBottom = !onTop;

  /// Pan movements of pointer
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
  // final movingCounterClockwise = rotationalChange < 0;

  // dev.log('onTop: $onTop', name: '_panHandler');
  // dev.log('onLeftSide: $onLeftSide', name: '_panHandler');
  // dev.log('onRightSide: $onRightSide', name: '_panHandler');
  // dev.log('onBottom: $onBottom', name: '_panHandler');
  // dev.log('panUp: $panUp', name: '_panHandler');
  // dev.log('panLeft: $panLeft', name: '_panHandler');
  // dev.log('panRight: $panRight', name: '_panHandler');
  // dev.log('panDown: $panDown', name: '_panHandler');
  // dev.log('yChange: $yChange', name: '_panHandler');
  // dev.log('xChange: $xChange', name: '_panHandler');
  // dev.log('verticalRotation: $verticalRotation', name: '_panHandler');
  // dev.log('horizontalRotation: $horizontalRotation', name: '_panHandler');
  // dev.log('rotationalChange: $rotationalChange', name: '_panHandler');
  // dev.log('movingClockwise: $movingClockwise', name: '_panHandler');
  // dev.log(
  //   'movingCounterClockwise: $movingCounterClockwise',
  //   name: '_panHandler',
  // );

  if (movingClockwise == true) {
    return RotationDirection.clockwise;
  }
  return RotationDirection.counterclockwise;
}
