import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/auth_controller.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      // Still checking whether admin is logged in
      if (authController.isCheckingAuth.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // Admin is authenticated
      if (authController.isAuthenticated.value) {
        Future.microtask(() {
          Get.offNamed(RoutesName.dashboard);
        });

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // Admin is NOT authenticated
      Future.microtask(() {
        Get.offNamed(RoutesName.adminLogin);
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
