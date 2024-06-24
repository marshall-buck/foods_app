import 'package:foods_app/data/data.dart';

import 'package:usda_db_package/usda_db_package.dart';

class LocalDB implements FoodsDBInterface {
  final UsdaDB db;

  const LocalDB({required this.db});

  @override
  bool get isDataLoaded => db.isDataLoaded;

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
