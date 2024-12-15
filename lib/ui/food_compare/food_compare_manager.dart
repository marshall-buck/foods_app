import 'package:flutter/foundation.dart';

import 'package:foods_app/domain/domain.dart';

class FoodCompareManager {
  final _compareList = <Food?>[];

  final ValueNotifier<bool> _isComparing = ValueNotifier<bool>(false);

  ValueListenable<bool> get isComparing => _isComparing;

  List<Food?> get compareList => _compareList;
}
