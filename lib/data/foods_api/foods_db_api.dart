import 'dart:async';

import 'package:foods_app/data/foods_api/models/food_dto.dart';

/// Interface for for a foods database.

abstract interface class FoodsDBApi {
  Future<FoodDTO?> queryFood({required int id});
  Future<List<FoodDTO?>> queryFoods({required String searchTerm});
  Future<void> dispose();
}
