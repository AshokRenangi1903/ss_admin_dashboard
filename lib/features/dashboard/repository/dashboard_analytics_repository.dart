import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/dashboard/models/dashboard_analytics_model.dart';

class DashboardAnalyticsRepository {
  final BaseApiServices _api = NetworkApiServices();

  Future<DashboardAnalyticsModel> getDashboardAnalytics() async {
    final response = await _api.getApi(AppUrls.getDashboardAnalytics);
    final DashboardAnalyticsModel dashboardAnalytics =
        DashboardAnalyticsModel.fromJson(response['data']);

    return dashboardAnalytics;
  }
}
