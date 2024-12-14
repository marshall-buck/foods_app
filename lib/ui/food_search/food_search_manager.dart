import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/services/services.dart';

import 'package:watch_it/watch_it.dart';

//TODO: add queryFood to this class
/// Manages the searching of foods by a search term.
class FoodSearchManager extends ChangeNotifier {
  List<FoodListItemModel?> _currentResults = [];

  List<FoodListItemModel?> get currentResults => _currentResults;

  int get resultsCount => _currentResults.length;

  bool get hasResults => _currentResults.isNotEmpty;

  Future<void> queryFoods(String string) async {
    di.get<AppHistoryState>().addTermToHistory(string);
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
        name: 'FoodSearchVM.queryFoods()',
        error: e,
      );
      _currentResults = [];
    } finally {
      dev.log(
        'FoodSearchResults.length: ${_currentResults.length}',
        time: DateTime.now(),
        name: 'FoodSearchVM.queryFoods()',
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

class QuickSearchManager extends ChangeNotifier {
  List<String> _quickSearchNames = [];

  List<String> get quickSearchNames => _quickSearchNames;

  Future<void> init() async {
    await getNames();
  }

  Future<void> getNames() async {
    try {
      // ignore: strict_raw_type
      final prefs = await di.getAsync<PreferencesService>(
        instanceName: LocatorInstanceNames.sharedPrefsService,
      );
      final quick = await prefs.getQuickSearchAmounts();
      final names = quick
          .map((id) {
            return NutrientDTO
                .originalNutrientTableEdit[int.parse(id)]!['name']!;
          })
          .toList()
          .reversed
          .toList();

      _quickSearchNames = names;
      notifyListeners();
    } catch (e) {
      dev.log(
        'error',
        time: DateTime.now(),
        name: 'QuickSearchManager.getNames()',
        error: e,
      );
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    notifyListeners();
  }
}
