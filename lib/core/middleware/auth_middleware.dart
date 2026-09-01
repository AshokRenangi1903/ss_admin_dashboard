import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // /me verification still running
    if (authController.isCheckingAuth.value) {
      return const RouteSettings(name: RoutesName.authGate);
    }

    if (authController.isAuthenticated.value) {
      return null;
    }

    return const RouteSettings(name: RoutesName.adminLogin);
  }
}
