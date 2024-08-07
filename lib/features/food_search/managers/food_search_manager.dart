import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/zcommon.dart';
import 'package:foods_app/external_data/zexternal_data.dart';
import 'package:foods_app/features/food_search/models/food_list_item.dart';
import 'package:foods_app/mockData/fake_data.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchManager extends ChangeNotifier {
  final ValueNotifier<List<FoodListItemModel>?> currentResults =
      ValueNotifier<List<FoodListItemModel>?>(null);

  Future<List<FoodListItemModel>> getMockData() => fakeFoodsListItems();

  Future<void> queryFoods({required String searchTerm}) async {
    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final List<FoodModel?> foods = await db.queryFoods(searchTerm: searchTerm);
    // if (foods.isEmpty) return [];

    currentResults.value = foods
        .map((food) =>
            FoodListItemModel.fromFoodModel(food!, QuickSearch.defaults))
        .toList();
  }
}
