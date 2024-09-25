import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A [TextField] that can be reused in multiple places.
///
/// This widget is a simple wrapper around a [TextField] that provides a
/// convenient way to listen for changes to the text and to clear the text.
///
/// To use this widget, simply create a new instance of it and pass it to the
/// [TextField] constructor. For example:
///
/// ```dart
/// ReusableTextField(
///   key: _textFieldKey,
/// )
/// ```
///
/// To listen for changes to the text, use the [ReusableTextFieldNotification]
/// class. For example:
///
/// ```dart
/// NotificationListener<ReusableTextFieldNotification>(
///   onNotification: (notification) {
///     // Do something with the text.
///     print(notification.text);
///     return true;
///   },
///   child: ReusableTextField(
///     key: _textFieldKey,
///   ),
/// ),
/// ```
///
// ignore: comment_references
/// To clear the text, call the [clearSearch] method on the
/// [ReusableTextFieldState] object. For example:
///
/// ```dart
/// _textFieldKey.currentState?.clearSearch();
/// ```
class ReusableTextField extends StatefulWidget {
  const ReusableTextField({super.key});

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
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
    // print('dispose called');
  }

  void _onTextChanged() {
    ReusableTextFieldNotification(_controller.text).dispatch(context);
  }

  void clearSearch() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.m3LabelMedium
          .copyWith(color: AppColorsExtension.of(context).onBackground),
      controller: _controller,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        hintText: 'Search for food...',
      ),
    );
  }
}

/// A notification that is dispatched when the text in a [ReusableTextField]
/// changes.
class ReusableTextFieldNotification extends Notification {
  ReusableTextFieldNotification(this.text);

  final String text;
}
