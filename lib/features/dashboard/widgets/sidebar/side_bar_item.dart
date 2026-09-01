import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/dashboard/controllers/dashboard_controller.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu_item.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class SideBarItem extends StatelessWidget {
  final DashboardMenuItem item;
  final VoidCallback onTap;
  const SideBarItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    return Obx(() {
      final bool isSelected =
          item.menu == dashboardController.selectedMenuItem.value;
      final iconAndTextColor = isSelected
          ? AppColors.primaryColor
          : AppColors.white;

      return Container(
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
                  left: BorderSide(width: 5, color: AppColors.primaryColor),
                )
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            tileColor: isSelected
                ? AppColors.goldBorderColor
                : AppColors.sidebarColor,
            iconColor: iconAndTextColor,
            onTap: onTap,
            leading: Icon(item.icon),
            title: Text(item.title, style: TextStyle(color: iconAndTextColor)),
          ),
        ),
      );
    });
  }
}
