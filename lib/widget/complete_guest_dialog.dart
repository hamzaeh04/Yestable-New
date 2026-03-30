import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/constants_widgets.dart';

void completeGuestProfileDialog(BuildContext context) {
  NavigationController navigationController = Get.find<NavigationController>();
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
            // ✅ MAIN CONTENT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/png/complete_profile_img.png",
                    width: 25.w,
                  ),

                  SizedBox(height: 2.h),

                  customText(
                    text: "Setup Your Guest Profile",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),

                  SizedBox(height: 1.h),

                  customText(
                    text:
                    "Set up your guest profile to get event invites, explore, and more!",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 2.h),

                  buttonWidget(
                    "Setup Now",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      Get.toNamed("allergiesdietryscreen");
                      navigationController.controller.isEdit.value = true;
                    },
                  ),
                ],
              ),
            ),

            // ❌ CLOSE ICON (TOP RIGHT)
            Positioned(
              top: 2.h,
              right: 2.h,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
