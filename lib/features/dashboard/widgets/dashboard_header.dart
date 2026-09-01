import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class DashboardHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard Analytics",
                style: TextStyle(
                  color: AppColors.darkText,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                "Track your platform's key metrics and get insights into content, users, stories, and quiz activity",
                style: TextStyle(
                  color: AppColors.softText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.blue,
            ),
            child: IconButton(
              onPressed: () {
                dashboardController.getDashboardAnalytics();
              },
              icon: Icon(Icons.refresh),
              color: AppColors.white,
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
