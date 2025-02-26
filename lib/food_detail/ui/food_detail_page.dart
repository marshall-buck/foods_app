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
      create: (BuildContext context) => FoodDetailBloc(
        activeFoods: activeFoods,
        localFoodsDBRepo: localFoodsDB,
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
          builder: (context, state) {
            final width = MediaQuery.sizeOf(context).width;

            ///(dimension of a side, spacing)
            final tileSize = MagicTileDimension.tileSize(windowSize: width);
            print(tileSize.dimension);
            switch (state.status) {
              case FoodDetailStatus.success:
                final foods = state.foods;
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                          delegate: _MySliverHeaderDelegate(
                            maxHeight: tileSize.dimension + 48,
                            minHeight: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(MagicSpacing.sp_4),
                              child: CarouselView(
                                itemExtent: width - MagicSpacing.sp_8, // Adjust itemExtent
                                padding: EdgeInsets.zero, // Remove padding from CarouselView
                                children: foods!
                                    .map(
                                      (food) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: MagicSpacing.sp_2), // Padding for each card
                                        child: FoodDescriptionCard(
                                          food: food!,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        ...foods.map((food) => NutrientGrid(tileSize: tileSize, food: food!)),
                      ],
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        child: const Icon(Icons.settings),
                        onPressed: () => {},
                      ),
                    ),
                  ],
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
      child: child,
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
