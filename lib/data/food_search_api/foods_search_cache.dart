import 'package:foods_app/data/data.dart';

/// {@template foods_search_cache}
/// A cache for storing and retrieving [FoodDAO] objects by their ID.
/// {@endtemplate}
class FoodsSearchCache {
  /// {@macro foods_search_cache}
  FoodsSearchCache();
  final Map<int, FoodDAO> _cache = {};

  /// Retrieves a [FoodDAO] from the cache by its [id].
  ///
  /// Returns the [FoodDAO] if it exists in the cache, otherwise returns `null`.
  FoodDAO? get(int id) => _cache[id];

  /// Adds a [FoodDAO] to the cache with the given [id].
  ///
  /// If an entry with the same [id] already exists, it will be replaced.
  void set(int id, FoodDAO food) => _cache[id] = food;

  /// Checks if a [FoodDAO] with the given [id] exists in the cache.
  ///
  /// Returns `true` if the cache contains an entry with the [id], otherwise `false`.
  bool contains(int id) => _cache.containsKey(id);

  /// Clears all entries from the cache.

  void clear() => _cache.clear();
}
