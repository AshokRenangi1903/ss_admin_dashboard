import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu.dart';

class DashboardMenuItem {
  final String title;
  final DashboardMenu menu;
  final IconData icon;
  const DashboardMenuItem({
    required this.title,
    required this.menu,
    required this.icon,
  });
}

const dashboardMenuItems = [
  DashboardMenuItem(
    title: "Dashboard",
    menu: DashboardMenu.dashboard,
    icon: Icons.dashboard,
  ),
  DashboardMenuItem(
    title: "Eras",
    menu: DashboardMenu.eras,
    icon: Icons.menu_book,
  ),
  DashboardMenuItem(
    title: "Stories",
    menu: DashboardMenu.stories,
    icon: Icons.auto_stories,
  ),
  DashboardMenuItem(
    title: "Quiz",
    menu: DashboardMenu.quiz,
    icon: Icons.question_answer,
  ),
  DashboardMenuItem(
    title: "Settings",
    menu: DashboardMenu.settings,
    icon: Icons.settings,
  ),
  DashboardMenuItem(
    title: "Testing",
    menu: DashboardMenu.testing,
    icon: Icons.car_crash,
  ),
];
