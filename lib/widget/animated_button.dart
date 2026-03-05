import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants_widgets.dart';
import '../controllers/notification_controller.dart';

Widget animatedButton(
    VoidCallback ontap,
    String text,
    ){
  final NotificationController controller = Get.find<NotificationController>();

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: InkWell(
      onTap: ontap,
      child: Obx(
            () => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 5.5.h,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            gradient: LinearGradient(
              begin:
              controller.isHorizontal.value
                  ? Alignment.centerLeft
                  : Alignment.topCenter,
              end:
              controller.isHorizontal.value
                  ? Alignment.centerRight
                  : Alignment.bottomCenter,
              colors: const [
                Color(0xFFFFC72C),
                Color(0xFF4CAF50),
                Color(0xED008809),
                Color(0xED008809),
                Color(0xFF88C713),
                Color(0xFFFF6200),
              ],
            ),
          ),
          child: customText(
            text: text,
            color: Colors.white,
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
