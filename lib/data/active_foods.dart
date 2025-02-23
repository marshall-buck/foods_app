import 'dart:collection';

import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/models/models.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFoods {
  final _activeFoods = Queue<Food?>();

  final _activeFoodsStreamController = BehaviorSubject<Queue<Food?>>();

  Stream<Queue<Food?>> get activeFoodsStream => _activeFoodsStreamController.stream.asBroadcastStream();

  Queue<Food?> get activeFoods => _activeFoodsStreamController.valueOrNull ?? Queue<Food?>();

  void add(FoodDAO food) {
    final convertedFood = Food.fromFoodDAO(food);
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
