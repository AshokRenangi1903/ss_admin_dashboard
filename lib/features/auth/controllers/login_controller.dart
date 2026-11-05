import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      // 1. Login API
      await _repository.loginAdmin(request);

      // 2. Verify the admin session
      final isValid = await authController.checkAuth();

      if (!isValid) {
        throw Exception('Unable to verify admin session.');
      }

      // 3. Navigate only after successful verification
      Get.offAllNamed(RoutesName.dashboard);

      Get.snackbar("Login Success", "Admin Logged in successfully!");
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
