import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class FoodResultsCountBadge extends WatchingWidget {
  const FoodResultsCountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final count = watchValue((FoodSearchManager m) => m.currentResults);
    return Badge.count(
      count: count.length,
      backgroundColor: Colors.transparent,
      textColor: FoodsAppThemeExtension.of(context).onSurface,
      padding: const EdgeInsets.only(right: 8),
    );
  }
}
