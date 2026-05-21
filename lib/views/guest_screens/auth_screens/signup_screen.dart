import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/constants/image_constants.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/widget/animated_button.dart';

import '../../../constants/color_constants.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/custom_phone_feild.dart';
import '../../../widget/social_icon_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/png/new_guest_illustrations/signup_screen_banner.png",
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
                // Positioned(
                //   top: 4.2.h,
                //   left: 18.w,
                //   child: Image.asset(
                //     "assets/png/updated_banner/yes_logo.png",
                //     height: 22.h,
                //     width: 22.w,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 4.h),
                  customText(
                    text: "Login Now",
                    fontSize: 23.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  // CustomPhoneInput(),
                  signupEmailField(),
                  SizedBox(height: 2.h),
                  // buttonWidget(
                  //   "Continue",
                  //   whiteColor,
                  //   colors: greenColor,
                  //   onTap: () {
                  //     Get.toNamed('verificationcodescreen');
                  //   },
                  // ),
                  animatedButton(() async {
                    if(controller.controller.isUser.value == true ){
                      if (controller.emailController.text.trim().isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please fill all required fields",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 8,
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        await controller.passwordLessLogin();
                      }
                    }
                    else{
                      if (controller.emailController.text.trim().isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please fill all required fields",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 8,
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        await controller.passwordLessLogin();
                      }
                    }
                  }, "Continue"),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: blueColor,
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: customText(
                          text: "OR",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: blueColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      socialIconWidget("Google", '$google',width: 40.w,borderColor: greenColor,borderWidth: 0.17.w),
                      socialIconWidget("Apple ID", '$apple',width: 40.w,borderColor: greenColor,borderWidth: 0.17.w),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  customText(
                      text: "By Continuing, You agree To Our",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.4.sp,
                    color: greenColor,
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 1.3.h, // Make sure there's enough height for the divider
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: "TERMS OF SERVICE",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.5.sp,
                          color: greenColor,
                        ),
                        VerticalDivider(
                          color: greenColor,
                          thickness: 1,
                          width: 20,
                        ),
                        InkWell(
                          onTap: (){
                            Get.toNamed("privacypolicy");
                          },
                          child: customText(
                            text: "PRIVACY POLICY",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.5.sp,
                            color: greenColor,
                          ),
                        ),
                        VerticalDivider(
                          color: greenColor,
                          thickness: 1,
                          width: 20,
                        ),
                        customText(
                          text: "CONTENT POLICIES",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.5.sp,
                          color: greenColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget signupEmailField(){
  final AuthController controller = Get.find<AuthController>();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w),
    decoration: BoxDecoration(
      border: Border.all(color: greenColor,width: 0.17.w),
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: TextField(
      // controller: controller.controller.isUser == true? controller.emailController: controller.emailController,
      controller: controller.emailController,
      style: TextStyle(fontSize: 15.sp,color: blackColor,fontFamily: "WorkSans"),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter Your Email',
        hintStyle: TextStyle(color: blackColor,fontFamily: "WorkSans"),
      ),
    ),
  );
}
