import 'package:flutter/material.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingWidget {
  const FoodDetail({required this.id, super.key});
  final ValueKey<int> id;

  @override
  Widget build(BuildContext context) {
    // final details = watchValue((FoodDetailManager m) => m.currentFoods)[0];
    // return const BasePage(
    //   title: details.description,
    //   slivers: [],
    // );
    return const Placeholder();
  }
}
