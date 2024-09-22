import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchManager {
  final currentResults = ValueNotifier<List<FoodListItemModel?>>([]);

  Future<void> queryFoods({required String searchTerm}) async {
    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);

    final foods = await db.queryFoods(searchTerm: searchTerm);

    if (foods.isNotEmpty) {
      final newItems = <FoodListItemModel?>[];
      for (final food in foods) {
        newItems.add(await FoodListItemModel.fromFoodDTO(food!));
      }
      currentResults.value = newItems;
    } else {
      currentResults.value = [];
    }
  }

  Future<void> clearSearch() async {
    currentResults.value = [];
  }

  void dispose() {
    currentResults.dispose();
  }
}
