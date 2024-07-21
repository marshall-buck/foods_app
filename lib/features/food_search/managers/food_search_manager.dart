import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/constants.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/features/food_search/models/food_list_Item.dart';
import 'package:foods_app/external_data/external_services_B.dart';
import 'package:foods_app/features/food_search/ui/fake_data.dart';

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
