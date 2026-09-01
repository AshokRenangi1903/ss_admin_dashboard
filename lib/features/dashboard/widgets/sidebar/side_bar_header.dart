import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class SideBarHeader extends StatelessWidget {
  const SideBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.science,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            size: 34,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Science Stories",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ADMIN PANEL",
                style: TextStyle(color: AppColors.softText, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
