import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';

part 'edit_amount_event.dart';
part 'edit_amount_state.dart';

class EditAmountBloc extends Bloc<EditAmountEvent, EditAmountState> {
  EditAmountBloc() : super(EditAmountInitial()) {
    on<EditAmountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
