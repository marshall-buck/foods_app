import 'package:foods_app/data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:usda_db_package/usda_db_package.dart';

part 'local_db.g.dart';

@Riverpod(keepAlive: true)
class LocalDB extends _$LocalDB implements FoodsDBInterface {
  @override
  Future<UsdaDB> build() async {
    return await UsdaDB.init();
  }

  @override
  Future<FoodModel?> queryFood({required id}) async {
    final SrLegacyFoodType? food = await state.value!.queryFood(id: id);
    return FoodModel.fromUsdaDB(food!);
  }

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
    final List<SrLegacyFoodType?> foods =
        await state.value!.queryFoods(searchString: searchTerm);

    final List<FoodModel?> converted = [];
    if (foods.isNotEmpty) {
      for (final food in foods) {
        converted.add(FoodModel.fromUsdaDB(food!));
      }
    }

    return converted;
  }
}
