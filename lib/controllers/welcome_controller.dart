import 'package:get/get.dart';

import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';

class WelcomeController extends GetxController {
  final String nextRoute;
  final prefs = SharedPreferencesMethod.storage;

  WelcomeController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () async{
      Get.offNamed(nextRoute);
      // var token = await prefs.getString(LocalDBKeys.TOKEN);
      // print("jdjddjdj: ${token}");
      //
      // if (token == null || token.isEmpty) {
      //   Get.offNamed(nextRoute);
      // } else {
      //   Get.offNamed("bottomnavigationbar");
      // }
    });
  }
}


