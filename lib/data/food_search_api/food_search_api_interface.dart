import 'dart:async';

import 'package:foods_app/data/data.dart';

//TODO: Eventually multiple classes will use this, right now only the local Usda uses it,
// but further down the road external ips can be used.

/// {@template food_search_api_interface}
/// An interface for food search operations, which can be implemented
/// for both internal databases and external APIs.
///
/// Provides methods to query individual food items, search for multiple
/// food items, manage resources, and clear cached data.
/// {@endtemplate}
abstract interface class FoodSearchApiInterface {
  /// {@macro food_search_api_interface}
  /// Provides access to the cache for food search operations.
  FoodsSearchCache get cache;

  /// {@macro food_search_api_interface}
  /// Queries a single food item by its unique [id].
  ///
  /// Returns a [FoodDTO] if found, otherwise returns `null`.
  Future<FoodDTO?> queryFood({required int id});

  /// {@macro food_search_api_interface}
  /// Searches for multiple food items matching the given [searchTerm].
  ///
  /// Returns a list of [FoodDTO] objects if matches are found, otherwise
  /// returns `null`.
  Future<List<FoodDTO>?> queryFoods({required String searchTerm});

  /// {@macro food_search_api_interface}
  /// Disposes of any resources held by the implementation.
  Future<void> dispose();

  /// {@macro food_search_api_interface}
  /// Clears any cached data held by the implementation.
  void clearCache();
}
