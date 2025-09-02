import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final String nextRoute;

  WelcomeController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(nextRoute);
    });
  }
}


