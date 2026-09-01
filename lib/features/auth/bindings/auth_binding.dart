import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
