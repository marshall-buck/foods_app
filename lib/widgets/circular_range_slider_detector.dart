import 'package:flutter/material.dart';
import 'package:foods_app/widgets/widgets.dart';

class CircularRangeSliderDetector extends StatefulWidget {
  const CircularRangeSliderDetector({required this.isAdjustable, super.key});

  final bool isAdjustable;

  @override
  State<CircularRangeSliderDetector> createState() =>
      _CircularRangeSliderDetectorState();
}

class _CircularRangeSliderDetectorState
    extends State<CircularRangeSliderDetector> {
  // TODO: lift value into state class
  double _value = 0; // Initial value, representing 50%

  @override
  Widget build(BuildContext context) {
    return widget.isAdjustable
        ? GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _value = (_value + details.delta.dy / 100)
                    .clamp(0.0, double.infinity);
                // dev.log('$_value', name: 'AmountIndicator: _value: ');
              });
            },
            child: CircularRangeSlider(value: _value),
          )
        : GestureDetector(
            onLongPress: () {
              Navigator.of(context)
                  .push(CircularRangeSliderPopUp<void>(context: context));
            },
            child: CircularRangeSlider(value: _value),
          );
  }
}

class CircularRangeSlider extends StatelessWidget {
  const CircularRangeSlider({
    super.key,
    required double value,
  }) : _value = value;

  final double _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: CircularRangeSliderPainter(_value),
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
