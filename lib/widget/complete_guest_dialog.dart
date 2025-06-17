import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/button_widget.dart';

import '../constants/constants_widgets.dart';

void completeGuestProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Color(0xFFFDF3F1), // Soft background color like the image
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp), // Rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Arrow Icon
              Image.asset("assets/png/complete_profile_img.png",width: 25.w),

              SizedBox(height: 2.h),

              // Title
              customText(
                text: "Setup Your Guest Profile",
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: "CormorantGaramond",
              ),

              SizedBox(height: 1.h),

              // Subtitle
              customText(
                  text: "Set up your guest profile to get event invites, explore, and more!",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: darkGreyColor,
                  textAlign: TextAlign.center
              ),
              SizedBox(height: 2.h),
              buttonWidget("Setup Now", whiteColor,colors: greenColor,onTap: (){
                Get.toNamed("allergieshostscreen");
              })
            ],
          ),
        ),
      );
    },
  );
}
