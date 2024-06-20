import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foods_app/data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:usda_db_package/usda_db_package.dart';

part 'local_db.g.dart';

class _LocalDB implements FoodsDBInterface {
  final UsdaDB db;

  const _LocalDB({required this.db});

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

@Riverpod(keepAlive: true)
UsdaDB usdaDB(UsdaDBRef ref) => throw UnimplementedError();

@riverpod
FoodsDBInterface localDB(LocalDBRef ref) =>
    _LocalDB(db: ref.watch(usdaDBProvider));
