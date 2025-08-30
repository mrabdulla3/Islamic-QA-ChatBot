import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_qa/Login/login_controller.dart';
import 'package:islamic_qa/Signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Islamic header
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 80,
                    color: Colors.green[800],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Islamic Q&A",
                    style: GoogleFonts.merriweather(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),

            Text(
              "Welcome Back 👋",
              style: GoogleFonts.robotoSlab(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Login to continue your journey of knowledge",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),

            // Email Field
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email, color: Colors.green[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Password Field
            Obx(
              () => TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.green[700],
                    ),
                    onPressed: () => controller.isPasswordHidden.toggle(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.green[800]),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Login Button
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.emailController.text.isNotEmpty &&
                      controller.passwordController.text.isNotEmpty) {
                    controller.login();
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please enter both email and password",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: Colors.white,
                      margin: EdgeInsets.all(12),
                      borderRadius: 10,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child:
                      controller.isLoading.value
                          ? SpinKitCircle(size: 30,color: Colors.white,)
                          : Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Signup Redirect
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignupScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
