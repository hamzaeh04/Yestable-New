import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void updateSentSuccessfull(BuildContext context, {String? desc}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// MAIN CONTENT
          Padding(
            padding: EdgeInsets.only(top: 10.w, left: 4.w, right: 4.w, bottom: 3.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// CIRCLE ICON
                Container(
                  height: 22.w,
                  width: 22.w,
                  decoration: BoxDecoration(
                    color: containerBlueColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/png/update_successfull_icon.png",
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                /// SUCCESS TITLE
                customText(
                  text: "Success!",
                  fontWeight: FontWeight.w600,
                  fontSize: 21.sp,
                  fontFamily: "CormorantGaramond",
                ),

                SizedBox(height: 0.8.h),

                /// DESCRIPTION
                customText(
                  text: desc ??
                      "Your profile updates have been shared with the selected host(s)",
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  fontFamily: "WorkSans",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          /// 🎉 CELEBRATION GIF (OVERLAY)
          Positioned(
            top: -5.w, // minimal top gap
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
}


