import 'package:foods_app/data/data.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_repo.g.dart';

//TODO: Implement logic to handle external foods source

class _FoodsDBRepo implements FoodsDBInterface {
  final FoodsDBInterface _localDB;

  const _FoodsDBRepo(this._localDB);

  @override
  bool get isDataLoaded => _localDB.isDataLoaded;

  @override
  Future<FoodModel?> queryFood({required id}) => _localDB.queryFood(id: id);

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      _localDB.queryFoods(searchTerm: searchTerm);
}

@riverpod
FoodsDBInterface foodsDBRepo(FoodsDBRepoRef ref) =>
    _FoodsDBRepo(ref.watch(localDBProvider));
