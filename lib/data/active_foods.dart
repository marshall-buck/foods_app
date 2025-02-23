import 'dart:collection';

import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/models/models.dart';
import 'package:rxdart/rxdart.dart';

class ActiveFoods {
  final Foods _activeFoods = Foods.empty();

  final _activeFoodsStreamController = BehaviorSubject<Foods>();

  Stream<Foods> get activeFoodsStream => _activeFoodsStreamController.stream.asBroadcastStream();

  Foods get activeFoods => _activeFoodsStreamController.valueOrNull ?? Foods.empty();

  void add(FoodDAO food) {
    _activeFoods.add(food);
    _activeFoodsStreamController.add(_activeFoods);
  }

  void removeFood(Food food) {
    _activeFoods.removeFood(food);

    _activeFoodsStreamController.add(_activeFoods);
  }

  Food? get lastEntered => _activeFoods.lastEntered;

  Food? get firstEntered => _activeFoods.firstEntered;
}
