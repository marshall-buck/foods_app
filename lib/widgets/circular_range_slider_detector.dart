import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class AmountWidgetWrapperTrigger extends StatelessWidget {
  const AmountWidgetWrapperTrigger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context)
            .push(CircularRangeSliderPopUp<void>(context: context));
      },
      child: const AmountWidget(),
    );
  }
}

class CircularRangeSlider extends StatefulWidget {
  const CircularRangeSlider({
    super.key,
  });

  @override
  State<CircularRangeSlider> createState() => _CircularRangeSliderState();
}

class _CircularRangeSliderState extends State<CircularRangeSlider> {
  late double _value;

  @override
  void initState() {
    _value = 0;
    super.initState();
  }

  @override
  void dispose() {
    _value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _value =
              (_value + details.delta.dy / 100).clamp(0.0, double.infinity);
          dev.log('$_value', name: 'AmountIndicator: _value: ');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: CircularRangeSliderPainter(_value),
            child: const Center(child: AmountWidget()),
          ),
        ),
      ),
    );
  }
}

//  Text(
//               '${(_value * 100).toInt()}%', // Display value as percentage
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
