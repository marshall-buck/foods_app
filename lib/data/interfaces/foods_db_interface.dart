import 'dart:async';

import 'package:foods_app/services/models/food_dto.dart';

/// Interface for for a foods database.

abstract interface class FoodsDB {
  Future<FoodDTO?> queryFood({required int id});
  Future<List<FoodDTO?>> queryFoods({required String searchTerm});
  Future<void> dispose();
}
