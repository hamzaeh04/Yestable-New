import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'event_widget.dart';
import 'home_screen_widget.dart';

void showEventDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 95.w,
          constraints: BoxConstraints(
            maxHeight: 60.h, // Limit max height to allow scrolling
          ),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: whiteColor.withOpacity(0.95),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: "May 02, 2025",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "CormorantGaramond",
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                          child: Icon(Icons.close,size: 18.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.sp),
                        color: blueColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        child: customText(
                          text: "In 4 Hrs",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("eventdetailsscreen");
                        },
                        child: eventScreenWidget(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.sp),
                        color: blueColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        child: customText(
                          text: "In 4 Hrs",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("eventdetailsscreen");
                        },
                        child: eventScreenWidget(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


