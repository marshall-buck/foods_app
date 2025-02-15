import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_search/food_search.dart';
import 'package:foods_app/widgets/widgets.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPage();
}

class _SearchResultsPage extends State<SearchResultsPage> {
  final _scrollController = ScrollController();

  bool _showQuickResults = false;

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _showQuickResults = true;
      });

      return;
    }
    setState(() {
      _showQuickResults = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final padding = MediaQuery.paddingOf(context);
    final centeredSearchBarTop =
        (height / 2) - (MagicNumbers.searchBarHeight / 2) - (padding.top);

    final hasResults = context.select<FoodSearchBloc, bool>(
      (bloc) => bloc.state is FoodSearchSuccessState,
    );
    print('SearchResultsPage" $hasResults');
    return Material(
      child: SafeArea(
        child: Column(
          spacing: MagicSpacing.sp_2,
          children: [
            AnimatedPadding(
              duration: MagicDurations.base2,
              padding: !hasResults
                  ? EdgeInsets.only(
                      top: centeredSearchBarTop,
                      right: MagicSpacing.sp_3,
                      left: MagicSpacing.sp_3,
                    )
                  : const EdgeInsets.symmetric(horizontal: MagicSpacing.sp_3),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: MagicNumbers.maxSearchBarWidth,
                  minWidth: MagicNumbers.minSearchBarWidth,
                  maxHeight: MagicNumbers.searchBarHeight,
                  minHeight: MagicNumbers.searchBarHeight,
                ),
                child: _SearchBar(),
              ),
            ),
            AnimatedContainer(
              // color: Colors.amber,
              duration: MagicDurations.base1,
              height: _showQuickResults ? 32 : 0,
              child: const QuickResultsNamesContainer(),
            ),
            _SearchResults(),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods =
        context.select<FoodSearchBloc, List<FoodListItemModel>>((bloc) {
      final state = bloc.state;
      if (state is FoodSearchSuccessState) {
        return state.foods;
      }
      return [];
    });
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final food = foods.elementAt(index);

          final id = ValueKey<int>(food.id);
          return GestureDetector(
            onTap: () => {},
            child: FoodListItem(
              key: id,
              food: food,
            ),
          );
        },
        itemCount: foods.length,
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchBarController = TextEditingController();
  late FoodSearchBloc _foodSearchBloc;

  @override
  void initState() {
    super.initState();
    _foodSearchBloc = context.read<FoodSearchBloc>();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasResults = context.select<FoodSearchBloc, bool>(
      (bloc) => bloc.state is FoodSearchSuccessState,
    );
    return SearchBar(
      controller: _searchBarController,
      constraints: Theme.of(context).searchBarTheme.constraints,
      hintText: MagicStrings.searchPageHintText,
      trailing: [
        if (hasResults) const FoodResultsCountBadge() else const Spacer(),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.clear_outlined),
        ),
      ],
      onChanged: (string) => _foodSearchBloc
          .add(TextChanged(searchTerm: _searchBarController.text)),
    );
  }
}
