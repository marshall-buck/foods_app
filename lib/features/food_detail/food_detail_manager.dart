import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailManager {
  final currentFood = ValueNotifier<FoodDTO?>(null);
  final _foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
  String get description => currentFood.value!.description;

  Future<void> queryFood(int id) async {
    final food = await _foodsDB.queryFood(id: id);
    currentFood.value = food;
  }

  void dispose() {
    currentFood.dispose();
  }
}
