import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_detail_event.dart';
part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc() : super(FoodDetailInitial()) {
    on<FoodDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
