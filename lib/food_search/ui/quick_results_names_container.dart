import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_search/food_search.dart';

class QuickResultsNamesContainer extends StatelessWidget {
  const QuickResultsNamesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      buildWhen: (previous, current) => previous.quickSearchIds != current.quickSearchIds,
      builder: (context, state) {
        log('state.quickSearchNames: ${state.quickSearchNames}');
        return Row(
          children: state.quickSearchNames.map((quickResult) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                quickResult,
                style: AppTextStyle.m3LabelSmall.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
