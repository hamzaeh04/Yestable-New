import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/welcome_controller.dart';

class SplashTwo extends StatelessWidget {
  const SplashTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WelcomeController("getstarted"), tag: "splash2");



    return Scaffold(
      body: Stack(
        children: [
          // Yestable logo positioned a bit from top, centered
          Positioned(
            top: 10.h,
            left: (100.w - 30.w) / 2,
            child: Image.asset(
              "assets/png/yestable_logo.png",
              height: 33.h,
              width: 30.w,
            ),
          ),
          // Splash banner aligned at the bottom, no blur here
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/png/new_guest_illustrations/yestable_splash_banner.png",
              fit: BoxFit.cover,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}
