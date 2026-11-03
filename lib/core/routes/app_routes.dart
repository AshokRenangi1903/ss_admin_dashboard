import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/middleware/auth_middleware.dart';
import 'package:ss_admin_dashboard/features/auth/pages/auth_gate.dart';
import 'package:ss_admin_dashboard/features/auth/pages/login_page.dart';
import 'package:ss_admin_dashboard/features/dashboard/bindings/dashboard_binding.dart';
import 'package:ss_admin_dashboard/features/dashboard/pages/dashboard_layout.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/era/pages/era_stories_page.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/pages/quiz_workspace.dart';
import 'package:ss_admin_dashboard/features/story_workspace/bindings/story_workspace_binding.dart';
import 'package:ss_admin_dashboard/features/story_workspace/pages/story_workspace.dart';

class AppRoutes {
  static final pages = [
    // -------------------
    //  Dashboard
    // -------------------
    GetPage(
      name: RoutesName.dashboard,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RoutesName.eras,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RoutesName.stories,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RoutesName.quiz,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RoutesName.settings,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RoutesName.testing,
      page: () => const DashboardLayout(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
    ),

    // -------------------
    //  Story Workspace
    // -------------------
    GetPage(
      name: RoutesName.storyWorkspace,
      page: () => const StoryWorkspace(),
      middlewares: [AuthMiddleware()],
      binding: StoryWorkspaceBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    // -------------------
    //  Quiz Workspace
    // -------------------
    GetPage(
      name: RoutesName.quizWorkspace,
      page: () => const QuizWorkspace(),
      middlewares: [AuthMiddleware()],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),

    // -------------------
    //  EraStories Page
    // -------------------
    GetPage(
      name: RoutesName.eraStories,
      page: () => const EraStoriesPage(),
      middlewares: [AuthMiddleware()],
      binding: DashboardBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    // -------------------
    //  Admin Login
    // -------------------
    GetPage(
      name: RoutesName.adminLogin,
      page: () => const AdminLoginPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    ),

    // -------------------
    //  Auth Gate
    // -------------------
    GetPage(
      name: RoutesName.authGate,
      page: () => const AuthGate(),
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
