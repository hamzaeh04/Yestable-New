import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget loadingStepIndicator(String? step, double? loadingvalue){
  return
    Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            backgroundColor: whiteColor, // Track color
            color: greenColor,            // Progress color
            value: loadingvalue,
            minHeight: 0.7.h,
            borderRadius: BorderRadius.circular(10.sp),
          ),
        ),
        SizedBox(width: 2.w),

        // Wrap flower image in Stack to overlay text
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/png/flower.png",
              height: 5.h, // was 10.h
              width: 10.w,
            ),
            customText(
              text: '$step',
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
}
