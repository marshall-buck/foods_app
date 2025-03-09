import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

import 'package:foods_app/food_detail/ui/ui.dart';

class NutrientCompareCard extends StatelessWidget {
  const NutrientCompareCard({required this.nutrientId, super.key});

  final int nutrientId;
  @override
  Widget build(BuildContext context) {
    final foods = context.read<FoodDetailState>().foodsList;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
      ),
      child: Column(
        children: [
          const AutoHyphenatingText('asdf'),
          Row(
            children: foods!
                .map(
                  (e) => AmountWidget(
                    textColor: Theme.of(context).colorScheme.onSurface,
                    amount: e!.amountMap[nutrientId]!.$1,
                    unit: e.amountMap[nutrientId]!.$2,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );

    //
  }
}
