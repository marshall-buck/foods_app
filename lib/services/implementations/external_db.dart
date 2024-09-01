import 'dart:async';

import 'package:foods_app/services/services.dart';

class ExternalDb implements FoodsDB {
  Future<ExternalDb> init() async {
    Future.delayed(const Duration(seconds: 1));
    return this;
  }

  @override
  Future<FoodModel?> queryFood({required id}) => throw UnimplementedError();

  @override
  Future<List<FoodModel?>> queryFoods({required String searchTerm}) =>
      throw UnimplementedError();

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }
}
