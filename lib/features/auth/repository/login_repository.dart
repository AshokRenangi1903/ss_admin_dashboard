import 'package:ss_admin_dashboard/core/constants/app_urls.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';
import 'package:ss_admin_dashboard/core/network/network_api_services.dart';
import 'package:ss_admin_dashboard/features/auth/models/login_request.dart';

class LoginRepository {
  final BaseApiServices _api = NetworkApiServices();

  // Admin Login
  Future<Map<String, dynamic>> loginAdmin(LoginRequest admin) async {
    final response = await _api.postApi(
      
      AppUrls.adminLogin,
      data: admin.toJson(),
    );

    return response;
  }

  // Get Admin
  Future<Map<String, dynamic>> getCurrentAdmin() async {
    final response = await _api.getApi(AppUrls.adminMe);

    return response;
  }

  Future<void> logoutAdmin() async {
    await _api.postApi(AppUrls.adminLogout);
  }
}
