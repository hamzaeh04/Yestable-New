import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/animated_button.dart';
import 'package:yestable/widget/floating_home_button.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/share_profile_widget.dart';

class ProfileCompleteScreen extends StatelessWidget {
  const ProfileCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      isProfileSetup: true,
      screen: Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(
                  text: "Yes! You did it!",
                  fontSize: 23.5.sp,
                  fontFamily: "CormorantGaramond",
                  fontWeight: FontWeight.w600,
                ),
                customText(
                  text: "You’ve set your seat at the YesTable.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height:7.h),
                Container(
                  height: 45.h,
                  width: double.infinity,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white,


                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.1, 0.9, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      "assets/png/new_guest_illustrations/yes_you_did_It_updated.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w), // Adjust as needed
                  child: animatedButton(() {
                    showShareProfileDialog(context);
                    // Get.offAllNamed('bottomnavigationbar');
                  }, "Get Started"),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              top: -15.h,
              child: Container(
                height: 60.h,
                child: Image.asset(
                            'assets/png/get_started.gif',
                            //width: 10.w,
                            //color: backgroundColor,
                          ),
              ))
        ],
      ),
    ),
    );
  }
}
