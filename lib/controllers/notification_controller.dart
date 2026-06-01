import 'dart:io';

import 'package:get/get.dart';

import '../core/services/notification/notification_service.dart';

class NotificationController extends GetxController{
  RxBool isHorizontal = true.obs;
  FirebaseNotification firebaseApi = FirebaseNotification();

  @override
  void onInit() {
    super.onInit();

    if(Platform.isAndroid || Platform.isIOS){
      firebaseApi.onTokenRefresh();
      firebaseApi.firebaseInIt();
    }

    // har 500ms me toggle
    ever(isHorizontal, (_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      isHorizontal.value = !isHorizontal.value;
    });

    // start animation
    isHorizontal.value = false;
  }
}
