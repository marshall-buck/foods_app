// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:foods_app/external_data/external_services_bar.dart';
import 'package:usda_db_package/usda_db_package.dart';

//TODO: Implement logic to handle external foods source

class FoodsDBI implements FoodsDB {
  FoodsDBI(UsdaDB? _usdaDB) {
    assert(_usdaDB != null);
  }
  UsdaDB? _usdaDB;

  get localDB => _usdaDB;

  @override
  Future<FoodModel?> queryFood({required id}) async {
    final SrLegacyFoodModel? food = await _usdaDB?.queryFood(id: id);
    if (food == null) {
      return null;
    }
    return FoodModel.fromUsdaDB(food);
  }

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
    final List<SrLegacyFoodModel?> foods =
        await _usdaDB!.queryFoods(searchString: searchTerm);

    return foods.isEmpty
        ? []
        : foods.map((food) => FoodModel.fromUsdaDB(food!)).toList();
  }

  @override
  Future<void> dispose() async {
    await _usdaDB?.dispose();
    _usdaDB = null;
  }
}
