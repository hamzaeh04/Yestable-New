import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';



Widget socialIconWidget(
    String text,
    String path, {
      double? height,
      double? width,
      Color? borderColor,
      double borderWidth = 1.0,
      VoidCallback? ontap
    }) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: height ?? 5.5.h,
      width: width ?? 100.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min, // 👈 important
          children: [
            Image.asset(path, height: 24, width: 24),
            SizedBox(width: 3.w),
            customText(
              text: text,
              fontSize: 16.sp,
            ),
          ],
        ),
      ),
    ),
  );
}
