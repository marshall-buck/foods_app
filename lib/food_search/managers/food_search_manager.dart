import 'package:foods_app/common/constants.dart';
import 'package:foods_app/common/service_locator..dart';
import 'package:foods_app/food_search/models/food_list_Item.dart';
import 'package:foods_app/services/services_B.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchManager {
  Future<List<FoodListItem>> queryFoods({required String searchTerm}) async {
    final db = await di.getAsync<FoodsDBInterface>(
        instanceName: LocatorName.foodsDBService);
    final List<FoodModel?> foods = await db.queryFoods(searchTerm: searchTerm);
    if (foods.isEmpty) return [];

    return foods
        .map((food) => FoodListItem.fromFoodModel(food!, QuickSearch.defaults))
        .toList();
  }
}
