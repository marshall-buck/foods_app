part of 'adjust_amount_bloc.dart';

final class AdjustAmountEvent extends Equatable {
  const AdjustAmountEvent({required this.add});
  final bool add;
  @override
  List<Object> get props => [add];
}
