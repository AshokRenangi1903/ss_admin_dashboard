import 'package:flutter/material.dart';

class AppBreadcrumb extends StatelessWidget {
  final List<String> items;

  const AppBreadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isEven) {
          final item = items[index ~/ 2];

          final isLast = index == items.length * 2 - 2;

          return Text(
            item,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isLast ? FontWeight.bold : FontWeight.w500,
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.chevron_right, size: 18),
        );
      }),
    );
  }
}
