import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/models/models.dart';

class Food extends AdjustableItem {
  const Food({
    required super.id,
    required super.name,
    required super.defaultAmount,
    required super.unit,
    required this.amountMap,
  });

  factory Food.fromFoodDAO(FoodDAO food, Map<int, AmountRecord> amountMap) {
    return Food(
      id: food.id,
      name: food.description,
      defaultAmount: MagicNumbers.defaultFoodAmount,
      unit: 'g',
      amountMap: amountMap,
    );
  }

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

  @override
  List<Object?> get props => super.props..add(amountMap);
}

// class _Nutrient extends AdjustableItem {
//   const _Nutrient({
//     required super.id,
//     required super.defaultAmount,
//     required super.unit,
//     required super.name,
//   });

//   /// Creates a [_Nutrient] instance from a `MapEntry<int, double>` object.
//   factory _Nutrient.fromMapEntry(MapEntry<int, double> entry) {
//     final id = entry.key;
//     final defaultAmount = entry.value;
//     return _Nutrient(
//       id: id,
//       name: NutrientDAO.originalNutrientTableEdit[id]?['name'] ?? '',
//       defaultAmount: defaultAmount,
//       unit: NutrientDAO.originalNutrientTableEdit[id]?['unit'] ?? '',
//     );
//   }

//   _Nutrient copyWith({
//     int? id,
//     String? name,
//     double? defaultAmount,
//     String? unit,
//     double? modifier,
//   }) {
//     return _Nutrient(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       defaultAmount: defaultAmount ?? 1,
//       unit: unit ?? this.unit,
//     );
//   }
// }

  // /// A [List] of all [Nutrient]'s in the [Food].
  // List<Nutrient> get nutrientList => nutrientMap.values.toList();

  /// Each entry key is an [id] of both the [Food] and all [_Nutrient]s.
  /// Created for ease of use when adjusting the amounts in the ui.
  /// The amount's are multiplied by a [modifier] for saved food amounts.
  // Map<int, AmountRecord> get amountRecordsMap {
  //   final adjustedFoodAmount = <int, AmountRecord>{
  //     id: (MagicNumbers.defaultFoodAmount * modifier, MagicNumbers.defaultFoodAmount.convertAmountToString(), 'g'),
  //   };
  //   final adjustedNutrientAmounts = <int, AmountRecord>{};
  //   for (final nutrient in nutrientMap.values.toList()) {
  //     final amount = nutrient.amount * modifier;
  //     final unit = nutrient.unit;
  //     final displayString = amount.convertAmountToString();
  //     adjustedNutrientAmounts[nutrient.id] = (nutrient.amount, displayString, unit);
  //   }

  //   return {
  //     ...adjustedFoodAmount,
  //     ...adjustedNutrientAmounts,
  //   };
  // }
