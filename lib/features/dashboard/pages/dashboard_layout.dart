import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/core/constants/layout_constants.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/content/content_area.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/sidebar/side_bar.dart';
import 'package:ss_admin_dashboard/features/dashboard/widgets/topbar/top_bar.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
