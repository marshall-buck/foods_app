part of 'adjust_amount_bloc.dart';

sealed class AdjustAmountState extends Equatable {
  const AdjustAmountState();
  
  @override
  List<Object> get props => [];
}

final class AdjustAmountInitial extends AdjustAmountState {}
