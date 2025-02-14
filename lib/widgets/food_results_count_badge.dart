import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/food_search/food_search.dart';

class FoodResultsCountBadge extends StatelessWidget {
  const FoodResultsCountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        if (state is FoodSearchSuccessState) {
          return Badge.count(
            count: state.foods.length,
            backgroundColor: Colors.transparent,
            textColor: Theme.of(context).colorScheme.onSurface,
            // padding: const EdgeInsets.only(right: 8),
          );
        } else {
          return Container(); // or any other placeholder widget
        }
      },
    );
  }
}
