import 'dart:collection';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// {@template active_foods}
/// A class that manages the active foods in the application.
/// {@endtemplate}
class ActiveFoods {
  /// The most recent food entered will be placed at he end of the Queue.
  final _activeFoods = Queue<Food?>();

  final _activeFoodsStreamController = BehaviorSubject<Queue<Food?>>();

  final _activeModifierStreamController = BehaviorSubject<double>.seeded(1);

  /// A stream of active foods.
  Stream<Queue<Food?>> get activeFoodsStream => _activeFoodsStreamController.stream.asBroadcastStream();

  /// A stream of the active modifier.
  Stream<double> get activeModifierStream => _activeModifierStreamController.stream.asBroadcastStream();

  /// The current active modifier.  A double representing a percentage.
  /// The default value is 1.0, which represents no change.
  /// This value is used (originalFoodValue * activeModifier) to calculate the current food value.
  double get activeModifier => _activeModifierStreamController.value;

  /// The current active foods Queue.
  Queue<Food?> get activeFoods => _activeFoodsStreamController.valueOrNull ?? Queue<Food?>();

  static const maxFoodsAllowed = MagicNumbers.maxActiveFoodsAllowed;

  /// Changes the active modifier.
  void changeModifier(double double) => _activeModifierStreamController.add(double);

  /// Resets the active modifier to its default value.
  void resetModifier() => _activeModifierStreamController.add(1);

  /// Adds a [Food] to the end active foods Queue, and updates the Stream.
  void addFood(FoodDTO food) {
    if (_activeFoods.length == maxFoodsAllowed) {
      _activeFoods.removeFirst();
    }
    final map = <int, AmountHolder>{};

    map[food.id] = const AmountHolder(
      amount: MagicNumbers.defaultFoodAmount,
      // amountString: MagicNumbers.defaultFoodAmount.convertAmountToString(),
      unitString: 'g',
    );
    for (final item in food.nutrients.entries) {
      final id = item.key;
      final unit = NutrientDTO.usdaDBNutrientLookupTable[id]!['unit']!;
      map[id] = AmountHolder(amount: item.value, unitString: unit);
    }
    final convertedFood = Food.fromFoodDTO(food, map);

    _activeFoods.add(convertedFood);
    _activeFoodsStreamController.add(_activeFoods);
  }

  /// Removes a [Food] from the active foods list, and updates the Stream.
  void removeFood(Food food) {
    _activeFoods.removeWhere((e) => food.id == e?.id);

    _activeFoodsStreamController.add(_activeFoods);
  }
}
