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
/// To listen for changes to the text, use the [FoodsAppSearchBarNotification]
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
/// [FoodsAppSearchBarState] object. For example:
///
/// ```dart
/// _textFieldKey.currentState?.clearSearch();
/// ```
class FoodsAppSearchBar extends StatefulWidget {
  const FoodsAppSearchBar({required this.hintText, this.onTap, super.key});
  final String hintText;
  final GestureTapCallback? onTap;

  @override
  State<FoodsAppSearchBar> createState() => FoodsAppSearchBarState();
}

class FoodsAppSearchBarState extends State<FoodsAppSearchBar> {
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
  }

  void _onTextChanged() {
    FoodsAppSearchBarNotification(_controller.text).dispatch(context);
  }

  void clearSearch() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        style: AppTextStyle.m3BodyLarge
            .copyWith(color: FoodsAppThemeExtension.of(context).onSurface),
        controller: _controller,
        decoration: InputDecoration(
          // border: const UnderlineInputBorder(borderSide: BorderSide.),
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: FoodsAppThemeExtension.of(context).onBackground),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}

/// A notification that is dispatched when the text in a [FoodsAppSearchBar]
/// changes.
class FoodsAppSearchBarNotification extends Notification {
  FoodsAppSearchBarNotification(this.text);

  final String text;
}
