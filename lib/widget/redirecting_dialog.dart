import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

void showRedirectingDialog(BuildContext context) {
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
              Image.asset("assets/png/redirect_image.png",width: 25.w),

              SizedBox(height: 2.h),

              // Title
              customText(
                text: "Redirecting to Dialpad.",
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontFamily: "CormorantGaramond",
              ),

              SizedBox(height: 1.h),

              // Subtitle
              customText(
                text: "Please hold on for immediate assistance in an allergy emergency.",
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
                textAlign: TextAlign.center
              ),
            ],
          ),
        ),
      );
    },
  );
}
