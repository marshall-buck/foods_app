import 'package:equatable/equatable.dart';
import 'package:foods_app/common/magic.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodListItemModel extends Equatable {
  const FoodListItemModel({
    required this.id,
    required this.description,
    required this.quickResultsList,
  });

  static Future<FoodListItemModel> fromFoodDTO(
    FoodDTO food,
  ) async {
    final quickResultsList = await _quickSearchNutrientAmounts(food);
    return FoodListItemModel(
      id: food.id,
      description: food.description,
      quickResultsList: quickResultsList,
    );
  }

  final int id;
  final String description;
  final List<String> quickResultsList;

  static Future<List<String>> _quickSearchNutrientAmounts(FoodDTO food) async {
    // ignore: strict_raw_type
    final prefs = di.get<PreferencesService>(
      instanceName: LocatorName.sharedPrefsService,
    );
    final quickPrefs = await prefs.getQuickSearchAmounts();
    final nutrients = food.nutrients;
    final matches = <String>[];
    for (final string in quickPrefs) {
      final id = int.parse(string);

      if (nutrients.containsKey(id)) {
        matches.add(nutrients[id].toString());
      } else {
        matches.add('0');
      }
    }

    return matches;
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [description, quickResultsList];
}
