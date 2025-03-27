import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';

part 'adjust_amount_event.dart';
part 'adjust_amount_state.dart';

class AdjustAmountBloc extends Bloc<AdjustAmountEvent, AdjustAmountState> {
  AdjustAmountBloc({
    required ActiveFoods activeFoods,
  })  : _activeFoods = activeFoods,
        super(AdjustAmountState(modifier: activeFoods.activeModifier)) {
    on<AdjustAmountEvent>(_changeUnits);
  }
  final ActiveFoods _activeFoods;

  /// A base percentage to change the modifier.
  static const circularRangeFinderPercentChange = .05;

  /// This is called in the CircularRangeSlider when the user rotates the handle.
  void _changeUnits(AdjustAmountEvent event, Emitter<AdjustAmountState> emit) {
    // log('_activeFoods.activeModifier before: ${_activeFoods.activeModifier}');
    final currentModifier = _activeFoods.activeModifier;

    final percentage = event.add == true
        ? (1 + (circularRangeFinderPercentChange / 100))
        : (1 - (circularRangeFinderPercentChange / 100));
    _activeFoods.changeModifier(percentage * currentModifier);
    emit(AdjustAmountState(modifier: _activeFoods.activeModifier));

    // log('_activeFoods.activeModifier after: ${_activeFoods.activeModifier}');
  }
}
