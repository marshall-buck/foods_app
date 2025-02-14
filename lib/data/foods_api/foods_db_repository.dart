import 'dart:async';

import 'package:foods_app/data/data.dart';

import 'package:usda_db_package/usda_db_package.dart';

/// {@template foods_db_repo}
/// A repository that handles searching for foods.
/// {@endtemplate}
class FoodsDBRepository implements FoodsDBApi {
  /// {@macro foods_db_repo}
  FoodsDBRepository({required UsdaDB localDBApi}) : _localDBApi = localDBApi;
  final UsdaDB _localDBApi;

  /// Provides a [FoodDAO] object from the database.
  /// If the food ID is not found in the database, the Future returns null.
  @override
  Future<FoodDAO?> queryFood({required int id}) async {
    final food = await _localDBApi.queryFood(id: id);
    if (food == null) {
      return null;
    }
    return FoodDAO.fromUsdaDB(food);
  }

  /// Provides a List [FoodDAO] objects from the database.
  /// If no foods are found in the database, the Future returns an empty list.
  @override
  Future<List<FoodDAO?>> queryFoods({required String searchTerm}) async {
    final foods = await _localDBApi.queryFoods(searchString: searchTerm);

    return foods.isEmpty
        ? []
        : foods.map((food) => FoodDAO.fromUsdaDB(food!)).toList();
  }

  /// The  [dispose] method closes the database connection and releases any
  /// resources associated with the database.
  @override
  Future<void> dispose() async {
    await _localDBApi.dispose();
    assert(
      _localDBApi.isDataLoaded == false,
      'FoodsDBService- dispose assert error',
    );
  }
}
