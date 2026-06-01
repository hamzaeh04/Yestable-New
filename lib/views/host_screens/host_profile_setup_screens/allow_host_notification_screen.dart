import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/picture_upload_bottomsheet.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/share_profile_widget.dart';

class AllowHostNotificationScreen extends StatelessWidget {
  const AllowHostNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // outer column alignment
          children: [
            SizedBox(height: 2.h),
            // Progress bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: loadingStepIndicator("3/3", 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "Stay In The Know",
                fontSize: 24.sp,
                fontFamily: "CormorantGaramond",
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "We'll send you important reminders about your Food Events not too many, and not too often.",
                fontSize: 16.sp,
                fontFamily: "CormorantGaramond",
                fontWeight: FontWeight.w600,
                  color: greyTextColor

              ),
            ),
            SizedBox(height: 5.h),
            Container(
              height: 39.h,
              width: double.infinity,
              child: Image.asset("assets/png/new_guest_illustrations/allow_notification_banner.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // <-- add this
                children: [
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h), // Adjust as needed
                    child: buttonWidget(
                      "Allow Notifications",
                      whiteColor,
                      colors: greenColor,
                      onTap: () {
                        // Get.toNamed("bottomnavigationbar");
                        showShareProfileDialog(context);
                      },
                    ),
                  ),
                  buttonWidget(
                    "Maybe Later",
                    greenColor,
                    borderColor: greenColor,
                    onTap: () {
                      // Get.toNamed("bottomnavigationbar");
                      showShareProfileDialog(context);
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
