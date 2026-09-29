import 'package:get/get.dart';

class OnboardingController extends GetxController {
  void navigateToNextScreen() {
    Get.offNamed('/login');
  }
}
