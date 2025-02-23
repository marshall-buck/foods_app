import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/models/models.dart';

// TODO: check if Nutrient map is needed
// (<double> amount, <String> formatted amount to display, <String> unit)
typedef AmountRecord = (double, String, String);

class Food extends Equatable {
  const Food({
    required this.id,
    required this.description,
    required this.nutrientMap,
    required this.nutrientList,
    required this.foodAmount,
    required this.amountStrings,
  });
  factory Food.fromFoodDAO(FoodDAO food) {
    final nutrientMap = <int, Nutrient>{};
    final nutrientList = <Nutrient>[];

    final adjustedFoodAmount = <int, AmountRecord>{
      food.id: (
        MagicNumbers.defaultFoodAmount,
        convertAmountToString(
          MagicNumbers.defaultFoodAmount,
        ),
        'g'
      ),
    };

    final adjustedNutrientAmounts = <int, AmountRecord>{};
    for (final entry in food.nutrients.entries) {
      final nutrient = Nutrient.fromMapEntry(entry);
      nutrientMap[entry.key] = nutrient;
      nutrientList.add(nutrient);
      final amount = nutrient.amount;
      final unit = nutrient.unit;
      final displayString = convertAmountToString(amount);
      adjustedNutrientAmounts[nutrient.id] = (nutrient.amount, displayString, unit);
    }

    return Food(
      id: food.id,
      description: food.description,
      nutrientMap: nutrientMap,
      nutrientList: nutrientList,
      foodAmount: MagicNumbers.defaultFoodAmount,
      amountStrings: {
        ...adjustedFoodAmount,
        ...adjustedNutrientAmounts,
      },
    );
  }
  final int id;

  final String description;

  final Map<int, Nutrient> nutrientMap;
  final List<Nutrient> nutrientList;

  final double foodAmount;

  final Map<int, AmountRecord> amountStrings;

  /// Creates {id: [AmountRecord]} where id is the id of the nutrient or food item.
  Map<int, AmountRecord> createAmountStrings() {
    final adjustedNutrientAmounts = <int, AmountRecord>{};
    final adjustedFoodAmount = <int, AmountRecord>{};
    adjustedFoodAmount[id] = (foodAmount, convertAmountToString(foodAmount), 'g');

    for (final item in nutrientList) {
      final amount = item.amount;
      final unit = item.unit;
      final displayString = convertAmountToString(amount);
      adjustedNutrientAmounts[item.id] = (item.amount, displayString, unit);
    }
    return {
      ...adjustedFoodAmount,
      ...adjustedNutrientAmounts,
    };
  }

  static String convertAmountToString(double amount) {
    if (amount >= 50) {
      return amount.toStringAsFixed(0);
    } else if (amount >= 10) {
      return amount.toStringAsFixed(1);
    } else if (amount >= 1) {
      return amount.toStringAsFixed(2);
    } else {
      return amount.toStringAsFixed(3);
    }
  }

  Food copyWith({
    int? id,
    String? description,
    double? foodAmount,
    Map<int, Nutrient>? nutrientMap,
    List<Nutrient>? nutrientList,
    Map<int, AmountRecord>? amountStrings,
  }) {
    return Food(
      id: id ?? this.id,
      description: description ?? this.description,
      foodAmount: foodAmount ?? this.foodAmount,
      nutrientMap: nutrientMap ?? this.nutrientMap,
      nutrientList: nutrientList ?? this.nutrientList,
      amountStrings: amountStrings ?? this.amountStrings,
    );
  }

  @override
  List<Object?> get props => [id, description, foodAmount, nutrientList];
}
