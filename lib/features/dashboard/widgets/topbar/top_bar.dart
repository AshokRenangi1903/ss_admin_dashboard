import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/constants/layout_constants.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu_item.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/dashboard_header.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_header.dart';
import 'package:ss_admin_dashboard/features/quiz/widgets/quiz_header.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_filter_bar.dart';
import 'package:ss_admin_dashboard/features/story/widgets/story_page_header.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(color: AppColors.white),
      child: Center(
        child: Obx(() {
          final selectedItem = dashboardMenuItems.firstWhere(
            (item) => item.menu == dashboardController.selectedMenuItem.value,
          );

          switch (selectedItem.menu) {
            case DashboardMenu.dashboard:
              return DashboardHeader();
            case DashboardMenu.eras:
              return EraHeader();
            case DashboardMenu.stories:
              return StoryPageHeader();
            case DashboardMenu.quiz:
              return QuizHeader();
            case DashboardMenu.settings:
              return Text(selectedItem.title);
            case DashboardMenu.testing:
              return Text(selectedItem.title);
          }
        }),
      ),
    );
  }
}
