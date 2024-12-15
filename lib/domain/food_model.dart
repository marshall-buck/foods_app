import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/services/services.dart';

// TODO: check if Nutrient map is needed
// (double amount, formatted amount to display, unit String)
typedef AmountRecord = (double, String, String);

class Food extends Equatable {
  const Food({
    required this.id,
    required this.description,
    required this.nutrientMap,
    required this.nutrientList,
    required this.foodAmount,
  });
  factory Food.fromFoodDTO(FoodDTO food) {
    final nutrientMap = <int, Nutrient>{};
    final nutrientList = <Nutrient>[];

    for (final entry in food.nutrients.entries) {
      final nutrient = Nutrient.fromMapEntry(entry);
      nutrientMap[entry.key] = nutrient;
      nutrientList.add(nutrient);
    }
    return Food(
      id: food.id,
      description: food.description,
      nutrientMap: nutrientMap,
      nutrientList: nutrientList,
      foodAmount: MagicNumbers.defaultFoodAmount,
    );
  }
  final int id;

  final String description;

  final Map<int, Nutrient> nutrientMap;
  final List<Nutrient> nutrientList;

  final double foodAmount;

  /// Creates {id: [AmountRecord]}
  /// where id is the id of the nutrient or food item.
  Map<int, AmountRecord> createAmountStrings() {
    final adjustedNutrientAmounts = <int, AmountRecord>{};
    final adjustedFoodAmount = <int, AmountRecord>{};
    adjustedFoodAmount[id] =
        (foodAmount, convertAmountToString(foodAmount), 'g');

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

  // static String convertAmountToString(double amount) {

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
  }) {
    return Food(
      id: id ?? this.id,
      description: description ?? this.description,
      foodAmount: foodAmount ?? this.foodAmount,
      nutrientMap: nutrientMap ?? this.nutrientMap,
      nutrientList: nutrientList ?? this.nutrientList,
    );
  }

  @override
  List<Object?> get props => [id, description, foodAmount, nutrientList];
}

class Nutrient extends Equatable {
  const Nutrient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  /// Creates a [Nutrient] instance from a MapEntry<int, double> object.
  factory Nutrient.fromMapEntry(MapEntry<int, double> entry) {
    final id = entry.key;
    final amount = entry.value;
    return Nutrient(
      id: id,
      name: NutrientDTO.originalNutrientTableEdit[id]?['name'] ?? '',
      amount: amount,
      unit: NutrientDTO.originalNutrientTableEdit[id]?['unit'] ?? '',
    );
  }

  final int id;
  final String name;
  final double amount;
  final String unit;

  Nutrient copyWith({
    int? id,
    String? name,
    double? amount,
    String? unit,
  }) {
    return Nutrient(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [id, name, amount, unit];
}
