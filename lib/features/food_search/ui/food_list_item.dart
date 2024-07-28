import 'package:flutter/material.dart';

import 'package:foods_app/features/food_search/models/food_list_item.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({super.key, required this.foods, required this.index});
  final List<FoodListItemModel> foods;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              foods[index].description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(foods[index].nutrients.toString()),
          ],
        ),
      ),
    );
  }
}
