// import 'dart:collection';

// import 'package:equatable/equatable.dart';

// import 'package:foods_app/domain/domain.dart';

// class Foods extends Equatable {
//   const Foods({required List<Food> foods}) : _foods = foods;

//   final List<Food> _foods;

//   Set<int> createNutrientAmountRecordsSet() => _foods.expand((food) => food.nutrientMap.keys).toSet();

//   void resetToOriginalAmounts() {
//     for (final food in _foods) {
//       food.copyWith(amountStrings: food.createAmountStrings());
//     }
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
