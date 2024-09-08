import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:watch_it/watch_it.dart';

class FoodsList extends StatelessWidget {
  const FoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final foodManager = di.get<FoodSearchManager>();
    print('FoodsList: building');
    return ValueListenableBuilder<List<FoodListItemModel?>>(
      valueListenable: foodManager.currentResults,
      builder: (BuildContext context, value, Widget? child) {
        if (value.isEmpty) {
          return SliverToBoxAdapter(
            child: Text(
              'No results found.',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                print('SliverChildBuilderDelegate: building');
                final food = value[index];

                final id = food!.id;
                final key = ValueKey<int>(id);
                return FoodListItem(key: key, food: food);
              },
              childCount: value.length,
            ),
          );
        }
      },
    );
  }
}
