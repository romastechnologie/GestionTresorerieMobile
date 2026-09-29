import 'package:get/get.dart';

class LoginPageController extends GetxController {
  void navigateToNextScreen() {
    Get.offNamed('/main');
  }

  void navigateToForgotPasswordScreen() {
    Get.offNamed('/forgot-password');
  }

}
