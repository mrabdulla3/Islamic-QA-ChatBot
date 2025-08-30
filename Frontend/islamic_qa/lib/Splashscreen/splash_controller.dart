import 'package:get/get.dart';
import 'package:islamic_qa/Home/chat_screen.dart';
import 'package:islamic_qa/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  String? token;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");

    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token!.isNotEmpty) {
        Get.off(() => ChatScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }
}
