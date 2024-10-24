import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/services/services.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchManager {
  final currentResults = ValueNotifier<List<FoodListItemModel?>>([]);

  final searchQueryString = ValueNotifier<String>('');

  // ignore: use_setters_to_change_properties
  void updateSearch(String string) => searchQueryString.value = string;

  void clearSearchTerm() => searchQueryString.value = '';

  Future<void> queryFoods() async {
    final db =
        await di.getAsync<FoodsDB>(instanceName: LocatorName.foodsDBService);

    final foods = await db.queryFoods(searchTerm: searchQueryString.value);

    if (foods.isNotEmpty) {
      final newItems = <FoodListItemModel?>[];
      for (final food in foods) {
        newItems.add(await FoodListItemModel.fromFoodDTO(food!));
      }
      currentResults.value = newItems;
    } else {
      currentResults.value = [];
    }
    dev.log('FoodSearchREsults.length: ${currentResults.value.length}',
        time: DateTime.now(), name: 'FoodSearchManager.queryFoods()');
  }

  void clearSearch() {
    clearSearchTerm();
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

  // ignore: use_setters_to_change_properties
  void setOpacity(double value) => opacity.value = value;

  void dispose() {
    quickSearchNames.dispose();
  }
}
