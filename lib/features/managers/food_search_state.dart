import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:foods_app/features/features.dart';
import 'package:watch_it/watch_it.dart';

/// The source of truth showing the history of foods the user has clicked
/// and the history of search terms.  All regarding the current app session.
class FoodSearchState extends ChangeNotifier {
  static int maxHistory = 10;
  final _foodsHistory = Queue<Food?>();
  final _searchTermHistory = Queue<String?>();
  Food? get currentFood => _foodsHistory.last;
  List<String?> get searchTermHistory => _searchTermHistory.toList();
  List<Food?> get foodsHistory => _foodsHistory.toList();

  void addFoodToHistory(Food food) {
    _foodsHistory.addLast(food);
    notifyListeners();
  }

  void _onFoodSearchChange() {
    final currentTerm = di.get<FoodSearchManager>().currentTerm;
    if (currentTerm.isNotEmpty) {
      _searchTermHistory.addLast(currentTerm);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _foodsHistory.clear();
    notifyListeners();
  }
}
