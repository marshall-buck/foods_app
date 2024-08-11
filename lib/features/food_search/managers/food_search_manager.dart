import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/mockData/fake_data.dart';
import 'package:watch_it/watch_it.dart';

/// Comments
class FoodSearchManager extends ChangeNotifier {
  final ValueNotifier<List<FoodListItemModel>?> currentResults =
      ValueNotifier<List<FoodListItemModel>?>(null);

  final ValueNotifier<String> searchTerm = ValueNotifier<String>('');

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
// import 'dart:async';
//
// import 'package:flutter/foundation.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/external_data/external_data.dart';
// import 'package:foods_app/features/food_search/food_search.dart';
// import 'package:foods_app/mockData/fake_data.dart';
// import 'package:watch_it/watch_it.dart';
//
// class FoodSearchManager extends ChangeNotifier {
//   final ValueNotifier<List<FoodListItemModel>?> currentResults =
//   ValueNotifier<List<FoodListItemModel>?>(null);
//   final ValueNotifier<String> searchTerm = ValueNotifier<String>('');
//
//   Future<List<FoodListItemModel>> getMockData() => fakeFoodsListItems();
//
//   Future<void> queryFoods({required String searchTerm}) async {
//     final db =
//     await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);
//     final List<FoodModel?> foods = await db.queryFoods(searchTerm: searchTerm);
//
//     currentResults.value = foods
//         .map((food) =>
//         FoodListItemModel.fromFoodModel(food!, QuickSearch.defaults))
//         .toList();
//   }
// }
