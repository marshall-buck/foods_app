import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/widgets/custom_sliver_app_bar.dart';
import 'package:foods_app/widgets/reusable_text.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final foodManager = di.get<FoodSearchManager>();
  final _childKey = GlobalKey<ReusableTextFieldState>();

  final ScrollController _controllerScroll = ScrollController();

  Future<void> _clearSearch() async {
    await foodManager.clearSearch();
    _childKey.currentState?.clearSearch();
  }

  void _onTap() {
    print(_controllerScroll.initialScrollOffset);
  }

  @override
  void initState() {
    _controllerScroll.addListener(_onTap);
    super.initState();
  }

  @override
  void dispose() {
    _childKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_FoodSearchPageState build');
    return Scaffold(
      body: CustomScrollView(
        controller: _controllerScroll,
        slivers: [
          CustomSliverAppBar(
            textFieldKey: _childKey,
            onClearSearch: _clearSearch,
          ),
          const FoodsList(),
        ],
      ),
    );
  }
}
