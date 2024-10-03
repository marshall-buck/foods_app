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
  final _textFieldKey = GlobalKey<FoodsAppSearchBarState>();

  Future<void> _clearSearch() async {
    // await foodManager.clearSearch();
    _textFieldKey.currentState?.clearSearch();
  }

  @override
  void initState() {
    super.initState();
  }

  late final Widget appBar = SliverPadding(
    padding: const EdgeInsets.only(bottom: 4),
    sliver: CustomSliverAppBar(
      textFieldKey: _textFieldKey,
      onClearSearch: _clearSearch,
      showBadge: false,
      hintText: AppStrings.detailsPageHintText,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return NotificationListener<FoodsAppSearchBarNotification>(
      onNotification: (notification) {
        return true;
      },
      child: BasePage(
        slivers: [
          appBar,
          SliverToBoxAdapter(
            child: Text(food!.description),
          ),
          FoodDetailDescription(food: food),
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
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: FoodsAppThemeExtension.of(context).primaryContainer,
        ),
        width: double.infinity,
        height: 128,
        child: const Row(
          children: [
            Expanded(child: Placeholder()),
            Expanded(flex: 2, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}
