import 'package:get/get.dart';

class NotificationController extends GetxController{
  RxBool isHorizontal = true.obs;

  @override
  void onInit() {
    super.onInit();

    // har 500ms me toggle
    ever(isHorizontal, (_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      isHorizontal.value = !isHorizontal.value;
    });

    // start animation
    isHorizontal.value = false;
  }
}
