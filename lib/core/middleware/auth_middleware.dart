import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    if (authController.isCheckingAuth.value) {
      return RouteSettings(
        name: RoutesName.authGate,
        arguments: {'returnTo': route},
      );
    }

    if (authController.isAuthenticated.value) {
      return null;
    }

    return const RouteSettings(name: RoutesName.adminLogin);
  }
}
