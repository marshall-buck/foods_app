import 'dart:async';

import 'package:foods_app/data/food_search_api/models/food_dao.dart';

abstract interface class FoodSearchApiInterface {
  Future<FoodDAO?> queryFood({required int id});
  Future<List<FoodDAO>?> queryFoods({required String searchTerm});
  Future<void> dispose();
  void clearCache();
}
