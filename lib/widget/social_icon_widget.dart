import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget socialIconWidget(
    String text,
    String path, {
      double? height,
      double? width,
      Color? borderColor, // Optional border color
      double borderWidth = 1.0, // Optional border width
    }) {
  return Container(
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
    child: Row(
      children: [
        Image.asset(path, height: 32, width: 32),
        SizedBox(width: 5.w),
        Expanded(
          child: customText(
            text: text,
            fontSize: 16.sp,
          ),
        ),
      ],
    ),
  );
}
