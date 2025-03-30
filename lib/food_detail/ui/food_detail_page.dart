import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

import 'package:foods_app/food_detail/food_detail.dart';
import 'package:foods_app/food_detail/ui/food_description_cards.dart';

/// {@template food_detail_page}
/// A page that displays detailed information about  food item(s).
///
/// This page uses a [FoodDetailBloc] to fetch and manage the state of food details.
/// {@endtemplate}
class FoodDetailPage extends StatelessWidget {
  /// {@macro food_detail_page}
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodDetailBloc(
        activeFoods: RepositoryProvider.of<ActiveFoods>(context),
      )..add(FetchFoodDetailEvent()),
      child: const FoodDetailView(),
    );
  }
}

/// {@template food_detail_view}
/// A view that renders the UI for the food detail page.
///
/// Displays food details and handles different states such as success or error.
/// {@endtemplate}
class FoodDetailView extends StatelessWidget {
  /// {@macro food_detail_view}
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Food Detail'),
          centerTitle: true,
        ),
        body: BlocBuilder<FoodDetailBloc, FoodDetailState>(
          buildWhen: (previous, current) => previous.foods != current.foods,
          builder: (context, state) {
            switch (state.status) {
              case FoodDetailStatus.success:
                return ResponsivePanes(
                  foodsPane: FoodDescriptionCards(
                    foods: state.foodsList,
                  ),
                  nutrientsPane: const SizedBox(height: 300, child: NutrientCompareCards()),
                );

              case FoodDetailStatus.error: //TODO: Create error dialogue.
                return const Center(
                  child: Text('An error occurred. Please try again.'),
                );
              case null:
                return const Center(
                  child: Text('Null error.'),
                );
            }
          },
        ),
      ),
    );
  }
}
