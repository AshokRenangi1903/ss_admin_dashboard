import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/response/api_response.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_analytics_model.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_menu.dart';
import 'package:ss_admin_dashboard/features/dashboard/repository/dashboard_analytics_repository.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDashboardAnalytics();
  }

  final DashboardAnalyticsRepository _repository =
      DashboardAnalyticsRepository();
 
  final selectedMenuItem = DashboardMenu.dashboard.obs;

  void selectMenuItem(DashboardMenu menuItem) {
    selectedMenuItem.value = menuItem;
  }

  final dashboardAnalyticsResponse =
      ApiResponse<DashboardAnalyticsModel>.loading().obs;

  // Get Dashboard Analytics
  Future<void> getDashboardAnalytics() async {
    try {
      dashboardAnalyticsResponse.value = ApiResponse.loading();
      final dashboardAnalytics = await _repository.getDashboardAnalytics();
      dashboardAnalyticsResponse.value = ApiResponse.completed(
        dashboardAnalytics,
      );
      print(dashboardAnalytics.toString());
    } catch (e) {
      dashboardAnalyticsResponse.value = ApiResponse.error(e.toString());
    }
  }
}
