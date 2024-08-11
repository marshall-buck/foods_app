import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/food_search.dart';

class FoodsList extends StatelessWidget {
  const FoodsList({
    required this.foods,
    super.key,
  });

  final List<FoodListItemModel> foods;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (BuildContext context, int index) =>
            FoodListItem(foods: foods, index: index));
  }
}
