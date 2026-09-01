import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerQuestionsList extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 7, // Adjust the count based on your needs
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              height: 150,
              width: Get.width * 0.8,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
