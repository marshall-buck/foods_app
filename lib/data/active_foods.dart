import 'dart:collection';

import 'package:foods_app/common/extensions.dart';
import 'package:foods_app/common/magic.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFoods {
  final _activeFoods = Queue<Food?>();

  final _activeFoodsStreamController = BehaviorSubject<Queue<Food?>>();

  final _activeModifierStreamController = BehaviorSubject<double>.seeded(1);

  Stream<Queue<Food?>> get activeFoodsStream => _activeFoodsStreamController.stream.asBroadcastStream();

  Stream<double> get activeModifierStream => _activeModifierStreamController.stream.asBroadcastStream();

  double get activeModifier => _activeModifierStreamController.value;

  Queue<Food?> get activeFoods => _activeFoodsStreamController.valueOrNull ?? Queue<Food?>();

  void changeModifier(double double) {
    _activeModifierStreamController.add(double);
  }

  void resetModifier() {
    _activeModifierStreamController.add(1);
  }

  void addFood(FoodDAO food) {
    final map = <int, AmountRecord>{};
    map[food.id] = (MagicNumbers.defaultFoodAmount, MagicNumbers.defaultFoodAmount.convertAmountToString(), 'g');
    for (final item in food.nutrients.entries) {
      final id = item.key;
      final unit = NutrientDAO.usdaDBNutrientLookupTable[id]!['unit']!;
      map[id] = (item.value, item.value.convertAmountToString(), unit);
    }
    final convertedFood = Food.fromFoodDAO(food, map);

    _activeFoods.add(convertedFood);
    _activeFoodsStreamController.add(_activeFoods);
  }

  void removeFood(Food food) {
    _activeFoods.removeWhere((e) => food.id == e?.id);

    _activeFoodsStreamController.add(_activeFoods);
  }

  Food? get lastEntered => _activeFoods.isNotEmpty ? _activeFoods.last : null;

  Food? get firstEntered => _activeFoods.isNotEmpty ? _activeFoods.first : null;
}

// {id: amount}
