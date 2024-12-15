import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

enum RotationDirection { clockwise, counterclockwise }

// TODO:use speed indicator icons to adjust speed.
class CircularRangeSlider extends StatefulWidget {
  const CircularRangeSlider({
    required this.trackStroke,
    required this.handleRadius,
    required this.trackDiameter,
    required this.trackColor,
    required this.handleColor,
    // this.id,
    this.child,
    this.onPanUpdate,
    this.logging = false,
    super.key,
  });

  final double trackStroke;
  final double handleRadius;
  final double trackDiameter;
  final Color trackColor;
  final Color handleColor;
  final Widget? child;
  // final int? id;
  final void Function(RotationDirection, DragUpdateDetails)? onPanUpdate;
  final bool logging;

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
          if (widget.logging) {
            _logOnPanStart(details, center, radius, handleOffset);
          }
        },
        onPanUpdate: (DragUpdateDetails details) {
          if (!_shouldPan) return;

          final center =
              Offset(widget.trackDiameter / 2, widget.trackDiameter / 2);

          final dx = details.localPosition.dx - center.dx;
          final dy = details.localPosition.dy - center.dy;
          final newAngle = math.atan2(dy, dx);

          final direction = panHandler(details, widget.trackDiameter / 2);
          // if (widget.onPanUpdate != null) {
          //   widget.onPanUpdate!(direction, details);
          // }
          widget.onPanUpdate?.call(direction, details);
          if (widget.logging) {
            _logOnPanUpdate(details, dx, dy, newAngle);
          }

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
              painter: _CircularRangeSliderTrackPainter(
                color: widget.trackColor,
                trackStroke: widget.trackStroke,
                logging: widget.logging,
              ),
            ),
            CustomPaint(
              size: Size.square(widget.trackDiameter),
              painter: _CircularRangeSliderHandlePainter(
                angle: _angle,
                color: widget.handleColor,
                handleRadius: widget.handleRadius,
                logging: widget.logging,
              ),
            ),
            if (widget.child != null) widget.child!,
          ],
        ),
      ),
    );
  }

  /// helper logging method for onPanStart.

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
  }
}

class _CircularRangeSliderTrackPainter extends CustomPainter {
  const _CircularRangeSliderTrackPainter({
    required this.color,
    required this.trackStroke,
    required this.logging,
  });

  final Color color;
  final double trackStroke;
  final bool logging;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final circularTrackPaint = Paint()
      ..color = color
      ..strokeWidth = trackStroke
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circularTrackPaint);

    if (logging) {
      dev.log('$size', name: 'CircularRangeSliderTrackPainter: size');
      dev.log('$radius', name: 'CircularRangeSliderTrackPainter: radius');
      dev.log('$center', name: 'CircularRangeSliderTrackPainter: center');
      dev.log(
        '$trackStroke',
        name: 'CircularRangeSliderTrackPainter: trackStroke',
      );
    }
  }

  @override
  bool shouldRepaint(_CircularRangeSliderTrackPainter oldDelegate) {
    return false;
  }
}

class _CircularRangeSliderHandlePainter extends CustomPainter {
  const _CircularRangeSliderHandlePainter({
    required this.angle,
    required this.color,
    required this.handleRadius,
    required this.logging,
  });
  final double angle;
  final Color color;
  final double handleRadius;
  final bool logging;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final handlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final offset = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // handle
    canvas.drawCircle(offset, handleRadius, handlePaint);
    if (logging) {
      dev.log('$size', name: 'CircularRangeSliderTrackPainter: size');
      dev.log('$radius', name: 'CircularRangeSliderTrackPainter: radius');
      dev.log('$center', name: 'CircularRangeSliderTrackPainter: center');
      dev.log('$offset', name: 'CircularRangeSliderTrackPainter: offset');
    }
  }

  @override
  bool shouldRepaint(_CircularRangeSliderHandlePainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}

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
