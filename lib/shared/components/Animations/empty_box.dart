import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyBox extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      repeat: false,
      'assets/animations/Empty Box.json',
      width: 200,
      height: 200,
    );
  }
}
