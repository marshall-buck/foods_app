import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingStatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final tileSize = FoodDetailTileSize.tileSize(windowSize: width);

    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return BasePage(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: const [
              Icon(Icons.save_as),
              Icon(Icons.edit),
              Icon(Icons.refresh),
            ],
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, tileSize.$1),
              child: FoodDetailDescription(food: food!),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: tileSize.$1,
              crossAxisSpacing: tileSize.$2,
              mainAxisSpacing: tileSize.$2,
            ),
            itemCount: food.nutrients.length,
            itemBuilder: (BuildContext context, int index) {
              return Placeholder(
                child: Text(food.description),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FoodDetailDescription extends StatelessWidget {
  const FoodDetailDescription({required this.food, super.key});
  final Food food;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final tileSize = FoodDetailTileSize.tileSize(windowSize: width);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      width: double.infinity,
      height: tileSize.$1,
      child: const Row(
        children: [
          Expanded(child: Placeholder()),
          Expanded(flex: 2, child: Placeholder()),
        ],
      ),
    );
  }
}
