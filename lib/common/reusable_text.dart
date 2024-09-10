import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  const ReusableTextField({Key? key}) : super(key: key);

  @override
  State<ReusableTextField> createState() => ReusableTextFieldState();
}

class ReusableTextFieldState extends State<ReusableTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
    print('dispose called');
  }

  void _onTextChanged() {
    TextChangeNotification(_controller.text).dispatch(context);
  }

  void clearSearch() async {
    print('ClearSearch called');
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // key: _key,
      controller: _controller,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        hintText: 'Search for food...',
      ),
    );
  }
}

class TextChangeNotification extends Notification {
  final String text;

  TextChangeNotification(this.text);
}


// NotificationListener<TextChangeNotification>(
//      onNotification: (notification) {
//        // Handle the updated text here
//        print("New search term: ${notification.text}");
//        return true;
//      },
//      child: ReusableTextField(),
//    )