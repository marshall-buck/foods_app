import 'dart:async';

import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

/// {@template foods_db_repo}
/// A repository that handles searching for foods.
/// {@endtemplate}
class LocalFoodsDBRepo implements FoodSearchApiInterface {
  /// {@macro foods_db_repo}
  LocalFoodsDBRepo({required UsdaDbDAO localDbDao, required FoodsSearchCache cache})
      : _localDbDao = localDbDao,
        _cache = cache;

  final UsdaDbDAO _localDbDao;
  final FoodsSearchCache _cache;

  /// Provides a [FoodDTO] object from the database.
  /// If the food ID is not found in the database, the Future returns null.
  ///
  /// [id] is the unique identifier of the food to be queried.
  @override
  Future<FoodDTO?> queryFood({required int id}) async {
    if (_cache.contains(id)) {
      return _cache.query(id);
    } else {
      final food = await _localDbDao.queryFood(id: id);
      if (food == null) {
        return null;
      }
      return FoodDTO.fromUsdaFoodModel(food);
    }
  }

  /// Clears all entries from the [FoodsSearchCache] cache.
  @override
  void clearCache() => _cache.clear();

  /// Provides a List of [FoodDTO] objects from the database.
  /// If no foods are found in the database, the Future returns an empty list.
  ///
  /// [searchTerm] is the term used to search for foods in the database.
  @override
  Future<List<FoodDTO>?> queryFoods({required String searchTerm}) async {
    final foods = await _localDbDao.queryFoods(searchString: searchTerm);

    if (foods.isEmpty) {
      return null;
    } else {
      return foods.map((food) {
        final convertedFood = FoodDTO.fromUsdaFoodModel(food!);
        final id = convertedFood.id;
        _cache.add(id, convertedFood);
        return convertedFood;
      }).toList();
    }
  }

  /// The [dispose] method closes the database connection and releases any
  /// resources associated with the database.
  @override
  Future<void> dispose() async {
    await _localDbDao.dispose();
    _cache.clear();
    assert(
      _localDbDao.isDataLoaded == false,
      'FoodsDBService- dispose assert error',
    );
  }
}
