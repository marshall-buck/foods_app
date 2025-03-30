import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

/// {@template amount_holder}
/// A holder for an amount and its unit string.
/// This can be either a nutrient of a food.
/// {@endtemplate}
class AmountHolder extends Equatable {
  /// {@macro amount_holder}
  const AmountHolder({
    required this.amount,
    required this.unitString,
  });

  /// The amount of the nutrient.
  final double amount;

  /// The unit of the nutrient amount.
  final String unitString;

  /// Creates a copy of this [AmountHolder] with optional new values.
  AmountHolder copyWith({
    double? amount,
    String? unitString,
  }) {
    return AmountHolder(
      amount: amount ?? this.amount,
      unitString: unitString ?? this.unitString,
    );
  }

  /// Converts the amount to a formatted string representation.
  String get amountString => amount.convertAmountToString();

  @override
  List<Object?> get props => [amount, amountString, unitString];
}

/// {@template food}
/// A model representing a food item with its nutrient data.
/// {@endtemplate}
class Food extends Equatable {
  /// {@macro food}
  const Food({
    required this.id,
    required this.name,
    required this.defaultAmount,
    required this.unit,
    required this.amountMap,
  });

  /// Creates a [Food] instance from a [FoodDTO] and a nutrient amount map.
  factory Food.fromFoodDTO(FoodDTO food, Map<int, AmountHolder> amountMap) {
    return Food(
      id: food.id,
      name: food.description,
      defaultAmount: MagicNumbers.defaultFoodAmount,
      unit: 'g',
      amountMap: amountMap,
    );
  }

  /// The unique identifier of the food.
  final int id;

  /// The name or description of the food.
  final String name;

  /// The default amount of the food.
  final double defaultAmount;

  /// The unit of the default amount.
  final String unit;

  /// A map of nutrient IDs to their corresponding [AmountHolder].
  final Map<int, AmountHolder> amountMap;

  /// Creates a copy of this [Food] with optional new values.
  Food copyWith({
    int? id,
    String? name,
    double? defaultAmount,
    String? unit,
    Map<int, AmountHolder>? amountMap,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      unit: unit ?? this.unit,
      amountMap: amountMap ?? this.amountMap,
    );
  }

  /// Retrieves the nutrient amount for a given [nutrientId].
  double nutrientAmount(int nutrientId) => amountMap[nutrientId]?.amount ?? 0;

  /// Retrieves the unit of the nutrient for a given [nutrientId].
  String getNutrientUnit(int nutrientId) => amountMap[nutrientId]?.unitString ?? '';

  @override
  List<Object?> get props => [id, name, defaultAmount, unit, amountMap];
}
