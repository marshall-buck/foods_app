import 'package:flutter/material.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';

import 'package:foods_app/food_search/models/food_list_Item.dart';
import 'package:foods_app/food_search/ui/list_item.dart';
import 'package:watch_it/watch_it.dart';

class SearchPage extends WatchingWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SearchBar(onChanged: (String? searchTerm) {
            print(searchTerm);
          }),
          ListView.builder(
              itemCount: foods?.length,
              itemBuilder: (context, index) {
                return Text('${foods?[index].description}');
              })
        ],
      ),
    );
  }
}

//  List<FoodListItem>? foods =
//         watchValue((FoodSearchManager x) => x.currentResults);

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Autocomplete Basic User'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Type below to autocomplete the following possible results: ${AutocompleteBasicUserExample._userOptions}.'),
              const AutocompleteBasicUserExample(),
            ],
          ),
        ),
      ),
    );
  }
}

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});

  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<FoodListItem>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<FoodListItem>.empty();
        }
        return _userOptions.where((FoodListItem option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (FoodListItem selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
