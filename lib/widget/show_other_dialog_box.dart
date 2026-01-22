import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import 'button_widget.dart';

void showCustomOtherDialog({
  required TextEditingController controller,
  required RxBool shareWithHost,
  required VoidCallback onDone,
  String description = "This info stays private unless you choose to share it with a host.",
  String hintText = "Lorem ipsum dolor sit amet consectetur. Nec arcu enim consequat pulvinar proin urna ac tempus. Nulla viverra dui tellus nisi mont es sit tellus ac pellentesque.",
}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(4.w),
      content: Obx(
            () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title Row with Close Icon ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: customText(
                    text: "Not on the list? Tell us\nwhat to skip!",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "CormorantGaramond",
                    height: 0.13.h,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Icon(Icons.close, color: blackColor),
                  ),
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // ── Description ──
            customText(
              text: description,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),

            SizedBox(height: 2.h),

            // ── Input Field ──
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 14.sp, fontFamily: "WorkSans"),
                filled: true,
                fillColor: backgroundColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF5D8783), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF5D8783), width: 0.2.w),
                ),
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                //   borderSide: BorderSide(color: Color(0xFF5D8783), width: 0.2.w),
                // ),
              ),
            ),

            SizedBox(height: 1.h),

            // ── Toggle ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                  text: "Share With Host",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: shareWithHost.value,
                    onChanged: (value) => shareWithHost.value = value,
                    activeColor: blackColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // ── Done Button ──
            Align(
              alignment: Alignment.centerLeft,
              child: buttonWidget(
                "Done!",
                whiteColor,
                height: 4.h,
                width: 24.w,
                fontsize: 15.sp,
                colors: blueColor,
                onTap: () {
                  onDone();
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
