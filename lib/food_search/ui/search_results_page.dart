import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_search/food_search.dart';

class SearchResultsPage extends StatefulWidget {
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

class _AnimatedQuickResults extends StatefulWidget {
  const _AnimatedQuickResults({required this.scrollController});
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

class _QuickResultsNamesContainer extends StatelessWidget {
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

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({required this.scrollController});

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

class _SearchBar extends StatefulWidget {
  const _SearchBar();
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchBarController = TextEditingController();
  late FoodSearchBloc _foodSearchBloc;

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

class _FoodResultsCountBadge extends StatelessWidget {
  const _FoodResultsCountBadge();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        if (state.status == FoodSearchStatus.success) {
          return Badge.count(
            count: state.foods.length,
            backgroundColor: Colors.transparent,
            textColor: Theme.of(context).colorScheme.onSurface,
            // padding: const EdgeInsets.only(right: 8),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
