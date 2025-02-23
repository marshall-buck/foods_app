import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/data/data.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';
import 'package:foods_app/food_detail/ui/ui.dart';

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFoods = RepositoryProvider.of<ActiveFoods>(context);
    final localFoodsDB = RepositoryProvider.of<LocalFoodsDBRepo>(context);
    return BlocProvider(
      create: (BuildContext context) => FoodDetailBloc(activeFoods: activeFoods, localFoodsDBRepo: localFoodsDB),
      child: const FoodDetailView(),
    );
  }
}

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key});

  // void _floatingButtonPressed(BuildContext context, Food food) {
  //   if (context.mounted) {
  //     di.get<FoodCompareManager>().addFoodToCompare(food: food);
  //     di.get<FoodSearchManager>().clearSearch();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute<FoodComparisonPage>(
  //         builder: (context) => const FoodComparisonPage(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    ///(dimension of a side, spacing)
    final tileSize = MagicTileDimension.tileSize(windowSize: width);

    return Material(
      child: SafeArea(
        child: BlocBuilder<FoodDetailBloc, FoodDetailState>(
          builder: (context, state) {
            final food = state.foods?.lastEntered;
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: _MySliverHeaderDelegate(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: tileSize.spacing),
                          child: FoodDescriptionCard(
                            tileSize: tileSize,
                            food: food!,
                          ),
                        ),
                        maxHeight: tileSize.dimension,
                        minHeight: 100,
                      ),
                    ),
                    NutrientGrid(tileSize: tileSize, food: food),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    child: const Icon(Icons.compare),
                    onPressed: () => {},
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _MySliverHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: MagicNumbers.maxFoodDetailWidth),
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
