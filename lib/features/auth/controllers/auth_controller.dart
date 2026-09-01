import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/repository/login_repository.dart';

class AuthController extends GetxController {
  final LoginRepository _repository = LoginRepository();

  final RxBool isAuthenticated = false.obs;
  final RxBool isCheckingAuth = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      isCheckingAuth.value = true;

      await _repository.getCurrentAdmin();

      isAuthenticated.value = true;
    } catch (e) {
      isAuthenticated.value = false;
    } finally {
      isCheckingAuth.value = false;
    }
  }

  void clearSession() {
    isAuthenticated.value = false;
    isCheckingAuth.value = false;
  }
}
