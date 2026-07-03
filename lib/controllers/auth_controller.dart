import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/core/services/apiendpoints.dart';

import '../core/services/base_services.dart';
import '../core/services/login/google_auth_service.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';

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
    await prefs.setString(LocalDBKeys.USEREMAIL, data["user"]["email"] ?? "");
    await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, profileCompleted ?? false);
    await prefs.setString(LocalDBKeys.USERFULLNAME, data["user"]["name"] ?? "");
    await prefs.setString(LocalDBKeys.USERID, data["user"]["_id"] ?? "");
    await prefs.setString(LocalDBKeys.ONBOARDINGSTEP, "${data["user"]["onboardingStep"]}");
    await prefs.setString(LocalDBKeys.USERPROFILEPIC, data["user"]["profilePic"] ?? "");
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
  String googleTokenId = "";
  Future<void> googleLogin(GoogleAuthService authService) async {
    final fcmToken = prefs.getString(LocalDBKeys.FCMTOKEN);
    // Step 1: login
    final body = {
      "idToken": authService.tokenId,
      "fcmToken": fcmToken
    };
    print("Token ID Skurrrrrrrrrrrr: ${googleTokenId}");
    try {
      final response = await baseService.basePostAPI(
        ApiEndPoints.googleLogin,
        body,
        loading: true,
      );

      if (response == false || response == null) {
        Utils.showToast('Check Internet Connection', true);
        return;
      }

      if (response is! Map<String, dynamic>) {
        Utils.showToast('Unexpected response: ${response.toString()}', true);
        return;
      }

      // Use data key
      final data = response['data'];
      if (data == null) {
        Utils.showToast(response['message'] ?? 'Login failed', true);
        return;
      }
      final date = "".obs;
      date.value = response['data']['user']['createdAt'];
      final user = data['user'];
      final token = data['access_token'];
      await prefs.setString(LocalDBKeys.TOKEN, token);
      await prefs.setString(LocalDBKeys.USEREMAIL, data["user"]["email"]);
      await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, data["user"]["profileCompleted"]);
      await prefs.setString(LocalDBKeys.USERFULLNAME, data["user"]["name"] ?? "");
      await prefs.setString(LocalDBKeys.USERID, data["user"]["_id"]);
      await prefs.setString(LocalDBKeys.ONBOARDINGSTEP, "${data["user"]["onboardingStep"]}");
      await prefs.setString(LocalDBKeys.FCMTOKEN, "${data["user"]["fcmTokens"]}");

      if (user == null || token == null) {
        Utils.showToast(response['message'] ?? 'Invalid email or password', true);
        return;
      }
      print("Token ID Skurrrrrrrrrrrr: ${authService.tokenId}");
      // // Save user info
      // final prefs = SharedPreferencesMethod.storage;
      // await prefs.setString(LocalDBKeys.USERDETAIL, jsonEncode(user));
      // await prefs.setString(LocalDBKeys.USERID, user['id'] ?? "");
      await prefs.setString(LocalDBKeys.USERFULLNAME, user['name'] ?? "");
      await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
      await prefs.setString(LocalDBKeys.PHONENUMBER, user['phone'] ?? "");
      await prefs.setString(LocalDBKeys.USERPROFILEPIC, user['profilePicture'] ?? "");
      // await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
      // await prefs.setString(LocalDBKeys.JOINDATE, user['createdAt'] ?? "");
      await prefs.setString(LocalDBKeys.TOKEN, token);

      //
      // print("✅ FCMToken stored successfully: ${LocalDBKeys.FCMTOKEN}");
      // print("✅ Token stored successfully: ${prefs.getString(LocalDBKeys.TOKEN)}");
      print("✅ Token stored successfully: ${authService.tokenId}");

      Utils.showToast(response['message'] ?? 'Login successful', false);

      // Navigate to bottom bar
      if(controller.isUser.value == true){
        if(data['user']['onboardingStep'] == 4 || data['user']['profileCompleted'] == true){
          Get.offAllNamed('/bottomnavigationbar');
        } else{
          Get.offAllNamed('/profileeditscreen');
        }
      } else{
        if(data['user']['onboardingStep'] == 1 || data['user']['profileCompleted'] == true){
          Get.offAllNamed('/bottomnavigationbar');
        } else{
          Get.offAllNamed('/profileeditscreen');
        }
      }
      // Get.offAllNamed('/profileeditscreen');

    } catch (e, stackTrace) {
      print("Login error: $e\n$stackTrace");
      Utils.showToast('Something went wrong. Please try again.', true);
    }
  }

}
