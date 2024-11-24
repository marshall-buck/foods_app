// import 'dart:developer' as dev;
// import 'dart:math' as math;
// import 'package:flutter/material.dart';

// class CircularRangeSliderTrackPainter extends CustomPainter {
//   CircularRangeSliderTrackPainter({required this.color});

//   final Color color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     // Draw the stroke
//     final circularTrackPaint = Paint()
//       ..color = color
//       ..strokeWidth = 8
//       ..style = PaintingStyle.stroke;

//     // Outline
//     canvas.drawCircle(center, radius, circularTrackPaint);
//   }

//   @override
//   bool shouldRepaint(CircularRangeSliderTrackPainter oldDelegate) {
//     return false;
//   }
// }

// class CircularRangeSliderHandlePainter extends CustomPainter {
//   CircularRangeSliderHandlePainter({required this.delta, required this.color});
//   final double delta;
//   final Color color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width / 2) - 16;

//     final handlePaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     // Draw the handle
//     final handleAngle = -math.pi / 2 + 2 * math.pi * delta;
//     final handleOffset = Offset(
//       center.dx + radius * math.cos(handleAngle),
//       center.dy + radius * math.sin(handleAngle),
//     );

//     // handle
//     canvas.drawCircle(handleOffset, 16, handlePaint);
//     dev.log('$size', name: 'CircularRangeSliderHandlePainter : size');
//     dev.log('$radius', name: 'CircularRangeSliderHandlePainter : radius');
//     dev.log('$handleAngle', name: 'CircularRangeSliderPainter handleAngle');
//     // ignore: lines_longer_than_80_chars
//     dev.log('$handleOffset', name: 'CircularRangeSliderPainter handleOffsets');
//   }

//   @override
//   bool shouldRepaint(CircularRangeSliderHandlePainter oldDelegate) {
//     return oldDelegate.delta != delta;
//   }
// }
