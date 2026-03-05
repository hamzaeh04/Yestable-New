import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/profile_controller.dart';
import 'button_widget.dart';

Future privacyDialog(BuildContext context) {
  final ProfileController controller = Get.find<ProfileController>();

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 85.h, // caps height but allows shrink-to-fit
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 🔑 important
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: 'Terms & Conditions',
                  fontWeight: FontWeight.w600,
                  fontSize: 19.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "YesTable is a platform designed to assist users in gathering and organizing dietary preferences, restrictions, and allergy-related information for social events and gatherings. YesTable does not verify the accuracy of the information submitted by users and does not provide medical advice, food safety guidance, or nutritional counseling.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.5.h),

                customText(
                  text: "By using YesTable, you acknowledge and agree that:",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.4.h),

                customText(
                  text:
                  "• All hosts remain solely responsible for verifying ingredients, preventing cross-contact, and making final decisions regarding food preparation and service.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.3.h),

                customText(
                  text:
                  "• All guests remain solely responsible for accurately and clearly disclosing their dietary needs and making informed decisions regarding the consumption of food.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.3.h),

                customText(
                  text:
                  "• YesTable shall not be held liable for any injury, illness, allergic reaction, or other adverse health outcome resulting from the preparation, serving, or consumption of food in connection with any event or gathering planned using this platform.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.3.h),

                customText(
                  text:
                  "• YesTable does not guarantee the prevention of allergic reactions or other food-related incidents, and the platform is not a substitute for medical advice, professional judgment, or proper food safety protocols.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 0.3.h),

                customText(
                  text:
                  "• Use of this platform is at your own risk. Users are encouraged to communicate directly and clearly when food allergies or severe dietary restrictions are involved.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.5.h),

                Align(
                  alignment: Alignment.center,
                  child: buttonWidget(
                    height: 5.h,
                    fontsize: 15.sp,
                    "Agree",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      controller.checkBox();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

