import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/widget/custom_image_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'home_screen_widget.dart';

Widget eventScreenWidget({
  String? image,
  Color? bgcolor,
  required String eventName,
  required String eventLocation,
  required String eventDate,
  required String eventTime,
  required String eventHost,
  required String estimatedGuest,
  required String joinedGuest,
  required double value
}) {
  final NavigationController controller = Get.find<NavigationController>();
  BaseService baseService = BaseService();
  return Container(
    width: 65.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      color: bgcolor != null ? bgcolor : whiteColor.withOpacity(0.8),
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
            child:
                (image == null || image.isEmpty)
                    ? Image.asset(
                      "assets/png/upcoming_event_banner.png",
                      fit: BoxFit.cover,
                    )
                    : customImageWidget(imagePath: image),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: eventName,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "CormorantGaramond",
                    color: blackColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/png/event_widget_icon/location_icon.png",
                        height: 12.sp,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: customText(
                          text: eventLocation,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                          maxLines: 3,
                          overFlow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  buildEventRow(
                    "Date:",
                    eventDate,
                    path: "assets/png/event_widget_icon/calender_icon.png",
                  ),
                  SizedBox(height: 1.h),
                  buildEventRow(
                    "Time:",
                    eventTime,
                    path: "assets/png/event_widget_icon/clock_icon.png",
                  ),
                  SizedBox(height: 1.h),
                  buildEventRow(
                    "Host Name:",
                    eventHost,
                    path: "assets/png/event_widget_icon/profile_icon.png",
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Dietary Compatibility Score",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: blueColor,
                      ),
                      Row(
                        children: [
                          customText(
                            text: "${value * 100}",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: blueColor,
                            fontFamily: "CormorantGaramond",
                          ),
                          customText(
                            text: "%", // example of another item in the row
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: blueColor,
                            fontFamily: "CormorantGaramond",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: LinearProgressIndicator(
                      minHeight: 0.6.h,
                      value: value,
                      valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                      backgroundColor: whiteColor,
                    ),
                  ),

                  if (controller.isUser.value == false)
                    Column(
                      children: [
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text: "RSVP",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                            customText(
                              text: "(${joinedGuest ?? 0}/${estimatedGuest ?? 0})",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: greenColor,
                              fontFamily: "CormorantGaramond",
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: LinearProgressIndicator(
                            minHeight: 0.6.h,
                            value: double.parse(joinedGuest) / 100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              blueColor,
                            ),
                            backgroundColor: whiteColor,
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Divider(),
          ],
        ),
      ],
    ),
  );
}
