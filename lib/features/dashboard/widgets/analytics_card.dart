import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class AnalyticsCard extends StatelessWidget {
  final String count, text;
  final IconData icon;
  const AnalyticsCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.2,

      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.goldBorderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.goldBorderColor.withAlpha(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Icon(icon, size: 40, color: AppColors.blue),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(text, style: TextStyle(color: AppColors.softInk)),
            ],
          ),
        ],
      ),
    );
  }
}
