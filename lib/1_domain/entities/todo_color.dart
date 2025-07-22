import 'package:flutter/material.dart';

class TodoColor {
  final int colorIndex;

  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.blueGrey,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.orange,
  ];

  TodoColor({required this.colorIndex});

  Color get color => predefinedColors[colorIndex % predefinedColors.length];
}
