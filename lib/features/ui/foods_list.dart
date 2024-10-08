import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class FoodsList extends StatelessWidget {
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
    final foodManager = di.get<FoodSearchManager>();

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
          return SliverPadding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final food = value[index];

                  final id = ValueKey<int>(food!.id);
                  return GestureDetector(
                    onTap: () => _onTap(context, id),
                    child: FoodListItem(
                      key: id,
                      food: food,
                    ),
                  );
                },
                childCount: value.length,
              ),
            ),
          );
        }
      },
    );
  }
}
