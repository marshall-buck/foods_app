import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';

class FoodComparisonPage extends StatelessWidget {
  const FoodComparisonPage({required this.foods, super.key});

  final List<Food> foods;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isPort = size.width < size.height;

    dev.log('$isPort', name: '_isPort');

    return isPort == false
        ? const Row(
            children: [
              Expanded(child: Placeholder()),
              Expanded(child: Placeholder()),
            ],
          )
        : const Column(
            children: [
              Expanded(child: Placeholder()),
              Expanded(child: Placeholder()),
              Expanded(child: Placeholder()),
            ],
          );
  }
}
