import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/user_preferences/user_preferences.dart';

class QuickResultsNamesContainer extends StatelessWidget {
  const QuickResultsNamesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quickResults = context.select<UserPreferencesBloc, List<String>>(
      (bloc) => bloc.state.quickSearchIds,
    );
    return Row(
      children: quickResults.map((quickResult) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            quickResult,
            style: AppTextStyle.m3LabelSmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }).toList(),
    );
  }
}

  // return Row(
  //         children: quickResultsList.map((quickResult) {
  //           return Padding(
  //             padding: const EdgeInsets.only(right: 16),
  //             child: Text(
  //               quickResult,
  //               style: AppTextStyle.m3LabelSmall.copyWith(
  //                 color: Theme.of(context).colorScheme.onSurfaceVariant,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
