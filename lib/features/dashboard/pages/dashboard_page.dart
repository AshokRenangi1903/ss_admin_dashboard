import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/status.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/analytics_card.dart';
import 'package:ss_admin_dashboard/features/story/widgets/shimmer_story_list.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/empty_box.dart';
import 'package:ss_admin_dashboard/shared/components/Animations/rocket_loading.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return Obx(() {
      final response = dashboardController.dashboardAnalyticsResponse.value;

      switch (response.status) {
        case Status.loading:
          return ShimmerStoryList();

        case Status.error:
          return Column(
            children: [
              EmptyBox(),
              Text(response.message ?? "Something went wrong"),
            ],
          );

        case Status.completed:
          // final quizzes = response.data!;
          final dashboardAnalytics = response.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // --------------------------
                //  Total Era , stories , Popular stories
                // --------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnalyticsCard(
                      count: dashboardAnalytics.totalEras.toString(),
                      text: "Total Eras",
                      icon: Icons.menu_book,
                    ),
                    AnalyticsCard(
                      count: dashboardAnalytics.totalStories.toString(),
                      text: "Total Stories",
                      icon: Icons.auto_stories,
                    ),
                    AnalyticsCard(
                      count: dashboardAnalytics.totalEras.toString(),
                      text: "Total Quizzes",
                      icon: Icons.question_mark,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnalyticsCard(
                      count: dashboardAnalytics.popularStories.toString(),
                      text: "Popular Stories",
                      icon: Icons.star,
                    ),
                    AnalyticsCard(
                      count: dashboardAnalytics.publishedStories.toString(),
                      text: "Published Stories",
                      icon: Icons.public_sharp,
                    ),
                    AnalyticsCard(
                      count: dashboardAnalytics.totalUsers.toString(),
                      text: "Total Users",
                      icon: Icons.person,
                    ),
                  ],
                ),
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    });
  }
}
