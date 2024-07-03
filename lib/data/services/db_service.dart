import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/models/food.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

//TODO: Implement logic to handle external foods source

class FoodsDBService implements FoodsDBInterface {
  const FoodsDBService();
  @override
  Future<FoodModel?> queryFood({required id}) async {
    final usdaDB = await di.getAsync<UsdaDB>();
    final SrLegacyFoodModel? food = await usdaDB.queryFood(id: id);
    return FoodModel.fromUsdaDB(food);
  }

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
    final usdaDB = await di.getAsync<UsdaDB>();
    final List<SrLegacyFoodModel?> foods =
        await usdaDB.queryFoods(searchString: searchTerm);

    return foods.isEmpty ? [] : foods.map(FoodModel.fromUsdaDB).toList();
  }
}
