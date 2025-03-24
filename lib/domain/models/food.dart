import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

class AmountHolder extends Equatable {
  const AmountHolder({
    required this.amount,
    required this.unitString,
  });

  final double amount;

  final String unitString;

  AmountHolder copyWith({
    double? amount,
    String? unitString,
  }) {
    return AmountHolder(
      amount: amount ?? this.amount,
      unitString: unitString ?? this.unitString,
    );
  }

  String get amountString => amount.convertAmountToString();

  @override
  List<Object?> get props => [amount, amountString, unitString];
}

class Food extends Equatable {
  const Food({
    required this.id,
    required this.name,
    required this.defaultAmount,
    required this.unit,
    required this.amountMap,
  });

  factory Food.fromFoodDTO(FoodDTO food, Map<int, AmountHolder> amountMap) {
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

  final Map<int, AmountHolder> amountMap;

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

  double nutrientAmount(int nutrientId) => amountMap[nutrientId]?.amount ?? 0;

  String getNutrientUnit(int nutrientId) => amountMap[nutrientId]?.unitString ?? '';

  @override
  List<Object?> get props => [id, name, defaultAmount, unit, amountMap];
}
