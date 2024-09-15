// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchManager {
  final currentResults = ValueNotifier<List<FoodListItemModel?>>([]);

  Future<void> queryFoods({required String searchTerm}) async {
    print(searchTerm);
    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);

    final foods = await db.queryFoods(searchTerm: searchTerm);
//TODO:Change quick search
    if (foods.isNotEmpty) {
      currentResults.value = foods
          .map((food) => FoodListItemModel.fromFoodModel(food!, const ['1003']))
          .toList();
    }

    // print(
    //   'FoodSearchManager - currentResults:hashCode: ${currentResults.value.hashCode}',
    // );
    // print(
    //   'FoodSearchManager - currentResults:length: ${currentResults.value.length}',
    // );
  }

  Future<void> clearSearch() async {
    currentResults.value = [];
  }

  void dispose() {
    currentResults.dispose();
  }
}
