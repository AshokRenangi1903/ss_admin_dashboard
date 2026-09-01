import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEraList extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 7, // Total number of items
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          // childAspectRatio: 1.0, // Aspect ratio of each item (width / height)
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100,
            height: 200,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30  ),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
