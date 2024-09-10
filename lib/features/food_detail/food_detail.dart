import 'package:flutter/material.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key, required this.id});
  final ValueKey id;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.lightGreenAccent,
      child: Text('FOOD ${id.toString()}'),
    );
  }
}
