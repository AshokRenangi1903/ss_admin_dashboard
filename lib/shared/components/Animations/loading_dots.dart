import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDots extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Center(
          child: Lottie.asset(
            'assets/animations/Loading dots.json',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
