import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

/// {@template foods_search_cache}
/// A cache for storing and retrieving [FoodDTO] objects by their ID.
/// {@endtemplate}
class FoodsSearchCache {
  /// {@macro foods_search_cache}
  FoodsSearchCache();
  final Map<int, FoodDTO> _cache = {};

  /// Retrieves a [FoodDTO] from the cache by its [id].
  ///
  /// Returns the [FoodDTO] if it exists in the cache, otherwise returns `null`.
  FoodDTO? query(int id) => _cache[id];

  /// Adds a [FoodDTO] to the cache with the given [id].
  ///
  /// If an entry with the same [id] already exists, it will be replaced.
  void add(int id, FoodDTO food) {
    if (_cache.length >= MagicNumbers.maxFoodSearchCacheAmount && _cache.isNotEmpty) {
      _cache.remove(_cache.keys.first);
    }
    _cache[id] = food;
  }

  /// Checks if a [FoodDTO] with the given [id] exists in the cache.
  ///
  /// Returns `true` if the cache contains an entry with the [id], otherwise `false`.
  bool contains(int id) => _cache.containsKey(id);

  /// Clears all entries from the cache.
  void clear() => _cache.clear();
}
