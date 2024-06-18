import 'package:foods_app/data/data_source_providers/local_db.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/models/food.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_repo.g.dart';

@Riverpod(keepAlive: true)
class FoodsDB extends _$FoodsDB implements FoodsDBInterface {
  @override
  void build() {}

  @override
  Future<FoodModel?> queryFood({required id}) =>
      ref.read(localDBProvider.notifier).queryFood(id: id);

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      ref.read(localDBProvider.notifier).queryFoods(searchTerm: searchTerm);
}
