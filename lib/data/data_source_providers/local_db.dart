import 'package:foods_app/data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:usda_db_package/usda_db_package.dart';

part 'local_db.g.dart';

class _LocalDB implements FoodsDBInterface {
  late final UsdaDB _db;

  UsdaDB get db => _db;

  bool get isDataLoaded => _db.isDataLoaded;
  bool get isInitializing => _db.isInitializing;

  _LocalDB() {
    _initDb();
  }

  Future<void> _initDb() async {
    _db = await UsdaDB.init();
  }

  @override
  Future<FoodModel?> queryFood({required id}) async {
    final SrLegacyFoodModel? food = await db.queryFood(id: id);
    return FoodModel.fromUsdaDB(food);
  }

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
    final List<SrLegacyFoodModel?> foods =
        await db.queryFoods(searchString: searchTerm);

    return foods.isEmpty ? [] : foods.map(FoodModel.fromUsdaDB).toList();
  }
}

@Riverpod(keepAlive: true)
FoodsDBInterface localDB(LocalDBRef ref) => _LocalDB();
