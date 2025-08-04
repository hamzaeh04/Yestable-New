import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';

import '../constants/constants_widgets.dart';

Widget extraAssistanceDropdown(ProfileController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customText(
        text: "May Need Extra Assistance",
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      SizedBox(height: 1.h),
      GestureDetector(
        onTap: controller.toggleDropdown,
        child: Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                text: controller.selectedOption.value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              AnimatedRotation(
                turns: controller.isExpanded.value ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),
        )),
      ),
      Obx(() => controller.isExpanded.value
          ? Container(
        margin: EdgeInsets.only(top: 1.h),
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.options.length,
          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[300]),
          itemBuilder: (_, index) {
            final value = controller.options[index];
            return InkWell(
              onTap: () => controller.selectOption(value),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (value == "Other")
                          Icon(Icons.edit, size: 16.sp, color: Colors.black),
                        if (value == "Other") SizedBox(width: 2.w),
                        customText(
                          text: value,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    if (controller.selectedOption.value == value)
                      Icon(Icons.check, color: Colors.black, size: 16.sp),
                  ],
                ),
              ),
            );
          },
        ),
      )
          : const SizedBox.shrink()),
    ],
  );
}
