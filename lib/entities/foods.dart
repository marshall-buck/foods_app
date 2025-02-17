import 'package:equatable/equatable.dart';
import 'package:foods_app/entities/entities.dart';

class Foods extends Equatable {
  const Foods({required this.foods});
  final List<Food> foods;
  @override
  List<Object?> get props => [foods];
}
