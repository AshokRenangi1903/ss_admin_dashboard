import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu_item.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/sidebar/side_bar_header.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/sidebar/side_bar_item.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class SideBar extends StatelessWidget {
  final double width;
  const SideBar({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    return Container(
      color: AppColors.sidebarColor,
      width: Get.width * width,
      height: Get.height,
      child: Column(
        children: [
          SideBarHeader(),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: dashboardMenuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return SideBarItem(
                  item: dashboardMenuItems[index],
                  onTap: () {
                    dashboardController.selectMenuItem(
                      dashboardMenuItems[index].menu,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
