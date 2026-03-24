import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/views/guest_screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:yestable/widget/button_widget.dart';

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
        child: SizedBox(
          height: 32.h, // ✅ Height thodi barha di hai button accommodate karne ke liye
          width: 75.w,
          child: Stack(
            children: [
              // ✅ CLOSE ICON (Top Right)
              Positioned(
                top: 1.5.h,
                right: 1.5.h,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 18.sp),
                ),
              ),

              // ✅ MAIN CONTENT
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/png/event_posted_img.png",
                        width: 25.w,
                      ),
                      SizedBox(height: 2.h),
                      customText(
                        text: "Published",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "CormorantGaramond",
                      ),
                      SizedBox(height: 1.h),
                      customText(
                        text: "Let the RSVpleases roll in!",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ OK BUTTON (Bottom Center)
              Positioned(
                bottom: 2.h,
                left: 10.w,
                right: 10.w,
                child: buttonWidget(
                  "Ok",
                  whiteColor,
                  colors: greenColor,
                  borderColor: greenColor,
                  height: 4.5.h,
                  fontsize: 14.sp,
                  onTap: () {
                    // 1. Dialog band karein
                    Get.back();

                    // 2. Dashboard pe jayein
                    Get.to(() => CustomBottomNavBar());

                    // 3. Sabse zaroori: Controller ko update karne ke liye chota sa delay dein
                    // Isse "Build scheduled during frame" wala error khatam ho jayega
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.changePage(0);
                    });
                  },
                ),
              ),
              /// 🎉 CELEBRATION GIF (OVERLAY)
              Positioned(
                top: 0.h, // adjust for perfect overlap
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/png/get_started.gif',
                    width: 45.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],

          ),
        ),
      );
    },
  );
}
