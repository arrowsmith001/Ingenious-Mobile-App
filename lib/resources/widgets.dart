import 'package:flutter/material.dart';

class MyRRect extends StatelessWidget{
  MyRRect(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 16,
        height: 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color
        ),
      ),
    );
  }
}