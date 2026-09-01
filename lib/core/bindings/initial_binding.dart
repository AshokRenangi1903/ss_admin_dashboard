import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/auth_controller.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/login_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}
