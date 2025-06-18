import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/profile_controller.dart';

Widget yesNoWidget(int index,{String? title,String? text1,String? text2}) {
  final ProfileController controller = Get.find<ProfileController>();

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? customText(
          text: title,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        )
            : SizedBox.shrink(),

        SizedBox(height: 2.h),
        Obx(() {
          final selected = controller.selectedOptions[index] ?? '';
          return Row(
            children: [
              GestureDetector(
                onTap: () => controller.selectedOptions[index] = 'yes',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    color: selected == "yes" ? greenColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.sp),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        size: 17.sp,
                        color: selected == "yes" ? whiteColor : blackColor,
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: text1 != null ? text1 :"Yes",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: selected == "yes" ? whiteColor : blackColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              GestureDetector(
                onTap: () => controller.selectedOptions[index] = 'no',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    color: selected == "no" ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.sp),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                        size: 18.sp,
                        color: selected == "no" ? whiteColor : blackColor,
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: text2 != null ? text2 :"No",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: selected == "no" ? whiteColor : blackColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    ),
  );
}

Widget foodPreferencesOne(int index, String title, {String? imgpath,double? fontsize}) {
  final ProfileController controller = Get.find<ProfileController>();

  return Obx(() {
    bool isSelected = controller.foodNationality.contains(index);

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.foodNationality.remove(index);
        } else {
          controller.foodNationality.add(index);
        }
      },
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.5.h),
          height: 4.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? greenColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25.sp),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey,
              width: 0.1.w,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imgpath != null) ...[
                Image.asset(
                  imgpath,
                  height: 16.sp,

                ),
                SizedBox(width: 2.w),
              ],
              customText(
                text: title,
                fontSize: fontsize!=null ? fontsize : 15.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? whiteColor : blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  });
}
