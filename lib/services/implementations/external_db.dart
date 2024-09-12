import 'dart:async';

import 'package:foods_app/services/services.dart';

class ExternalDb implements FoodsDB {
  Future<ExternalDb> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return this;
  }

  @override
  Future<FoodModel?> queryFood({required int id}) => throw UnimplementedError();

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      throw UnimplementedError();

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }
}
