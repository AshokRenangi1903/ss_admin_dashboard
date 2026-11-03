
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_analytics_model.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu.dart';
import 'package:ss_admin_dashboard/features/dashboard/repository/dashboard_analytics_repository.dart';

class DashboardController extends GetxController {
  final DashboardAnalyticsRepository _repository =
      DashboardAnalyticsRepository();

  final selectedMenuItem = DashboardMenu.dashboard.obs;

  final dashboardAnalyticsResponse =
      ApiResponse<DashboardAnalyticsModel>.loading().obs;

  @override
  void onInit() {
    super.onInit();
    syncMenuWithRoute();
    getDashboardAnalytics();
  }

  String routeForMenu(DashboardMenu menu) {
    switch (menu) {
      case DashboardMenu.dashboard:
        return RoutesName.dashboard;
      case DashboardMenu.eras:
        return RoutesName.eras;
      case DashboardMenu.stories:
        return RoutesName.stories;
      case DashboardMenu.quiz:
        return RoutesName.quiz;
      case DashboardMenu.settings:
        return RoutesName.settings;
      case DashboardMenu.testing:
        return RoutesName.testing;
    }
  }

  void selectMenuItem(DashboardMenu menuItem) {
    selectedMenuItem.value = menuItem;

    final targetRoute = routeForMenu(menuItem);

    if (Get.currentRoute != targetRoute) {
      Get.toNamed(targetRoute);
    }
  }

  void syncMenuWithRoute() {
    final currentRoute = Get.currentRoute;

    for (final menu in DashboardMenu.values) {
      if (routeForMenu(menu) == currentRoute) {
        selectedMenuItem.value = menu;
        return;
      }
    }

    selectedMenuItem.value = DashboardMenu.dashboard;
  }

  Future<void> getDashboardAnalytics() async {
    try {
      dashboardAnalyticsResponse.value = ApiResponse.loading();

      final dashboardAnalytics =
          await _repository.getDashboardAnalytics();

      dashboardAnalyticsResponse.value =
          ApiResponse.completed(dashboardAnalytics);
    } catch (e) {
      dashboardAnalyticsResponse.value =
          ApiResponse.error(e.toString());
    }
  }
}
