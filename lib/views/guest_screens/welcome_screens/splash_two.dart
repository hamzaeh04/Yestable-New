import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/welcome_controller.dart';

import '../../../constants/constants_widgets.dart';

class SplashTwo extends StatelessWidget {
  const SplashTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeController("getstarted"), tag: "splash2");

    return Scaffold(
      body: Stack(
        children: [
          /// Logo
          Positioned(
            top: 10.h,
            left: (100.w - 30.w) / 2,
            child: Image.asset(
              "assets/png/yestable_updated_logo.png",
              height: 33.h,
              width: 30.w,
            ),
          ),

          /// Bottom illustration + text overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  "assets/png/new_guest_illustrations/yestable_splash_banner.png",
                  fit: BoxFit.cover,
                  width: 100.w,
                ),

                /// Text on top of illustration
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: customText(
                    text: "A Product of Siren Theory LLC",
                    fontSize: 15.sp,
                    fontFamily: "WorkSans2",
                    fontWeight: FontWeight.w600,
                    color: splashTwoGreenColor,
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

