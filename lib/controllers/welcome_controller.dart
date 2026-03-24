import 'package:get/get.dart';
import 'package:yestable/controllers/navigation_controller.dart';

import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';

class WelcomeController extends GetxController {
  final String nextRoute;
  final prefs = SharedPreferencesMethod.storage;
  final NavigationController controller = Get.find<NavigationController>();

  WelcomeController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () async{
      var token = await prefs.getString(LocalDBKeys.TOKEN);
      print("jdjddjdj: ${token}");

      bool? saved = prefs.getBool('isUser');

      if (saved != null) {
        controller.isUser.value = saved;
      }

      if (token == null || token.isEmpty) {
        Get.offNamed(nextRoute);
      } else {
        Get.offNamed("bottomnavigationbar");
      }
    });
  }
}


