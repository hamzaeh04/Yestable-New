import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';

import '../constants/color_constants.dart';

Widget customRadioButton() {
  final ProfileController controller = Get.find<ProfileController>();
  return Obx(() =>
    InkWell(
      onTap: (){
        controller.toggleRadioButton();
      },
      child: controller.isRadioChecked == false ?
      Container(
        height: 4.h,
        width: 4.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: radioButtonBlueColor,
            width: 0.2.w,
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: radioButtonBlueColor
            ),
          ),
        ),
      ):
      Container(
        height: 4.h,
        width: 4.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
        ),
      )
    ),
  );
}
