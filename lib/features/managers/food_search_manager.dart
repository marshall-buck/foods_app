import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/services/services.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchManager {
  final currentResults = ValueNotifier<List<FoodListItemModel?>>([]);

  bool _isFirstSearch = true;

  bool get isFirstSearch => _isFirstSearch;

  Future<void> queryFoods(String string) async {
    _isFirstSearch = false;

    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);

    final foods = await db.queryFoods(searchTerm: string);

    if (foods.isNotEmpty) {
      final newItems = <FoodListItemModel?>[];
      for (final food in foods) {
        newItems.add(await FoodListItemModel.fromFoodDTO(food!));
      }
      currentResults.value = newItems;
    } else {
      currentResults.value = [];
    }
    dev.log('FoodSearchResults.length: ${currentResults.value.length}',
        time: DateTime.now(), name: 'FoodSearchManager.queryFoods()');
  }

  void clearSearch() {
    currentResults.value = [];
  }

  void dispose() {
    currentResults.dispose();
  }
}

class QuickSearchManager {
  final quickSearchNames = ValueNotifier<List<String>>([]);
  final opacity = ValueNotifier<double>(0);

  Future<void> init() async {
    await getNames();
  }

  Future<void> getNames() async {
    // ignore: strict_raw_type
    final prefs = await di.getAsync<PreferencesService>(
      instanceName: LocatorName.sharedPrefsService,
    );
    final quick = await prefs.getQuickSearchAmounts();
    final names = quick
        .map((id) {
          return NutrientDTO.originalNutrientTableEdit[int.parse(id)]!['name']!;
        })
        .toList()
        .reversed
        .toList();

    quickSearchNames.value = names;
  }

  void dispose() {
    quickSearchNames.dispose();
  }
}
