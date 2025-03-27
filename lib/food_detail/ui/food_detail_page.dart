import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

import 'package:foods_app/food_detail/food_detail.dart';
import 'package:foods_app/food_detail/ui/food_description_cards.dart';

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodDetailBloc(
        activeFoods: RepositoryProvider.of<ActiveFoods>(context),
        // localFoodsDBRepo: RepositoryProvider.of<LocalFoodsDBRepo>(context),
      )..add(FetchFoodDetailEvent()),
      child: const FoodDetailView(),
    );
  }
}

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: BlocBuilder<FoodDetailBloc, FoodDetailState>(
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

              case FoodDetailStatus.error:
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
