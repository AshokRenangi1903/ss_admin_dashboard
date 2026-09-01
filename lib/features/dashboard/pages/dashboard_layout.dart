import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/constants/layout_constants.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/content/content_area.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/sidebar/side_bar.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/topbar/top_bar.dart';
import 'package:ss_admin_dashboard/features/era/controller/era_controller.dart';
import 'package:ss_admin_dashboard/features/quiz/controller/quiz_controller.dart';
import 'package:ss_admin_dashboard/features/story/controller/story_controller.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    final storyController = Get.put(StoryController());
    final eraController = Get.put(EraController());
    final quizController = Get.put(QuizController());
    return Scaffold(
      body: Row(
        children: [
          SideBar(width: LayoutConstants.sideBarWidth),
          Expanded(
            child: Column(
              children: [
                TopBar(),
                Expanded(child: ContentArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
