import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart'; // For responsiveness // Assuming greenColor is defined here
import 'package:yestable/controllers/auth_controller.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';// Assuming customText is defined here

class CustomPhoneInput extends StatelessWidget {
  final AuthController controller = Get.find();

  CustomPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          // Country Picker
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: controller.changeCountry,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.05.h),
              decoration: BoxDecoration(
                border: Border.all(color: greenColor,width: 0.17.w),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                children: [
                  customText(
                    text: controller.selectedCountry.value.flagEmoji,
                    fontSize: 23.sp,
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 16.sp),
                ],
              ),
            ),
          ),
          SizedBox(width: 3.w),
          // Phone Number Input
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: greenColor,width: 0.17.w),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                children: [
                  customText(
                    text: '+${controller.selectedCountry.value.phoneCode}',
                    fontSize: 16.sp,
                    color: blackColor,
                  ),
                  SizedBox(width: 4.w),

                  Expanded(
                    child: TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: 15.sp,color: blackColor,fontFamily: "WorkSans"),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Phone Number',
                        hintStyle: TextStyle(color: blackColor,fontFamily: "WorkSans"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
