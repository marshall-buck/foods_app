import 'dart:async';

import 'package:foods_app/services/models/food.dart';

/// Interface for for a foods database.

abstract interface class FoodsDB {
  Future<FoodModel?> queryFood({required int id});
  Future<List<FoodModel?>> queryFoods({required String searchTerm});
  Future<void> dispose();
}
