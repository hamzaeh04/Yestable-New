import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/profile_controller.dart';
import 'button_widget.dart';

void showCustomOtherDialog({
  bool? isFav = false,
  required TextEditingController controller,
  RxBool? shareWithHost, // optional
  VoidCallback? onDone,
  String description =
  "This info stays private unless you choose to share it with a host.",
  String hintText =
  "What to add?",
}) {
  final ProfileController profileController = Get.find<ProfileController>();

  Get.dialog(
    AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(4.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: customText(
                  text: isFav == true ? "Not on the list? Tell us\nyour favorite cuisines!": "Not on the list? Tell us\nwhat to skip!",
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

          // Description
          customText(
            text: description,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),

          SizedBox(height: 2.h),

          // Input Field
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14.sp, fontFamily: "WorkSans"),
              filled: true,
              fillColor: backgroundColor,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF5D8783), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFF5D8783), width: 0.2.w),
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Optional toggle
          if (shareWithHost != null)
            Obx(
                  () => Row(
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
            ),

          SizedBox(height: 1.h),

          // Done Button
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
                  if (onDone != null) onDone();
                  Get.back();
                }
            ),
          ),
        ],
      ),
    ),
  );
}
