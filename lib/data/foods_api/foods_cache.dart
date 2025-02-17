import 'package:foods_app/data/data.dart';

class FoodsCache {
  final Map<int, FoodDAO> _cache = {};

  FoodDAO? get(int id) => _cache[id];

  void set(int id, FoodDAO food) => _cache[id] = food;

  bool contains(int id) => _cache.containsKey(id);

  void clear(String term) => _cache.clear();
}
