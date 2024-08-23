import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/food_search.dart';

import 'package:watch_it/watch_it.dart';

/// Comments
class FoodSearchManager extends ChangeNotifier {
  final ValueNotifier<List<FoodListItemModel?>> currentResults =
      ValueNotifier<List<FoodListItemModel?>>([]);

  Future<void> queryFoods({required String searchTerm}) async {
    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);

    final List<FoodModel?> foods = await db.queryFoods(searchTerm: searchTerm);

    if (foods.isNotEmpty) {
      currentResults.value = foods
          .map((food) =>
              FoodListItemModel.fromFoodModel(food!, QuickSearch.defaults))
          .toList();
    }

    print(
        'FoodSearchManager - currentResults:hashCode: ${currentResults.value.hashCode}');
    print(
        'FoodSearchManager - currentResults:length: ${currentResults.value.length}');
  }
}
