import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';

Widget buttonWidget(
    String text,
    Color textColor, {
      Color? colors,
      double? height,
      double? width,
      VoidCallback? onTap,
      IconData? icon,
      Color? borderColor,
      double? fontsize// 👈 Optional border color
    }) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 5.5.h,
      width: width ?? 100.w,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(20.sp),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.2)
            : null, // 👈 Apply only if given
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
                size: 16.sp,
              ),
              SizedBox(width: 2.w),
            ],
            customText(
              text: text,
              fontSize: fontsize != null ? fontsize : 17.sp,
              fontFamily: 'WorkSans',
              color: textColor,
              fontWeight: FontWeight.w500
            ),
          ],
        ),
      ),
    ),
  );
}
