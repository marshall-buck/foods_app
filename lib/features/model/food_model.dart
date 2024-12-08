import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/services/services.dart';

// TODO: check if Nutrient map is needed
// (double amount, formatted amount to display, units)
typedef AmountRecord = (num, String, String);

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
      foodAmount: defaultFoodAmount,
    );
  }
  final int id;

  final String description;

  final Map<int, Nutrient> nutrientMap;
  final List<Nutrient> nutrientList;

  final num foodAmount;

  Future<Map<num, AmountRecord>> createAmountStrings() async {
    final adjustedNutrientAmounts = <num, AmountRecord>{};
    final adjustedFoodAmount = <num, AmountRecord>{};
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

  static String convertAmountToString(num amount) {
    if (amount >= 50) {
      return amount.toStringAsFixed(0);
    }
    if (amount < 50 && amount >= 10) {
      return amount.toStringAsFixed(1);
    }
    if (amount < 10 && amount >= 1) {
      return amount.toStringAsFixed(2);
    }
    return amount.toStringAsFixed(3);
  }

  Food copyWith({
    int? id,
    String? description,
    num? foodAmount,
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

  /// Creates a [Nutrient] instance from a MapEntry<int, num> object.
  factory Nutrient.fromMapEntry(MapEntry<int, num> entry) {
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
  final num amount;
  final String unit;

  Nutrient copyWith({
    int? id,
    String? name,
    num? amount,
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
