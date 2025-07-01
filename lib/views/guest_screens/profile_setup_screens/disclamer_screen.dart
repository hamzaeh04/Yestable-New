import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';


class DisclaimerScreen extends StatelessWidget {
  DisclaimerScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: "FoodSync Disclaimer",
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
              ),
              SizedBox(height: 0.5.h),
              customText(
                text: "Last Updated: 30 June 2025",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 3.h),

              disclaimerSection("Allergy Responsibility",
                  "While we help hosts accommodate dietary needs, ultimate responsibility for food safety lies with event organizers and food providers. Always double-check ingredients with hosts."),
              disclaimerSection("AI Limitations",
                  "Our menu suggestions are AI-powered but may not catch every allergen. Guests with severe allergies should confirm directly with hosts."),
              disclaimerSection("User-Generated Content",
                  "Recipes and event details are provided by users. FoodSync isn’t liable for inaccuracies."),
              disclaimerSection("Emergency Preparedness",
                  "Carry necessary medications (e.g., EpiPens) and alert hosts of life-threatening allergies."),
              customText(
                text: "Contact",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
              ),
              SizedBox(height: 0.5.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Questions? Reach us at ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800],
                        height: 1.4,
                      ),
                    ),
                    TextSpan(
                      text: "help@foodsync.com.",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800],
                        height: 1.4,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.toggleCheckbox(!controller.isChecked.value);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 1.7.h),
                      child: Container(
                        width: 17.sp,
                        height: 17.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: greenColor,
                            width: 1,
                          ),
                          color: controller.isChecked.value
                              ? greenColor
                              : Colors.transparent,
                        ),
                        child: controller.isChecked.value
                            ? Center(
                          child: Container(
                            padding: EdgeInsets.all(1), // spacing around the inner dot
                            decoration: BoxDecoration(
                              color: Colors.white, // contrast background
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: greenColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: customText(
                      text: "By Continuing You agree to our Terms & Conditions.",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                ],
              )),

              SizedBox(height: 3.h),

              Obx(() =>
                buttonWidget(
                  "I Understand",
                  whiteColor,
                  colors: controller.isChecked.value
                      ? greenColor
                      : lightBlackColor,
                  onTap: () {
                    if (controller.isChecked.value == true) {
                      if (navigationController.isUser.value == true) {
                        Get.toNamed("allownotificationscreen");
                      } else {
                        Get.toNamed("allowhostnotificationscreen");
                      }
                    } else {
                      // Get.snackbar(
                      //   "Please Confirm",
                      //   "You must agree to the terms & conditions to continue.",
                      //   snackPosition: SnackPosition.BOTTOM,
                      // );
                    }


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget disclaimerSection(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "CormorantGaramond",
          ),
          SizedBox(height: 0.5.h),
          customText(
            text: description,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
