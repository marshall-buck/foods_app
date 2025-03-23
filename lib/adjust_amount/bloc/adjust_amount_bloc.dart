import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adjust_amount_event.dart';
part 'adjust_amount_state.dart';

class AdjustAmountBloc extends Bloc<AdjustAmountEvent, AdjustAmountState> {
  AdjustAmountBloc() : super(AdjustAmountInitial()) {
    on<AdjustAmountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
