import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_search/food_search.dart';

/// {@template search_results_page}
/// A page that displays search results for food items.
/// Includes a search bar, quick results, and a list of search results.
/// {@endtemplate}
class SearchResultsPage extends StatefulWidget {
  /// {@macro search_results_page}
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPage();
}

class _SearchResultsPage extends State<SearchResultsPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final padding = MediaQuery.paddingOf(context);
    final centeredSearchBarTopPadding = (height / 2) - (MagicNumbers.searchBarHeight / 2) - (padding.top);

    final centerSearchBarOnPage = context.select<FoodSearchBloc, bool>(
      (bloc) => bloc.state.status == FoodSearchStatus.initiated,
    );

    return Material(
      child: SafeArea(
        child: Column(
          spacing: MagicSpacing.sp_2,
          children: [
            AnimatedPadding(
              duration: MagicDurations.base2,
              padding: centerSearchBarOnPage
                  ? EdgeInsets.only(
                      top: centeredSearchBarTopPadding,
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
                child: const _SearchBar(),
              ),
            ),
            _AnimatedQuickResults(
              scrollController: _scrollController,
            ),
            _SearchResultsList(
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template animated_quick_results}
/// A widget that displays quick search results with an animated height
/// based on user scroll direction.
/// {@endtemplate}
class _AnimatedQuickResults extends StatefulWidget {
  /// {@macro animated_quick_results}
  const _AnimatedQuickResults({required this.scrollController});

  /// The scroll controller used to detect scroll direction.
  final ScrollController scrollController;

  @override
  State<_AnimatedQuickResults> createState() => _AnimatedQuickResultsState();
}

class _AnimatedQuickResultsState extends State<_AnimatedQuickResults> {
  bool _showQuickResults = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  /// Handles scroll events to toggle the visibility of quick results.
  void _onScroll() {
    if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
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
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: MagicDurations.base1,
      height: _showQuickResults && context.read<FoodSearchBloc>().state.hasResults ? 32 : 0,
      child: const _QuickResultsNamesContainer(),
    );
  }
}

/// {@template quick_results_names_container}
/// A container that displays the names of quick search results.
/// {@endtemplate}
class _QuickResultsNamesContainer extends StatelessWidget {
  /// {@macro quick_results_names_container}
  const _QuickResultsNamesContainer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      buildWhen: (previous, current) => previous.quickSearchIds != current.quickSearchIds,
      builder: (context, state) {
        return Row(
          children: state.quickSearchNames.map((quickResult) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                quickResult,
                style: AppTextStyle.m3LabelSmall.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// {@template search_results_list}
/// A widget that displays a list of search results for food items.
/// {@endtemplate}
class _SearchResultsList extends StatelessWidget {
  /// {@macro search_results_list}
  const _SearchResultsList({required this.scrollController});

  /// The scroll controller for the list view.
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      buildWhen: (previous, current) => previous.foods != current.foods,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) {
              final food = state.foods[index];

              return FoodListItem(food: food!);
            },
            itemCount: state.foods.length,
          ),
        );
      },
    );
  }
}

/// {@template search_bar}
/// A search bar widget that allows users to input search terms.
/// {@endtemplate}
class _SearchBar extends StatefulWidget {
  /// {@macro search_bar}
  const _SearchBar();
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchBarController = TextEditingController();
  late FoodSearchBloc _foodSearchBloc;

  /// Clears the search bar text and resets the search state.
  void _onClear() {
    _searchBarController.clear();
    _foodSearchBloc.add(FoodSearchTextCleared());
  }

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
    final showBadge = context.select<FoodSearchBloc, bool>(
      (bloc) => bloc.state.status == FoodSearchStatus.success,
    );
    return SearchBar(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      controller: _searchBarController,
      constraints: Theme.of(context).searchBarTheme.constraints,
      hintText: MagicStrings.searchPageHintText,
      trailing: [
        if (showBadge) const _FoodResultsCountBadge() else const Spacer(),
        IconButton(
          onPressed: _onClear,
          icon: const Icon(Icons.clear_outlined),
        ),
      ],
      onChanged: (string) => _foodSearchBloc.add(FoodSearchTextChanged(searchTerm: _searchBarController.text)),
    );
  }
}

/// {@template food_results_count_badge}
/// A badge that displays the count of food search results.
/// {@endtemplate}
class _FoodResultsCountBadge extends StatelessWidget {
  /// {@macro food_results_count_badge}
  const _FoodResultsCountBadge();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        if (state.status == FoodSearchStatus.success) {
          return Badge.count(
            count: state.foods.length,
            backgroundColor: Colors.transparent,
            textColor: Theme.of(context).colorScheme.tertiary,
            // padding: const EdgeInsets.only(right: 8),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
