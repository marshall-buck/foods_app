import 'package:flutter/material.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/food_search/models/food_list_Item.dart';
import 'package:watch_it/watch_it.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<FoodListItem>(
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return SearchBar(
          controller: controller,
          focusNode: focusNode,
          onChanged: (String value) {
            debugPrint('SearchBar onChanged $value');
            if (value.trim().length < 2) {
              return;
            }
            ;
          },
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        debugPrint('optionsBuilder ${textEditingValue.text}');
        if (textEditingValue.text.trim().length < 2) {
          return [];
        }
        final Iterable<FoodListItem> options = await di<FoodSearchManager>()
            .queryFoods(searchTerm: textEditingValue.text);

        return options;
      },
      onSelected: (FoodListItem food) {
        debugPrint('You just selected $food');
      },
    );
  }
}
