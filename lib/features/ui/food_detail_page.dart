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
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FoodDetailDescription(food: food!),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: tileSize.$1,
                crossAxisSpacing: tileSize.$2,
                mainAxisSpacing: tileSize.$2,
                mainAxisExtent: tileSize.$1 / 2,
              ),
              itemCount: food.nutrientList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0.25,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Text(
                    food.nutrientList[index].name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
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
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 0.25,
        ),
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      width: double.infinity,
      height: FoodDetailTileSize.sm,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '100 g',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                food.description,
                style: Theme.of(context).textTheme.bodySmall,
              )),
        ],
      ),
    );
  }
}
