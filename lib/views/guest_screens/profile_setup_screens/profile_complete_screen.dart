import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';

class ProfileCompleteScreen extends StatelessWidget {
  const ProfileCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
              text: "Yes You did it!",
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
              child: Image.asset("assets/png/new_guest_illustrations/yestable_notification_banner.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w), // Adjust as needed
              child: buttonWidget(
                "Allow Notification",
                whiteColor,
                colors: greenColor,
                onTap: () {
                  Get.toNamed('bottomnavigationbar');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
