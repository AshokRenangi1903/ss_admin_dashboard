import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/helpers/dashboard_page_mapper.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    return Container(
      width: double.infinity,
      color: AppColors.pageBgColor,
      child: Obx(() {
        return Center(
          child:
              dashboardPageMapper[dashboardController.selectedMenuItem.value] ??
              Center(child: Text("Something went Wrong")),
        );
      }),
    );
  }
}
