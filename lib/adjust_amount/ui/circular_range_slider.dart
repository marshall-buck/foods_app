import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// The direction of rotation for the circular range slider.
enum RotationDirection { clockwise, counterclockwise }

/// A circular range slider widget for adjusting values.
///
/// {@template CircularRangeSlider}
/// - [trackStroke] specifies the thickness of the track.
/// - [handleRadius] specifies the radius of the handle.
/// - [trackDiameter] specifies the diameter of the track.
/// - [trackColor] specifies the color of the track.
/// - [handleColor] specifies the color of the handle.
/// - [child] is an optional widget to display at the center of the slider.
/// - [onPanUpdate] is a callback triggered when the handle is dragged.
/// - [logging] enables debug logging when set to true.
/// {@endtemplate}
class CircularRangeSlider extends StatefulWidget {
  /// {@macro CircularRangeSlider}
  const CircularRangeSlider({
    required this.trackStroke,
    required this.handleRadius,
    required this.trackDiameter,
    required this.trackColor,
    required this.handleColor,
    this.child,
    this.onPanUpdate,
    this.logging = false,
    super.key,
  });

  /// The thickness of the track.
  final double trackStroke;

  /// The radius of the handle.
  final double handleRadius;

  /// The diameter of the track.
  final double trackDiameter;

  /// The color of the track.
  final Color trackColor;

  /// The color of the handle.
  final Color handleColor;

  /// An optional widget to display at the center of the slider.
  final Widget? child;

  /// A callback triggered when the handle is dragged.
  ///
  /// The callback provides the [RotationDirection] and [DragUpdateDetails].
  final void Function(RotationDirection, DragUpdateDetails)? onPanUpdate;

  /// Enables debug logging when set to true.
  final bool logging;

  @override
  State<CircularRangeSlider> createState() => _CircularRangeSliderState();
}

class _CircularRangeSliderState extends State<CircularRangeSlider> {
  double _angle = math.pi * 1.5;
  bool _shouldPan = false;

  /// Checks if a point is inside the handle.
  ///
  /// - [circleCenter] is the center of the circle.
  /// - [radius] is the radius of the handle.
  /// - [point] is the point to check.
  bool _isPointInsideHandle(Offset circleCenter, double radius, Offset point) {
    final distance = math.sqrt(
      math.pow(point.dx - circleCenter.dx, 2) + math.pow(point.dy - circleCenter.dy, 2),
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

          final center = Offset(widget.trackDiameter / 2, widget.trackDiameter / 2);

          final dx = details.localPosition.dx - center.dx;
          final dy = details.localPosition.dy - center.dy;
          final newAngle = math.atan2(dy, dx);

          final direction = _panHandler(details, widget.trackDiameter / 2);

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

  /// Logs debug information for the `onPanStart` event.
  void _logOnPanStart(
    DragStartDetails details,
    Offset center,
    double radius,
    Offset handleOffset,
  ) {
    dev.log(
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

  /// Logs debug information for the `onPanUpdate` event.
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

/// A custom painter for the circular range slider track.
///
/// {@template CircularRangeSlider}
/// {@endtemplate}
class _CircularRangeSliderTrackPainter extends CustomPainter {
  const _CircularRangeSliderTrackPainter({
    required this.color,
    required this.trackStroke,
    required this.logging,
  });

  /// The color of the track.
  final Color color;

  /// The thickness of the track.
  final double trackStroke;

  /// Enables debug logging when set to true.
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

/// A custom painter for the circular range slider handle.
///
/// {@template CircularRangeSlider}
/// {@endtemplate}
class _CircularRangeSliderHandlePainter extends CustomPainter {
  const _CircularRangeSliderHandlePainter({
    required this.angle,
    required this.color,
    required this.handleRadius,
    required this.logging,
  });

  /// The angle of the handle.
  final double angle;

  /// The color of the handle.
  final Color color;

  /// The radius of the handle.
  final double handleRadius;

  /// Enables debug logging when set to true.
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

/// Determines the rotation direction based on pan gestures.
///
/// - [d] is the drag update details.
/// - [radius] is the radius of the circular slider.
RotationDirection _panHandler(DragUpdateDetails d, double radius) {
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
  final verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp) ? yChange : yChange * -1;

  final horizontalRotation = (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

  // Total computed change
  final rotationalChange = verticalRotation + horizontalRotation;

  final movingClockwise = rotationalChange > 0;

  if (movingClockwise == true) {
    return RotationDirection.clockwise;
  }
  return RotationDirection.counterclockwise;
}
