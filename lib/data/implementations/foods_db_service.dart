import 'dart:async';

import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

/// A service class that interacts with a foods database both local and
/// remote (in the future to query food data).

/// Class to handle the foods database.
/// A class that interacts with a foods database both local and
/// remote (in the future to query food data).
///
/// This class is responsible for initializing the foods database and providing
/// methods to retrieve food items from the database.
///
/// The [FoodsDBService] class is initialized by providing a [UsdaDB] object.
///
/// The [localDB] getter returns the local database instance.
///

class FoodsDBService implements FoodsDB {
  FoodsDBService(this._usdaDB);
  final UsdaDB _usdaDB;

  UsdaDB get localDB => _usdaDB;

  /// The [queryFood] method takes a food ID as a parameter and returns the
  /// corresponding [FoodDTO] object from the database. If the food ID
  /// is not found in the database, the method returns null.
  @override
  Future<FoodDTO?> queryFood({required int id}) async {
    final food = await _usdaDB.queryFood(id: id);
    if (food == null) {
      return null;
    }
    return FoodDTO.fromUsdaDB(food);
  }

  /// The [queryFoods] method takes a search term as a parameter and returns a
  /// list of corresponding [FoodDTO] objects from the database. If no foods
  /// match the search term, the method returns an empty list.
  @override
  Future<List<FoodDTO?>> queryFoods({required String searchTerm}) async {
    final foods = await _usdaDB.queryFoods(searchString: searchTerm);

    return foods.isEmpty
        ? []
        : foods.map((food) => FoodDTO.fromUsdaDB(food!)).toList();
  }

  /// The  [dispose] method closes the database connection and releases any
  /// resources associated with the database.
  @override
  Future<void> dispose() async {
    await _usdaDB.dispose();
    assert(
      _usdaDB.isDataLoaded == false,
      'FoodsDBService- dispose assert error',
    );
  }
}
