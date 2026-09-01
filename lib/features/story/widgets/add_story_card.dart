import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class AddStoryCard extends StatelessWidget {
  final VoidCallback onTap;
  const AddStoryCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: AppColors.teal,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            Text("Add New Story", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
