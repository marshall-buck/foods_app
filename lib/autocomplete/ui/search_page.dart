// import 'dart:async';

// import 'package:flutter/material.dart';

// class SearchPage extends StatelessWidget {
//   // static const List<Foo> _userOptions = <User>[
//   //   User(name: 'Alice', email: 'alice@example.com'),
//   //   User(name: 'Bob', email: 'bob@example.com'),
//   //   User(name: 'Charlie', email: 'charlie123@gmail.com'),
//   // ];

//   const SearchPage({super.key});

//   static String _displayStringForOption(User option) => option.name;

//   /// What happens as keys are pressed
//   /// A function that returns the current selectable options objects given the current TextEditingValue.
//   static FutureOr<Iterable<User>> _optionsBuilder(
//       TextEditingValue textEditingValue) {
//     debugPrint('textEditingValue ${textEditingValue.text}');
//     if (textEditingValue.text == '') {
//       return const Iterable<User>.empty();
//     }
//     final res = _userOptions.where((User option) {
//       return option.toString().contains(textEditingValue.text.toLowerCase());
//     });
//     debugPrint('$res');
//     return res;

//     // return _userOptions.where((User option) {

//     //   return option.toString().contains(textEditingValue.text.toLowerCase());
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete<User>(
//       displayStringForOption: _displayStringForOption,
//       optionsBuilder: _optionsBuilder,
//       onSelected: (User selection) {
//         debugPrint('You just selected ${_displayStringForOption(selection)}');
//       },
//     );
//   }
// }
