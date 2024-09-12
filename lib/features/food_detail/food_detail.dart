import 'package:flutter/material.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({required this.id, super.key});
  final ValueKey<int> id;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.lightGreenAccent,
      child: Text('FOOD $id'),
    );
  }
}
