import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';
import 'package:foods_app/food_detail/ui/ui.dart';
import 'package:foods_app/widgets/responsive_panes.dart';

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
            // final theme = Theme.of(context);
            switch (state.status) {
              case FoodDetailStatus.success:
                final foods = state.foodsList;
                return ResponsiveLayout(
                  leftPane: ListView.builder(
                    itemCount: foods!.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return SizedBox(height: 144, child: FoodDescriptionCard(food: food!));
                    },
                  ),
                  mainPane: CustomScrollView(
                    slivers: [...foods.map((food) => NutrientGrid(tileSize: tileSize, food: food!))],
                  ),
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


// Positioned(
//                       bottom: 16,
//                       right: 16,
//                       child: FloatingActionButton(
//                         child: const Icon(Icons.settings),
//                         onPressed: () => {},
//                       ),
//                     ),


// CarouselView(
//                           shrinkExtent: 100,
//                           itemSnapping: true,
//                           itemExtent: width - MagicSpacing.sp_8, // Adjust itemExtent
//                           // padding: EdgeInsets.all(16), // Remove padding from CarouselView
//                           children: foods!
//                               .map(
//                                 (food) => Padding(
//                                   padding: EdgeInsets.zero, // Padding for each card
//                                   child: FoodDescriptionCard(
//                                     food: food!,
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),

// ...foods.map((food) => NutrientGrid(tileSize: tileSize, food: food!)),