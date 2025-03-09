import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

import 'package:foods_app/food_detail/ui/ui.dart';

//

class NutrientCompareCards extends StatelessWidget {
  const NutrientCompareCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodDetailBloc, FoodDetailState>(
      builder: (context, state) {
        final nutrientIds = state.allNutrientIdsInQ?.toList();
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return NutrientCompareCard(nutrientId: nutrientIds![index]!);
          },
        );
      },
    );
  }
}
