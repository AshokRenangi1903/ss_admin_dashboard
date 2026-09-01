import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Lottie.asset(
              'assets/animations/globe.json',
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/Energy Rocket.json',
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/Empty Box.json',
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/Loading dots.json',
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/Man Filling a Survey with a Woman Watching at 5-star Feedback Dialog.json',

              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/success confetti.json',
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/animations/trophy confetti.json',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
