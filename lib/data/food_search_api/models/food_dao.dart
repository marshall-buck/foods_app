import 'package:equatable/equatable.dart';

import 'package:usda_db_package/usda_db_package.dart';

//TODO: Integrate external api factory's here

/// A class that represents the data for a food object.
/// The purpose is to convert the api data into a base data class for the domain layer to use.
///
/// The [FoodDAO] class is initialized by providing the food's
/// [id], [description], and [nutrients].
///

class FoodDAO extends Equatable {
  const FoodDAO({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  /// Creates a [FoodDAO] instance from the local Usda DB [FoodDTO] object.
  factory FoodDAO.fromUsdaDB(FoodDTO food) {
    return FoodDAO(
      id: food.id,
      description: food.description,
      nutrients: food.nutrients,
    );
  }
  final int id;
  final String description;
  final Map<int, double> nutrients;

  @override
  List<Object?> get props => [id, description, nutrients];

  @override
  bool get stringify => true;
}
