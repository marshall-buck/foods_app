import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';

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
