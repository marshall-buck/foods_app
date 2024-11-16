// import 'dart:developer' as dev;

import 'package:flutter/gestures.dart';

enum RotationDirection { clockwise, counterclockwise }

RotationDirection panHandler(DragUpdateDetails d, double radius) {
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
