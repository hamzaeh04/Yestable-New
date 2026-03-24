import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Image.asset("assets/png/yestable_updated_logo.png",height: 22.h,width: 22.w),
            ),
            Container(
              height: 32.h,
                width: double.infinity,
                child: Image.asset("assets/png/new_guest_illustrations/get_started_banner.png",
                  fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 2.h),
            customText(
              text: "Welcome To YesTable",
              fontSize: 23.sp,
              fontFamily: "CormorantGaramond",
              fontWeight: FontWeight.w600
            ),
            customText(
              text: "Got Allergies? Picky Eaters? Friends Who Go\nGluten-Free For Fun?",
              fontSize: 15.sp,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.5.h),
            customText(
              text: "We’ve Got You. Join As A Guest Or Host, And Let The\nPlanning Feel Joyful Again.",
              fontSize: 15.sp,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h), // Adjust as needed
              child: buttonWidget(
                "I’m A Guest",
                whiteColor,
                colors: greenColor,
                onTap: () {
                  controller.isLoggedIn.value = true;
                  controller.isUser.value = true;
                  print(controller.currentIndex.value);
                  Get.toNamed('signupscreen');
                  authController.emailController.clear();
                  authController.verificationCode.value = '';
                  controller.onGuestClick();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w), // Adjust as needed
              child: buttonWidget(
                "I’m A Host",
                greenColor,
                borderColor: greenColor,
                onTap: () {
                  controller.switchUser();
                  Get.toNamed('signupscreen');
                  authController.emailController.clear();
                  authController.verificationCode.value = '';
                  controller.onHostClick();
                },
              ),
            ),
      SizedBox(height: 1.h),
            customText(
              text: "RSVPlease: Your New Magic Wand For\nGetting Together!",
              fontSize: 14.5.sp,
              fontFamily: "WorkSans2",
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
