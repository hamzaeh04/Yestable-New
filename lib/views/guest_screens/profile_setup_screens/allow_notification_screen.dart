import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/widget/animated_button.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/picture_upload_bottomsheet.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../widget/button_widget.dart';

class AllowNotificationScreen extends StatelessWidget {
  AllowNotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // outer column alignment
          children: [
            SizedBox(height: 2.h),
            // Progress bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: authController.controller.isUser.value == true ? loadingStepIndicator("6/6", 10): loadingStepIndicator("3/3", 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "Stay In The Know",
                fontSize: 22.sp,
                fontFamily: "CormorantGaramond",
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "We'll send you important reminders \nand updates!",
                fontSize: 15.sp,
                fontFamily: "WorkSans",
                fontWeight: FontWeight.w500,
                color: greyTextColor,
              ),
            ),
            SizedBox(height: 7.h),
            Container(
              height: 39.h,
              width: double.infinity,
              child: Image.asset(
                "assets/png/new_guest_illustrations/allow_notification_banner.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // <-- add this
                children: [
                  SizedBox(height: 5.h),
                  animatedButton((){
                    authController.controller.isUser.value == true ?
                    Get.toNamed("profilecompletescreen"): Get.toNamed('bottomnavigationbar');
                  }, "Allow Notifications"),
                  buttonWidget(
                    "Maybe Later",
                    greenColor,
                    borderColor: greenColor,
                    onTap: () {},
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
