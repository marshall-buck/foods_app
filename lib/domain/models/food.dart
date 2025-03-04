import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/models/models.dart';

/// A [Record] to hold an amount of a [Food] item or [Nutrient] item.
///  ([double] amount, [String] formatted amount to display, [String] unit).
typedef AmountRecord = (double, String, String);

class Food extends Equatable {
  const Food({
    required this.id,
    required this.description,
    required this.nutrientMap,
    required this.foodAmount,
    required this.modifier,
  });

  factory Food.fromFoodDAO(FoodDAO food) {
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
      foodAmount: MagicNumbers.defaultFoodAmount,
      modifier: 1,
    );
  }

  /// DB id of the Food item.
  final int id;

  /// Full description of the food from the DB.
  final String description;

  /// A [Map] of all the nutrients in the food where the [int] key is the id of the nutrient from the DB.
  /// And the [Nutrient] is the domain [Nutrient] model.
  final Map<int, Nutrient> nutrientMap;

  /// The amount of the food, defaults to 100g.
  final double foodAmount;

  final double modifier;

  /// A [List] of all [Nutrient]'s in the [Food].
  List<Nutrient> get nutrientList => nutrientMap.values.toList();

  /// Each entry key is an [id] of both the [Food] and all [Nutrient]s.
  /// Created for ease of use when adjusting the amounts in the ui.
  /// The amount's are multiplied by a [modifier] for saved food amounts.
  Map<int, AmountRecord> get amountRecordsMap {
    final adjustedFoodAmount = <int, AmountRecord>{
      id: (
        MagicNumbers.defaultFoodAmount * modifier,
        _convertAmountToString(
          MagicNumbers.defaultFoodAmount,
        ),
        'g'
      ),
    };
    final adjustedNutrientAmounts = <int, AmountRecord>{};
    for (final nutrient in nutrientList) {
      final amount = nutrient.amount * modifier;
      final unit = nutrient.unit;
      final displayString = _convertAmountToString(amount);
      adjustedNutrientAmounts[nutrient.id] = (nutrient.amount, displayString, unit);
    }

    return {
      ...adjustedFoodAmount,
      ...adjustedNutrientAmounts,
    };
  }

  static String _convertAmountToString(double amount) {
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

  Food copyWith({int? id, String? description, double? foodAmount, Map<int, Nutrient>? nutrientMap, double? modifier}) {
    return Food(
      id: id ?? this.id,
      description: description ?? this.description,
      foodAmount: foodAmount ?? this.foodAmount,
      nutrientMap: nutrientMap ?? this.nutrientMap,
      modifier: modifier ?? this.modifier,
    );
  }

  @override
  List<Object?> get props => [id, description, foodAmount, nutrientMap, modifier];
}

//
