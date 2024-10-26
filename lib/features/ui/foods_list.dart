import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class FoodsList extends WatchingWidget {
  const FoodsList({super.key});

  Future<void> _onTap(BuildContext context, ValueKey<int> id) async {
    await di.get<FoodDetailManager>().queryFood(id.value);
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute<FoodDetail>(builder: (context) => const FoodDetail()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodResults = watchValue((FoodSearchManager x) => x.currentResults);

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final food = foodResults[index];

        final id = ValueKey<int>(food!.id);
        return GestureDetector(
          onTap: () => _onTap(context, id),
          child: FoodListItem(
            key: id,
            food: food,
          ),
        );
      },
      itemCount: foodResults.length,
    );
  }
}
