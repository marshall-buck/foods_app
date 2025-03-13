import 'dart:collection';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// {@template active_foods}
/// A class that manages the active foods in the application.
/// {@endtemplate}
class ActiveFoods {
  final _activeFoods = Queue<Food?>();

  final _activeFoodsStreamController = BehaviorSubject<Queue<Food?>>();

  final _activeModifierStreamController = BehaviorSubject<double>.seeded(1);

  /// A stream of active foods.
  Stream<Queue<Food?>> get activeFoodsStream => _activeFoodsStreamController.stream.asBroadcastStream();

  /// A stream of the active modifier.
  Stream<double> get activeModifierStream => _activeModifierStreamController.stream.asBroadcastStream();

  /// The current active modifier.  This is a double that represents the percentage change to multiply an amount by,
  /// to get an adjusted amount. It is to be used when the user updates and active food in the ui.
  double get activeModifier => _activeModifierStreamController.value;

  /// The current active foods.
  Queue<Food?> get activeFoods => _activeFoodsStreamController.valueOrNull ?? Queue<Food?>();

  static const maxFoodsAllowed = MagicNumbers.maxActiveFoodsAllowed;

  /// Changes the active modifier.
  ///
  /// [double] is the new modifier value.
  void changeModifier(double double) {
    _activeModifierStreamController.add(double);
  }

  /// Resets the active modifier to its default value.
  void resetModifier() {
    _activeModifierStreamController.add(1);
  }

  /// Adds a [Food] to the end active foods Queue, and updates the Stream.
  void addFood(FoodDAO food) {
    if (_activeFoods.length == maxFoodsAllowed) {
      _activeFoods.removeFirst();
    }
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

  /// Removes a [Food] from the active foods list, and updates the Stream.
  void removeFood(Food food) {
    _activeFoods.removeWhere((e) => food.id == e?.id);

    _activeFoodsStreamController.add(_activeFoods);
  }

  /// The last (most recent) entered food.
  Food? get lastEntered => _activeFoods.isNotEmpty ? _activeFoods.last : null;

  /// The first entered food.
  Food? get firstEntered => _activeFoods.isNotEmpty ? _activeFoods.first : null;
}
