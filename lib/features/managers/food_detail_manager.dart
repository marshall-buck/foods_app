import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);

  String? get description => currentFood.value?.description;
  num? get id => currentFood.value?.id;
  num? get foodAmount => currentFood.value?.foodAmount;
  Map<int, Nutrient>? get nutrientMap => currentFood.value?.nutrientMap;
  List<Nutrient>? get nutrientList => currentFood.value?.nutrientList;

  late Map<num, num> _amounts;

  Map<num, num> get amount => _amounts;

  Future<void> queryFood(int id) async {
    final foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final food = await foodsDB.queryFood(id: id);
    currentFood.value = Food.fromFoodDTO(food!);
    _populateAmounts();
  }

  void changeUnits(double modifier) {
    dev.log(
      '${_amounts.entries.first}',
      name: 'FoodDetailManager - changeUnits amounts before:  ',
    );
    final newMap = <num, num>{};
    for (final en in _amounts.entries) {
      final key = en.key;
      final value = en.value;

      newMap[key] = value + (modifier / 100);
    }
    _amounts = Map.unmodifiable(newMap);
    dev.log(
      '${_amounts.entries.first}',
      name: 'FoodDetailManager - changeUnits amounts after:  ',
    );

    notifyListeners();
  }

  void resetToOriginalAmounts() {
    _populateAmounts();
    notifyListeners();
  }

  void _populateAmounts() {
    assert(
      currentFood.value != null,
      'FoodDetailManager _populateAmounts() - There is no current food',
    );
    _amounts = {currentFood.value!.id: currentFood.value!.foodAmount};
    for (final item in currentFood.value!.nutrientList) {
      _amounts[item.id] = item.amount;
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentFood.dispose();
  }
}
