import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/share_profile_widget.dart';
import 'package:yestable/widget/floating_home_button.dart';

class HostProfileCompleteScreen extends StatelessWidget {
  HostProfileCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      isProfileSetup: true,
      screen: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customText(
                text: "Yes! You did it!",
                fontSize: 28.sp,
                fontFamily: "CormorantGaramond",
                fontWeight: FontWeight.w600,
              ),
              customText(
                text: "You’ve set your seat at the YesTable.",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height:8.h),
              Container(
                height: 45.h,
                width: double.infinity,
                child: Image.asset("assets/png/new_guest_illustrations/yes_you_did_It_updated.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w), // Adjust as needed
                child: buttonWidget(
                  "Get Started",
                  whiteColor,
                  colors: greenColor,
                  onTap: () {
                    showShareProfileDialog(context);
                    // Get.toNamed('bottomnavigationbar');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
