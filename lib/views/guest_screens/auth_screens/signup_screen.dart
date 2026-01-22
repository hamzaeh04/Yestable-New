import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/constants/image_constants.dart';

import '../../../constants/color_constants.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/custom_phone_feild.dart';
import '../../../widget/social_icon_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  text: "Sign Up Now",
                  fontSize: 23.sp,
                  fontFamily: "CormorantGaramond",
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 2.h),
                CustomPhoneInput(),
                SizedBox(height: 2.h),
                buttonWidget(
                  "Continue",
                  whiteColor,
                  colors: greenColor,
                  onTap: () {
                    Get.toNamed('verificationcodescreen');
                  },
                ),
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
                      customText(
                        text: "PRIVACY POLICY",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.5.sp,
                        color: greenColor,
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
    );
  }
}
