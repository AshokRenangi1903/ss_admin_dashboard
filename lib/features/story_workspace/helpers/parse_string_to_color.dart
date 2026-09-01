import 'package:flutter/material.dart';

Color parseStringToColor(String? color) {
  if (color == null) {
    return Colors.black;
  }

  final hex = color.replaceFirst('#', '');

  return Color(int.parse('FF$hex', radix: 16));
}
