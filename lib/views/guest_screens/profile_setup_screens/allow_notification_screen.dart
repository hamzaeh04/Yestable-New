import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/picture_upload_bottomsheet.dart';

import '../../../controllers/notification_controller.dart';
import '../../../widget/button_widget.dart';

class AllowNotificationScreen extends StatelessWidget {
  AllowNotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();

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
              child: loadingStepIndicator("6/6", 10),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    // Adjust as needed
                    // child: buttonWidget(
                    //   "Allow Notifications",
                    //   whiteColor,
                    //   colors: greenColor,
                    //   onTap: () {
                    //     Get.toNamed("profilecompletescreen");
                    //   },
                    // ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed("profilecompletescreen");
                      },
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 5.5.h,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            gradient: LinearGradient(
                              begin:
                              controller.isHorizontal.value
                                      ? Alignment.centerLeft
                                      : Alignment.topCenter,
                              end:
                              controller.isHorizontal.value
                                      ? Alignment.centerRight
                                      : Alignment.bottomCenter,
                              colors: const [
                                Color(0xFFFFC72C),
                                Color(0xFF4CAF50),
                                Color(0xED008809),
                                Color(0xED008809),
                                Color(0xFF88C713),
                                Color(0xFFFF6200),
                              ],
                            ),
                          ),
                          child: customText(
                            text: 'Allow Notifications',
                            color: Colors.white,
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
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
