import 'package:foods_app/data/data.dart';

/// Interface for for a foods database.

abstract interface class FoodsDBInterface {
  Future<FoodModel?> queryFood({required id});
  Future<List<FoodModel?>> queryFoods({required String searchTerm});
}
