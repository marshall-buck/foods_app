import 'dart:collection';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

/// The source of truth showing the history of user interactions
/// throut the app.
///
/// For example the history of recent foods clicked.
class AppHistoryState {
  static int maxHistory = MagicNumbers.defaultSearchHistory;

  // Will always insert most recent id as addLast.
  final _foodsHistory = Queue<int?>();
  final _searchTermHistory = Queue<String?>();

  int? get lastFood => _foodsHistory.last;
  String? get lastTerm => _searchTermHistory.last;

  Queue<String?> get searchTermHistory => _searchTermHistory;

  Queue<int?> get foodsHistory => _foodsHistory;

  void addFoodToHistory(Food? food) {
    _trimHistory();
    if (food != null) {
      _foodsHistory.addLast(food.id);
    }
  }

  void addTermToHistory(String term) {
    _trimHistory();
    _searchTermHistory.addLast(term);
  }

  /// Keeps the Queue a max length.
  void _trimHistory() {
    if (_foodsHistory.length == maxHistory) {
      _foodsHistory.removeFirst();
    }
    if (_searchTermHistory.length == maxHistory) {
      _searchTermHistory.removeFirst();
    }
  }

  void clearAll() {
    _searchTermHistory.clear();
    _foodsHistory.clear();
  }
}
