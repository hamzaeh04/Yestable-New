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
      String? imgYes, // show asset if provided
      String? imgNo,
    }) {
  final ProfileController controller = Get.find<ProfileController>();

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          customText(text: title, fontSize: 15.sp, fontWeight: FontWeight.w400),
        SizedBox(height: 2.h),

        Obx(() {
          final selected = controller.selectedOptions[index] ?? '';

          Widget option({
            required bool isYes,
            required String label,
            required String? imgPath,
            required VoidCallback onTap,
          }) {
            final bool chosen = selected == (isYes ? 'yes' : 'no');
            final Color bg = isYes ? greenColor : Colors.red;
            final IconData icon = isYes ? Icons.check : Icons.close;

            return GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.5.w,
                  vertical: 0.8.h,
                ),
                decoration: BoxDecoration(
                  color: chosen ? bg : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.sp),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                ),
                child: Row(
                  children: [
                    if (imgPath != null) ...[
                      Image.asset(imgPath, height: 16.sp, color: Colors.black),
                      SizedBox(width: 2.w),
                    ] else ...[
                      Icon(
                        icon,
                        size: 17.sp,
                        color: chosen ? whiteColor : blackColor,
                      ),
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  option(
                    isYes: true,
                    label: text1 ?? "Yes",
                    imgPath: imgYes,
                    onTap: () => controller.selectedOptions[index] = 'yes',
                  ),
                  SizedBox(width: 5.w),
                  option(
                    isYes: false,
                    label: text2 ?? "No",
                    imgPath: imgNo,
                    onTap: () => controller.selectedOptions[index] = 'no',
                  ),
                ],
              ),

              // --- Custom UI if index == 8 ---
              // --- Custom UI if index == 8 ---
              if (index == 9) ...[
                SizedBox(height: 2.h),
                customText(
                  text: "Optional",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp), // or use 100.w for a pill shape
                        border: Border.all(
                          color: greyBorderColor,
                          width: 0.3.w,
                        ),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.5.w,vertical: 0.5.h),
                        child: Icon(Icons.check, color: blackColor, size: 18.sp),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    customText(
                      text: "Guests Are Welcome To Swim",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],

            ],
          );
        }),
      ],
    ),
  );
}

Widget foodPreferencesOne(
  int index,
  String title, {
  String? imgpath,
  double? fontsize,
}) {
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
                Image.asset(imgpath, height: 16.sp),
                SizedBox(width: 2.w),
              ],
              customText(
                text: title,
                fontSize: fontsize != null ? fontsize : 15.sp,
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

// Widget okWidget({
//   required int index,
//   required String title,
// }) {
//   final ProfileController controller = Get.find<ProfileController>();
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       customText(text: title, fontSize: 15.sp, fontWeight: FontWeight.w400),
//       SizedBox(height: 2.h),
//       Obx(() {
//         final bool selected = controller.selectedOptions[index] == 'ok';
//         return GestureDetector(
//           onTap: () {
//             controller.selectedOptions[index] = 'ok';
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.8.h),
//             decoration: BoxDecoration(
//               color: selected ? greenColor : Colors.transparent,
//               borderRadius: BorderRadius.circular(30.sp),
//               border: Border.all(color: Colors.grey.shade400, width: 1),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.check,
//                   size: 18.sp,
//                   color: selected ? Colors.white : Colors.black,
//                 ),
//                 SizedBox(width: 2.w),
//                 customText(
//                   text: "Ok",
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w500,
//                   color: selected ? Colors.white : Colors.black,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     ],
//   );
// }
