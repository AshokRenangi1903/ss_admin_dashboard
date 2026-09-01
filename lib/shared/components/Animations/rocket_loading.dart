import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RocketLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/Energy Rocket.json',
      width: 200,
      height: 200,
    );
  }
}
