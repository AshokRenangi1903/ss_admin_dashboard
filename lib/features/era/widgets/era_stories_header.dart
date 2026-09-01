import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class EraStoriesHeader extends StatelessWidget {
  final String eraTitle, eraDescription;
  final int storiesCount;
  const EraStoriesHeader({
    super.key,
    required this.eraTitle,
    required this.eraDescription,
    required this.storiesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eraTitle,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Description: $eraDescription",
                style: TextStyle(color: AppColors.softInk, fontSize: 16),
              ),
              // Text(
              //   "Total Stories in $eraTitle are $storiesCount",
              //   style: TextStyle(color: AppColors.sidebarColor, fontSize: 12),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
