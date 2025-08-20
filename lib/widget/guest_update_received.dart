import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void guestUpdateReceived(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Centered icon
            Center(
              child: Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  color: containerBlueColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "assets/png/you_are_invited_bellicon.png",
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// Centered heading
            Center(
              child: customText(
                text: "Guest Update Received",
                fontWeight: FontWeight.w600,
                fontSize: 21.sp,
                fontFamily: "CormorantGaramond",
              ),
            ),

            SizedBox(height: 2.h), // 👈 extra padding after heading

            /// Left-aligned content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customText(
                        text: "Sarah Johnson",
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: "has updated their profile.",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "Relevant to your event(s):",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                    color: greenColor
                  ),
                  customText(
                    text: "Emma's Dinner Party – Nov 24",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  customText(
                    text: "Thanksgiving at David's – Nov 28",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "These updates may include dietary preferences, allergies, or contact info.",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(child: buttonWidget("View Profile", whiteColor,colors: greenColor,fontsize: 15.sp,height: 4.5.h)),
                      SizedBox(width: 4.w),
                      Expanded(child: buttonWidget("Dismiss", greenColor,colors: backgroundColor,borderColor: greenColor,fontsize: 15.sp,height: 4.5.h,onTap: (){
                        Get.back();
                      }))

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


