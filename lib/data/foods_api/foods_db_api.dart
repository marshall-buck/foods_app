import 'dart:async';

import 'package:foods_app/data/foods_api/models/food_dao.dart';

/// Interface for for a foods database.

abstract interface class FoodsDBApi {
  Future<FoodDAO?> queryFood({required int id});
  Future<List<FoodDAO>?> queryFoods({required String searchTerm});
  Future<void> dispose();
}
