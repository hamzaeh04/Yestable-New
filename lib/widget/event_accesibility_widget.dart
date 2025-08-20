import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget eventAccesibillityWidget(String title, {int? index}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h),
    child: GestureDetector(
      onTap: () {
        // your onTap logic
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.sp),
          border: Border.all(
            color: Colors.grey,
            width: 0.1.w,
          ),
        ),
        child: customText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
      ),
    ),
  );
}
