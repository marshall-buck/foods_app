import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

/// Used for Food or nutrient amounts
///                     amount,  amount, unit
typedef AmountRecord = (double, String, String);

class Food extends Equatable {
  const Food({
    required this.id,
    required this.name,
    required this.defaultAmount,
    required this.unit,
    required this.amountMap,
  });

  factory Food.fromFoodDTO(FoodDTO food, Map<int, AmountRecord> amountMap) {
    return Food(
      id: food.id,
      name: food.description,
      defaultAmount: MagicNumbers.defaultFoodAmount,
      unit: 'g',
      amountMap: amountMap,
    );
  }

  final int id;
  final String name;
  final double defaultAmount;
  final String unit;

  final Map<int, AmountRecord> amountMap;

  Food copyWith({
    int? id,
    String? name,
    double? defaultAmount,
    String? unit,
    Map<int, AmountRecord>? amountMap,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      unit: unit ?? this.unit,
      amountMap: amountMap ?? this.amountMap,
    );
  }

  double foodAmount(double modifier) => defaultAmount * modifier;
  double nutrientAmount(double modifier, int nutrientId) => (amountMap[nutrientId]?.$1 ?? 0) * modifier;

  String getNutrientUnit(int nutrientId) => amountMap[nutrientId]?.$3 ?? '';

  @override
  List<Object?> get props => [id, name, defaultAmount, unit, amountMap];
}
