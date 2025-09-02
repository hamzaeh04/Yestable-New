import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void updateSentSuccessfull(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w), // 👈 Add this line
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Container(
                  height: 20.w,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: containerBlueColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/png/update_successfull_icon.png",
                      width: 12.w, // Smaller than container size
                      height: 12.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 1.h),
                    customText(
                      text: "Success!",
                      fontWeight: FontWeight.w600,
                      fontSize: 21.sp,
                      fontFamily: "CormorantGaramond",
                    ),
                    SizedBox(height: 1.h),
                    customText(
                        text: "Your profile updates have been shared with the selected host(s)",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 2.h),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    ),
  );
}

