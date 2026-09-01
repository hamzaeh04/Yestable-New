import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget loadingStepIndicator(String? step, double? loadingvalue){
  return Row(
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.sp),
          child: LinearProgressIndicator(
            backgroundColor: greyBorderColor.withOpacity(0.4),
            color: greenColor,
            value: (loadingvalue ?? 0).clamp(0.0, 1.0),
            minHeight: 0.7.h,
          ),
        ),
      ),
      SizedBox(width: 3.w),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: customText(
          text: '$step',
          color: whiteColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "WorkSans",
        ),
      ),
    ],
  );
}
