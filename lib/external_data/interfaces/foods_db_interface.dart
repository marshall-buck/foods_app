import 'dart:async';

import 'package:foods_app/external_data/models/food.dart';

/// Interface for for a foods database.

abstract interface class FoodsDB {
  Future<FoodModel?> queryFood({required id});
  Future<List<FoodModel?>> queryFoods({required String searchTerm});
  Future<void> dispose();
}
