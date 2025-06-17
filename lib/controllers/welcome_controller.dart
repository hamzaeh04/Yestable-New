import 'package:get/get.dart';

class WelcomeController extends GetxController{
  void startNavigationTimer(String path){
    Future.delayed(Duration (seconds: 3),(){
      Get.toNamed('$path');
    });
  }

}
