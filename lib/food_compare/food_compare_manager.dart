import 'dart:collection';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import 'package:foods_app/entities/entities.dart';

class FoodCompareManager extends ChangeNotifier {
  final _compareQueue = Queue<Food?>();

  // final ValueNotifier<bool> _isComparing = ValueNotifier<bool>(false);

  // ValueListenable<bool> get isComparing => _isComparing;

  Queue<Food?> get compareList => _compareQueue;

  void addFoodToCompare({required Food food}) {
    _compareQueue.addLast(food);

    dev.log(
      '${_compareQueue.length}  ${_compareQueue.last!.description}',
      name: ' FoodCompareManager: addFoodToCompare Count',
    );
    notifyListeners();
  }
}
