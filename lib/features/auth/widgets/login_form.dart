import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/auth/controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Expanded(
      flex: 4,
      child: Container(
        color: const Color(0xFFF8F6F0),
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              child: Form(
                key: loginController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo / Icon
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFF176B87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_stories,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Sign in to continue to the admin dashboard.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // =================================================
                    // EMAIL
                    // =================================================
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: loginController.emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }

                        if (!GetUtils.isEmail(value.trim())) {
                          return "Enter a valid email";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF176B87),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // =================================================
                    // PASSWORD
                    // =================================================
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Obx(() {
                      return TextFormField(
                        controller: loginController.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 5) {
                            return "Password must be at least 5 characters";
                          }

                          return null;
                        },
                        obscureText: loginController.hidePassword.value,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginController.visiblePassword();
                            },
                            icon: Icon(
                              loginController.hidePassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF176B87),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Color(0xFF176B87)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // LOGIN BUTTON
                    // =================================================
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            loginController.loginAdmin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF176B87),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: loginController.isLoading.value
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    Center(
                      child: Text(
                        "Science Stories • Admin Portal",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
