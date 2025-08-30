import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_qa/Signup/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.mosque, size: 80, color: Colors.green[800]),
                  SizedBox(height: 10),
                  Text(
                    "Join Islamic Q&A",
                    style: GoogleFonts.merriweather(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),

            Text(
              "Create an Account ✨",
              style: GoogleFonts.robotoSlab(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Sign up to access Islamic knowledge & guidance",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),

            // Name
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                prefixIcon: Icon(Icons.person, color: Colors.green[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Email
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

            // Password
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
            SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: controller.confPasswordController,
                obscureText: controller.isConfPasswordHidden.value,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.green[700],
                    ),
                    onPressed: () => controller.isConfPasswordHidden.toggle(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Signup Button
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.nameController.text.isEmpty ||
                      controller.emailController.text.isEmpty ||
                      controller.passwordController.text.isEmpty ||
                      controller.confPasswordController.text.isEmpty) {
                    Get.snackbar('Warning', 'All fields are required!');
                  } else if (controller.passwordController.text.trim() !=
                      controller.confPasswordController.text.trim()) {
                    Get.snackbar('Warning', 'Password mismatch!');
                  } else {
                    controller.signup();
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
                          ? SpinKitCircle(size: 30, color: Colors.white,)
                          : Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                ),
              ),
            ),
            SizedBox(height: 25),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Login",
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
