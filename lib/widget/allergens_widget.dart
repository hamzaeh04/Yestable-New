import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/widget/button_widget.dart';

Widget allergenWidget(int index, String title, {Widget? icon}) {
  final ProfileController controller = Get.find<ProfileController>();

  return Obx(() {
    bool isSelected = controller.selectedAllergens.contains(index);

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.selectedAllergens.remove(index);
        } else {
          controller.selectedAllergens.add(index);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        height: 4.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? blueColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30.sp),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              SizedBox(width: 1.w),
            ],
            customText(
              text: title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? whiteColor : blueColor,
            ),
          ],
        ),
      ),
    );
  });
}

Widget others({
  required String title,
  TextEditingController? textFieldController,
  String? path,
  VoidCallback? onDone
}) {
  final ProfileController controller = Get.find<ProfileController>();
  final RxBool shareWithHost = false.obs;

  return Obx(() => GestureDetector(
    onTap: () {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Not on the list? Tell us\nwhat to skip!",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "CormorantGaramond",
                    height: 0.13.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w, bottom: 3.8.h),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: blackColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              customText(
                text:
                "This info stays private unless you choose to share it with a host.",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: textFieldController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Hold The Pickles! I'm Allergic to Cucumber",
                  hintStyle:
                  TextStyle(fontSize: 14.sp, fontFamily: "WorkSans"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Color(0xFF5D8783), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    BorderSide(color: Color(0xFF5D8783), width: 0.2.w),
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                ),
              ),
              SizedBox(height: 1.h),
              Align(
                alignment: Alignment.centerLeft,
                child: buttonWidget(
                  "Done!",
                  whiteColor,
                  colors: blueColor,
                  height: 4.h,
                  width: 24.w,
                  fontsize: 15.sp,
                  onTap: () {
                    (onDone ?? controller.otherToggleSwitch)();
                    Get.back();
                  },

                ),
              ),
            ],
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      height: 4.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
        controller.other.value ? blueColor : Colors.transparent, // directly observable
        borderRadius: BorderRadius.circular(30.sp),
        border: Border.all(
          color: controller.other.value ? Colors.transparent : Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (path != null) ...[
            Image.asset(path, height: 16.sp, color: blueColor),
            SizedBox(width: 2.w),
          ],
          customText(
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: blueColor,
          ),
        ],
      ),
    ),
  ));
}
