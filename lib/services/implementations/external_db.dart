import 'dart:async';

import 'package:foods_app/services/services.dart';

class ExternalDb implements FoodsDB {
  Future<ExternalDb> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return this;
  }

  @override
  Future<FoodDTO?> queryFood({required int id}) => throw UnimplementedError();

  @override
  Future<List<FoodDTO?>> queryFoods({required String searchTerm}) =>
      throw UnimplementedError();

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }
}
