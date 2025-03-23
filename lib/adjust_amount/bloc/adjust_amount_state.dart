part of 'adjust_amount_bloc.dart';

final class AdjustAmountState extends Equatable {
  const AdjustAmountState({required this.modifier});

  final double modifier;

  @override
  List<Object> get props => [modifier];
}
