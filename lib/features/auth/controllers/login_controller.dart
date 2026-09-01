import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/auth_controller.dart';
import 'package:ss_admin_dashboard/features/auth/models/login_request.dart';
import 'package:ss_admin_dashboard/features/auth/repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository _repository = LoginRepository();
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;

  void visiblePassword() {
    if (hidePassword.value == true) {
      hidePassword.value = false;
    } else {
      hidePassword.value = true;
    }
  }

  Future<void> loginAdmin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await _repository.loginAdmin(request);

      await authController.checkAuth();

      Get.offAllNamed(RoutesName.dashboard);

      Get.snackbar("Login Success", "Admin Logged in successfully!");
      // handle response
      // save token
      // navigate to dashboard
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutAdmin() async {
    try {
      await _repository.logoutAdmin();
      authController.clearSession();
      Get.offAllNamed(RoutesName.adminLogin);

      Get.snackbar("Logged Out ", "Successful Logged out!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
