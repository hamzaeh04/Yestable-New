import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';

import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/png/new_guest_illustrations/new_verification_banner.png",
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 2,
                  left: 65,
                  child: Image.asset(
                    "assets/png/updated_banner/yes_logo.png",
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Verification Code",
                    fontSize: 24.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      customText(
                        text: "Sent to +1*** **** **92",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor
                      ),
                      SizedBox(width: 3.w),
                      customText(
                        text: "Resend",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: blueColor
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      customText(
                          text: "Don’t have access to this Phone Number?",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: greenColor,
                          decoration: TextDecoration.underline,
                          decorationColor: greenColor,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(2.w),
                      fieldHeight: 6.h,
                      fieldWidth: 13.w,
                      activeColor: greenColor,
                      selectedColor: greenColor,
                      inactiveColor: Colors.grey,
                    ),
                    onChanged: (value) {
                      print("OTP: $value");
                    },
                  ),

                  SizedBox(height: 27.5.h),
                  buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      if(controller.isUser.value == true){
                        Get.toNamed('addprofilepicture');
                      }
                      else{
                        Get.toNamed("addhostprofilepicture");
                      }

                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
