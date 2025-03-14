import 'dart:async';

import 'package:foods_app/data/food_search_api/models/food_dto.dart';

abstract interface class FoodSearchApiInterface {
  Future<FoodDTO?> queryFood({required int id});
  Future<List<FoodDTO>?> queryFoods({required String searchTerm});
  Future<void> dispose();
  void clearCache();
}
