// import 'dart:collection';

// import 'package:equatable/equatable.dart';
// import 'package:foods_app/data/data.dart';
// import 'package:foods_app/domain/models/models.dart';

// class Foods extends Equatable {
//   const Foods(this.foods);

//   factory Foods.empty() => Foods(Queue<Food>());
//   final Queue<Food?> foods;

//   void add(FoodDAO food) {
//     final convertedFood = Food.fromFoodDAO(food);

//     foods.addLast(convertedFood);
//   }

//   void removeFood(Food food) {
//     if (foods.isEmpty) return;
//     foods.removeWhere((e) => e!.id == food.id);
//   }

//   void clear() {
//     foods.clear();
//   }

//   void resetToOriginalAmounts() {
//     for (final food in foods) {
//       food!.copyWith(amountStrings: food.createAmountStrings());
//     }
//   }

//   Food? get lastEntered => foods.isNotEmpty ? foods.last : null;

//   Food? get firstEntered => foods.isNotEmpty ? foods.first : null;

//   @override
//   // TODO: implement props
//   List<Object?> get props => [foods];
// }
