import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingWidget {
  const FoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final details = watchValue((FoodDetailManager m) => m.currentFood);
    return BasePage(
      title: details!.description,
      slivers: const [],
    );
  }
}
