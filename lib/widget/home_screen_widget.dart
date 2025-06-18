import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'button_widget.dart';

Widget invitationWidget(
    String? eventName,
    String? attend,
    String? place,
    String? date,
    String? imagepath,
    ) {
  return Container(
    height: 20.h,
    width: 90.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.sp), // made responsive
      color: whiteColor
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/png/dinner_profile.png",
                height: 2.h,
                width: 4.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: customText(
                  text: "Joseph Kindario Invited You to",
                  fontSize: 13.sp,
                  color: blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagepath!,
                height: 5.h,
                width: 10.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: eventName,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: blackColor,
                      fontFamily: "CormorantGaramond",
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customText(
                            text: place,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: customText(
                            text: date,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.8.h),
                  child: customText(
                    text: attend,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
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
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonWidget(
                height: 4.h,
                width: 18.h,
                "Accept",
                whiteColor,
                fontsize: 14.sp,
                colors: blueColor,
                onTap: () {},
              ),
              SizedBox(width: 1.h),
              buttonWidget(
                height: 4.h,
                width: 18.h,
                "Not Now",
                fontsize: 14.sp,
                blueColor,
                colors: blueColor.withAlpha(50),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget upComingEventWidget({double? width,double? height}) {
  return Container(
    height: height!=null ? height : 41.h,
    width: width!=null ? width : 65.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      color: whiteColor
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
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
              Divider(),
              buildEventRow("Name:", "April 30, 2025"),
              Divider(),
              buildEventRow("Time:", "7:30pm"),
              Divider(),
              buildEventRow("Host Name:", "Sophia Andreas"),
              Divider(),
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

Widget buildEventRow(String title, String text,{double? textSize}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      customText(
        text: title,
        fontSize: textSize!=null ? textSize : 13.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey[800],
      ),
      customText(
        text: text,
        fontSize: textSize!=null ? textSize : 13.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey[800],
      ),
    ],
  );
}

Widget homeIconWidget({
  IconData? icon,
  String? imagePath,
  VoidCallback? onTap,
  double? iconsize,
  Color? color,
}) {
  return Container(
    height: 4.2.h,
    width: 9.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: color ?? whiteColor.withAlpha(40),
    ),
    child: Center(
      child: GestureDetector(
        onTap: onTap,
        child: icon != null
            ? Icon(
          icon,
          color: whiteColor,
          size: iconsize ?? 20.sp,
        )
            : imagePath != null
            ? Image.asset(
          imagePath,
          width: iconsize ?? 18.sp,
          color: whiteColor, // optional: color tint
        )
            : const SizedBox.shrink(), // fallback if both null
      ),
    ),
  );
}

