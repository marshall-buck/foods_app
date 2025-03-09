part of 'edit_amount_bloc.dart';

sealed class EditAmountState extends Equatable {
  const EditAmountState();
  
  @override
  List<Object> get props => [];
}

final class EditAmountInitial extends EditAmountState {}
