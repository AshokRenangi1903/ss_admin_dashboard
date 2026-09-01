import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/login_controller.dart';
import 'package:ss_admin_dashboard/shared/components/app_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Center(
      child: AppButton(
        text: "Log Out",
        onPressed: () {
          loginController.logoutAdmin();
        },
      ),
    );
  }
}
