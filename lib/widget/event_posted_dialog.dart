import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';

import '../constants/constants_widgets.dart';

void eventPostedDialog(BuildContext context) {
  final NavigationController controller = Get.find<NavigationController>();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFFFDF3F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spacer for cross icon
                  SizedBox(height: 2.h),

                  // Main image
                  Image.asset("assets/png/event_posted_img.png", width: 25.w),

                  SizedBox(height: 2.h),

                  // Title
                  customText(
                    text: "Published Safely!",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: "CormorantGaramond",
                  ),

                  SizedBox(height: 1.h),

                  // Subtitle
                  customText(
                    text: "We’ve scanned for allergens. Guests can now RSVP and share dietary needs.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Close Icon Button
            Positioned(
              top: 2.h,
              right: 2.h,
              child: GestureDetector(
                onTap: () {
                  Get.back();
      },
                child: Icon(Icons.close, size: 20.sp, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  );
}

