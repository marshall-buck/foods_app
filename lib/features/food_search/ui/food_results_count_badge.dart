import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:watch_it/watch_it.dart';

class FoodResultsCountBadge extends WatchingWidget {
  const FoodResultsCountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final count = watchValue((FoodSearchManager m) => m.currentResults);
    return Badge.count(
      count: count.length,
      backgroundColor: Colors.transparent,
      textColor: AppColorsExtension.of(context).onSurface,
      padding: const EdgeInsets.only(right: 8),
    );
  }
}
