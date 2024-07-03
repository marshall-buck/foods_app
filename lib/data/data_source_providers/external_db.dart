import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/models/food.dart';

class ExternalDb implements FoodsDBInterface {
  Future<ExternalDb> init() async {
    Future.delayed(Duration(seconds: 1));
    return this;
  }

  @override
  Future<FoodModel?> queryFood({required id}) => throw UnimplementedError();

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      throw UnimplementedError();
}
