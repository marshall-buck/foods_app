import 'package:foods_app/data/data.dart';

//TODO: Implement logic to handle external foods source

class FoodsDBRepo implements FoodsDBInterface {
  final FoodsDBInterface _localDB;

  const FoodsDBRepo(this._localDB);

  @override
  bool get isDataLoaded => _localDB.isDataLoaded;

  @override
  Future<FoodModel?> queryFood({required id}) => _localDB.queryFood(id: id);

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      _localDB.queryFoods(searchTerm: searchTerm);
}
