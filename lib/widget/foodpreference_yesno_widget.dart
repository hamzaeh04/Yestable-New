import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/profile_controller.dart';

Widget yesNoWidget(
    int index, {
      String? title,
      String? text1,
      String? text2,
      String? imgYes,  // show asset if provided
      String? imgNo,   // show asset if provided
    }) {
  final ProfileController controller = Get.find<ProfileController>();

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          customText(
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        SizedBox(height: 2.h),

        Obx(() {
          final selected = controller.selectedOptions[index] ?? '';

          // ----- helper to build each option -----
          Widget option({
            required bool isYes,
            required String label,
            required String? imgPath,
            required VoidCallback onTap,
          }) {
            final bool chosen = selected == (isYes ? 'yes' : 'no');
            final Color bg     = isYes ? greenColor : Colors.red;
            final IconData icon = isYes ? Icons.check : Icons.close;

            return GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: chosen ? bg : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.sp),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                ),
                child: Row(
                  children: [
                    // asset image if provided, else fallback icon
                    if (imgPath != null) ...[
                      Image.asset(imgPath, height: 16.sp, color: Colors.black),
                      SizedBox(width: 2.w),
                    ] else ...[
                      Icon(icon, size: 17.sp, color: chosen ? whiteColor : blackColor),
                      SizedBox(width: 2.w),
                    ],
                    customText(
                      text: label,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: chosen ? whiteColor : blackColor,
                    ),
                  ],
                ),
              ),
            );
          }

          return Row(
            children: [
              // YES button
              option(
                isYes: true,
                label: text1 ?? "Yes",
                imgPath: imgYes,
                onTap: () => controller.selectedOptions[index] = 'yes',
              ),
              SizedBox(width: 5.w),
              // NO button
              option(
                isYes: false,
                label: text2 ?? "No",
                imgPath: imgNo,
                onTap: () => controller.selectedOptions[index] = 'no',
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
