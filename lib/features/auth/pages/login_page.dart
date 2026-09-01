import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/login_controller.dart';
import 'package:ss_admin_dashboard/features/auth/widgets/login_form.dart';
import 'package:ss_admin_dashboard/features/auth/widgets/login_image_part.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(body: Row(children: [LoginImagePart(), LoginForm()]));
  }
}
