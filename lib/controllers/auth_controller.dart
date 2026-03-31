import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/core/services/apiendpoints.dart';
import 'package:yestable/core/services/base_services.dart';

import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';

class AuthController extends GetxController {
  final NavigationController controller = Get.find<NavigationController>();
  BaseService baseService = BaseService();
  var selectedCountry = Country.parse('US').obs;
  RxString verificationCode = "".obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController emailControllerHost = TextEditingController();
  final prefs = SharedPreferencesMethod.storage;
  int? step;

  void changeCountry(Country country) {
    selectedCountry.value = country;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    phoneController.dispose();
    super.onClose();
  }



  Future<void> passwordLessLogin() async {
    final body = {"email": emailController.text.trim()};

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.login,
      body,
      loading: true,
    );
    if (responseMap["success"] != true) {
      return;
    }
    final data = responseMap["data"]; // user object
    if (data == null) return; // Safety guard
    // final prefs = SharedPreferencesMethod.storage;
    // await prefs.setString(LocalDBKeys.USERFULLNAME, nameController.text);
    // 🚀 AB DASHBOARD PE JAO
    Get.toNamed('/verificationcodescreen');

    // print("🎉 SIGNUP SUCCESS → ${data["email"]}");
  }
  Future<void> codeVerification() async {
    final body = {
      "email": emailController.text.trim(),
      "otp": verificationCode.value
    };


    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.verifyOtp,
      body,
      loading: true,
    );
    if (responseMap["success"] != true) {
      return;
    }
    final data = responseMap["data"]; // user object
    final profileCompleted = responseMap["data"]["user"]["profileCompleted"];
    step = data["user"]["onboardingStep"];
    if (data == null) return; // Safety guard
    await prefs.setString(LocalDBKeys.TOKEN, data["access_token"]);
    await prefs.setString(LocalDBKeys.USEREMAIL, data["user"]["email"]);
    await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, profileCompleted);
    await prefs.setString(LocalDBKeys.USERFULLNAME, data["user"]["name"] ?? "");
    await prefs.setString(LocalDBKeys.USERID, data["user"]["_id"]);
    await prefs.setString(LocalDBKeys.ONBOARDINGSTEP, "${data["user"]["onboardingStep"]}");
    print("Faaaaahhhh: ${data["access_token"]}");
    print("userId: ${prefs.getString(LocalDBKeys.USERID)}");
    print("SharedPreferences: ${prefs.getBool(LocalDBKeys.PROFILECOMPLETED)}");
    print(profileCompleted);
    // 🚀 AB DASHBOARD PE JAO
    if(profileCompleted == true){
      Get.offAllNamed('bottomnavigationbar');
    }
    else{
      // Get.offAllNamed('/addprofilepicture');
      controller.isUser.value == true ?
      onboardingStep(): onboardingStepHost();
    }
    // Get.offAllNamed('/addprofilepicture');
    // print("🎉 SIGNUP SUCCESS → ${data["email"]}");
  }
  Future<void> onboardingStep() async {
    // final step = controller.controller.getMyProfileModel.value?.data?.onboardingStep;
    print("Step Step Step: $step");

    if (step == null) return;

    if (step == 0) {
      Get.toNamed("addprofilepicture");
    } else if (step == 1) {
      Get.toNamed("allergiesdietryscreen");
    } else if (step == 2) {
      Get.toNamed("foodpreferencesone");
    } else if (step == 3) {
      Get.toNamed("foodpreferencestwo");
    } else {
      Get.toNamed("bottomnavigationbar"); // fallback
    }
  }
  Future<void> onboardingStepHost() async {
    // final step = controller.controller.getMyProfileModel.value?.data?.onboardingStep;
    print("Step Step Step: $step");

    if (step == null) return;

    if (step == 0) {
      Get.toNamed("addprofilepicture");
    } else if (step == 1) {
      Get.toNamed("bottomnavigationbar"); // fallback
    } else {
      Get.toNamed("bottomnavigationbar"); // fallback
    }
  }
}
