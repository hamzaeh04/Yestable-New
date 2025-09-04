import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../controllers/profile_controller.dart';

Widget customCheckBox(){

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
              color: radioButtonBlueColor,
            ),
            child: Center(child: Icon(Icons.check,size: 14.sp,color: whiteColor))
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
