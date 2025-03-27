import 'dart:async';

import 'package:foods_app/data/food_search_api/models/food_dto.dart';

/// Class would be used for both an internal DB and an external api.
abstract interface class FoodSearchApiInterface {
  Future<FoodDTO?> queryFood({required int id});
  Future<List<FoodDTO>?> queryFoods({required String searchTerm});
  Future<void> dispose();
  void clearCache();
}
