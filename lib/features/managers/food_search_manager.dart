import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/services/services.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchManager extends ChangeNotifier {
  List<FoodListItemModel?> _currentResults = [];

  List<FoodListItemModel?> get currentResults => _currentResults;

  int get resultsCount => _currentResults.length;

  bool get hasResults => _currentResults.isNotEmpty;

  Future<void> queryFoods(String string) async {
    try {
      final db = await di.getAsync<FoodsDB>(
        instanceName: LocatorInstanceNames.foodsDBService,
      );

      final foods = await db.queryFoods(searchTerm: string);

      if (foods.isNotEmpty) {
        final newItems = <FoodListItemModel?>[];
        for (final food in foods) {
          newItems.add(await FoodListItemModel.fromFoodDTO(food!));
        }
        _currentResults = newItems;
      } else {
        _currentResults = [];
      }
    } catch (e) {
      dev.log(
        'error',
        time: DateTime.now(),
        name: 'FoodSearchManager.queryFoods()',
        error: e,
      );
      _currentResults = [];
    } finally {
      dev.log(
        'FoodSearchResults.length: ${_currentResults.length}',
        time: DateTime.now(),
        name: 'FoodSearchManager.queryFoods()',
      );
      notifyListeners();
    }
  }

  void clearSearch() {
    _currentResults = [];
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    notifyListeners();
  }
}
