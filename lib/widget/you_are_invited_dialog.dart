import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/update_sent_sucessfull_dialog.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void youAreInvitedDialog(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
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
                      "assets/png/you_are_invited_bellicon.png",
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
                      text: "You’re invited!",
                      fontWeight: FontWeight.w600,
                      fontSize: 21.sp,
                      fontFamily: "CormorantGaramond",
                    ),
                    SizedBox(height: 1.h),
                    customText(
                        text: "Take a minute to share your food preferences, dietary needs, or any accessibility notes.",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 2.h),
                    customText(
                        text: "Take a minute to share your food preferences, dietary needs, or any accessibility notes.",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 2.h),
                    customText(
                        text: "This helps your host set the table for a great time.",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 2.h),
                    buttonWidget("Setup Now", whiteColor,colors: greenColor,fontsize: 16.sp,height: 4.5.h,onTap: (){
                      updateSentSuccessfull(context);
                    }),
                    SizedBox(height: 1.5.h),
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

