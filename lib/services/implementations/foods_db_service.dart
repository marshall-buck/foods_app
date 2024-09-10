import 'dart:async';

import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

//TODO: Implement logic to handle external foods source

/// A service class that interacts with a foods database both local and
/// remote in the future to query food data.

/// This class implements the `FoodsDB` interface and provides methods to query
/// individual food items and lists of food items from the  database.
/// It also includes a method to dispose of the database connection when
/// it is no longer needed.

class FoodsDBService implements FoodsDB {
  FoodsDBService(this._usdaDB);
  final UsdaDB _usdaDB;

  get localDB => _usdaDB;

  @override
  Future<FoodModel?> queryFood({required int id}) async {
    final SrLegacyFoodModel? food = await _usdaDB.queryFood(id: id);
    if (food == null) {
      return null;
    }
    return FoodModel.fromUsdaDB(food);
  }

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
    final List<SrLegacyFoodModel?> foods =
        await _usdaDB.queryFoods(searchString: searchTerm);

    // print('FoodsDBService- queryFoods searchTerm:  $searchTerm');
    // print('FoodsDBService- queryFoods foods:  $foods');

    return foods.isEmpty
        ? []
        : foods.map((food) => FoodModel.fromUsdaDB(food!)).toList();
  }

  @override
  Future<void> dispose() async {
    await _usdaDB.dispose();
    assert(_usdaDB.isDataLoaded == false);
  }
}