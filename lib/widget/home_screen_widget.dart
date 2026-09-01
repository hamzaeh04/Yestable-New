import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/components/common_image_view.dart';
import 'package:yestable/widget/custom_image_widget.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'button_widget.dart';

Widget invitationWidget(
  String? eventName,
  String? time,
  String? place,
  String? date,
  String? eventImage,
    int? dietryScore,
    String? hostImage, {
    String? invitedByName,
  VoidCallback? onAccept,
  VoidCallback? onReject,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.sp), // made responsive
      color: whiteColor,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.sp),
                child: hostImage != null
                    ? CommonImageView(
                  url: "${baseService.baseURL}${hostImage}",
                  height: 2.5.h,
                  width: 5.w,
                )
                    : Image.asset(
                  "assets/png/dinner_profile.png",
                  height: 2.h,
                  width: 4.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: customText(
                  text:
                      "${invitedByName ?? "Someone"} Invited You to join their event..",
                  fontSize: 14.sp,
                  color: darkGreyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.sp),
                child:
                    (eventImage == null || eventImage.isEmpty)
                        ? Image.asset(
                          "assets/png/dinner_event.png",
                          height: 4.5.h,
                          width: 10.w,
                          fit: BoxFit.cover,
                        )
                        : CommonImageView(
                          url: "${baseService.baseURL}${eventImage}",
                          height: 5.h,
                          width: 10.w,
                        ),
              ),
              SizedBox(width: 2.w),
              customText(
                text: eventName,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: blackColor,
                overFlow: TextOverflow.ellipsis, // fix typo
              ),
            ],
          ),
          SizedBox(height: 1.h),
          customText(
            text: "Address: ${place}",
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
          SizedBox(width: 2.w),
          customText(
            text: "Time: ${date} - ${time}",
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
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
              Row(
                children: [
                  customText(
                    text: dietryScore.toString() ?? "88",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: greenColor,
                    fontFamily: "CormorantGaramond",
                  ),
                  customText(
                    text: "%", // example of another item in the row
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: greenColor,
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
              value: dietryScore! / 100,
              valueColor: AlwaysStoppedAnimation<Color>(greenColor),
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(height: 1.25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: buttonWidget(
                  height: 4.h,
                  "Accept",
                  whiteColor,
                  fontsize: 14.sp,
                  colors: blueColor,
                  onTap: onAccept ?? () {},
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: buttonWidget(
                  height: 4.h,
                  "Reject",
                  fontsize: 14.sp,
                  blueColor,
                  colors: blueColor.withAlpha(50),
                  onTap: onReject ?? () {},
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget upComingEventWidget({
  double? width,
  double? height,
  required String eventName,
  required String eventLocation,
  required String eventDate,
  required String eventTime,
  required String eventHost,
  String? image,
  required String dietryscore,
}) {
  return Container(
    // height: height!=null ? height : 50.h,
    width: width != null ? width : 65.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      color: whiteColor,
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: eventName,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
              customText(
                text: eventLocation,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
              Divider(),
              buildEventRow("Date:", eventDate),
              Divider(),
              buildEventRow("Time:", eventTime),
              Divider(),
              buildEventRow("Host Name:", eventHost),
              Divider(),
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
                        text: dietryscore ?? "95",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
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
                  minHeight: 0.7.h,
                  value: double.parse(dietryscore) / 100 ?? 0.95,
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

Widget buildEventRow(
  String title,
  String text, {
  double? textSize,
  String? path,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if (path != null) ...[
        Row(
          children: [
            Image.asset(
              path ?? "assets/png/event_widget_icon/calender_icon.png",
              height: 12.sp,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 2.w),
            customText(
              text: title,
              fontSize: textSize != null ? textSize : 13.sp,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
          ],
        ),
      ] else
        customText(
          text: title,
          fontSize: textSize != null ? textSize : 13.sp,
          fontWeight: FontWeight.w400,
          color: blackColor,
        ),
      customText(
        text: text,
        fontSize: textSize != null ? textSize : 13.sp,
        fontWeight: FontWeight.w400,
        color: blackColor,
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
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 4.2.h,
      width: 9.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color ?? whiteColor.withAlpha(40),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, color: whiteColor, size: iconsize ?? 20.sp)
            : imagePath != null
            ? Image.asset(
              imagePath,
              width: iconsize ?? 18.sp,
              color: whiteColor, // optional: color tint
            )
            : const SizedBox.shrink(),
      ),
    ),
  );
}
