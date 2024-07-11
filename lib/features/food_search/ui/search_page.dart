import 'package:flutter/material.dart';

import 'package:foods_app/external_data/external_services_B.dart';
import 'package:usda_db_package/usda_db_package.dart';

//  List<FoodListItem>? foods =
//         watchValue((FoodSearchManager x) => x.currentResults);

const protein =
    SrLegacyNutrientModel(id: 1003, amount: 20, unit: 'g', name: 'Protein');
const totalFat =
    SrLegacyNutrientModel(id: 1004, amount: 15, unit: 'g', name: 'Total Fat');
const totalCarbs = SrLegacyNutrientModel(
    id: 1005, amount: 30, unit: 'g', name: 'Total Carbohydrates');
const water =
    SrLegacyNutrientModel(id: 1051, amount: 500, unit: 'g', name: 'Water');
const totalSugars = SrLegacyNutrientModel(
    id: 2000, amount: 10, unit: 'g', name: 'Total Sugars');
const food1 = SrLegacyFoodModel(
    id: 1, description: 'Chicken Breast', nutrients: [protein]);
const food2 = SrLegacyFoodModel(
    id: 2, description: 'Apple', nutrients: [totalCarbs, water]);
const food3 =
    SrLegacyFoodModel(id: 3, description: 'Olive Oil', nutrients: [totalFat]);
const food4 = SrLegacyFoodModel(
    id: 4, description: 'Yogurt', nutrients: [protein, totalCarbs, water]);
const food5 = SrLegacyFoodModel(
    id: 5, description: 'Granola Bar', nutrients: [totalCarbs, totalSugars]);

class SearchPage extends StatelessWidget {
  final List<FoodModel> _mockFoodsList = [
    FoodModel.fromUsdaDB(food1),
    FoodModel.fromUsdaDB(food2),
    FoodModel.fromUsdaDB(food3),
    FoodModel.fromUsdaDB(food4),
    FoodModel.fromUsdaDB(food5),
  ];

  static String _displayStringForOption(FoodModel option) => option.description;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<FoodModel>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return [];
        }
        return _mockFoodsList.where((FoodModel option) {
          return option.description
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              final des = options.elementAtOrNull(index)!.description;
              return ListTile(
                title: Text(des),
              );
            });
      },
      onSelected: (FoodModel selection) {
        print('You just selected ${selection.description}');
      },
    );
  }
}
