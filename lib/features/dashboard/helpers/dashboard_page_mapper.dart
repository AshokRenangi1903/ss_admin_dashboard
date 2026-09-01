import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu.dart';
import 'package:ss_admin_dashboard/features/dashboard/pages/dashboard_page.dart';
import 'package:ss_admin_dashboard/features/era/pages/era_page.dart';
import 'package:ss_admin_dashboard/features/quiz/pages/quiz_page.dart';
import 'package:ss_admin_dashboard/features/settings/pages/settings_page.dart';
import 'package:ss_admin_dashboard/features/story/pages/story_page.dart';
import 'package:ss_admin_dashboard/features/testing/pages/testing_page.dart';

final dashboardPageMapper = <DashboardMenu, Widget>{
  DashboardMenu.dashboard: const DashboardPage(),
  DashboardMenu.eras: const EraPage(),
  DashboardMenu.stories: const StoryPage(),
  DashboardMenu.settings: const SettingsPage(),
  DashboardMenu.quiz: const QuizPage(),
  DashboardMenu.testing: const TestingPage(),
};
