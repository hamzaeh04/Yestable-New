import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'home_screen_widget.dart';

Widget eventScreenWidget() {
  return Container(
    height: 37.h,
    width: 65.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      color: whiteColor.withOpacity(0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
            bottomLeft: Radius.circular(18.sp), // More rounded bottom
            bottomRight: Radius.circular(18.sp), // More rounded bottom
          ),
          child: Container(
            width: double.infinity,
            height: 16.h,
            child: Image.asset(
              "assets/png/upcoming_event_banner.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: "Sophia Dinner Event",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
                color: blackColor,
              ),
              customText(
                text: "132 My Street, Kingston, New York124",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
              SizedBox(height: 1.h),
              buildEventRow("Name:", "April 30, 2025"),
              SizedBox(height: 1.h),
              buildEventRow("Time:", "7:30pm"),
              SizedBox(height: 1.h),
              buildEventRow("Host Name:", "Sophia Andreas"),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Dietary Compatibility Score",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                  customText(
                    text: "95%",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: greenColor,
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: LinearProgressIndicator(
                  minHeight: 0.7.h,
                  value: 0.95,
                  valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
