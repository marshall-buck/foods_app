import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/food_detail/food_detail.dart';

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodDetailBloc(
        activeFoods: RepositoryProvider.of<ActiveFoods>(context),
        localFoodsDBRepo: RepositoryProvider.of<LocalFoodsDBRepo>(context),
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
            switch (state.status) {
              case FoodDetailStatus.success:
                return ResponsivePanes(
                  leftPane: FoodDescriptionCardList(
                    foods: state.foodsList,
                  ),
                  mainPane: const SizedBox(height: 300, child: NutrientCompareCards()),
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

class FoodDescriptionCardList extends StatelessWidget {
  const FoodDescriptionCardList({required this.foods, super.key});
  final List<Food?> foods;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final tileSize = MagicTileDimension.tileSize(windowSize: width);

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return SizedBox(
            height: tileSize.dimension,
            child: FoodDescriptionCard(
              food: food!,
              isEven: index.isEven,
            ));
      },
    );
  }
}

// class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
//   const _MySliverHeaderDelegate({
//     required this.child,
//     required this.maxHeight,
//     required this.minHeight,
//   });

//   final double minHeight;
//   final double maxHeight;
//   final Widget child;
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Center(
//       child: child,
//     );
//   }

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   double get minExtent => minHeight;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }


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
