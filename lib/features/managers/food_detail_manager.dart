import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);

  String? get description => currentFood.value?.description;

  double _amount = 100;

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
    notifyListeners();
  }

  Future<void> queryFood(int id) async {
    final foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final food = await foodsDB.queryFood(id: id);
    currentFood.value = Food.fromFoodDTO(food!);
  }

  void changeUnits(double modifier) {
    amount = amount * modifier;
  }

  @override
  void dispose() {
    super.dispose();
    currentFood.dispose();
  }
}
