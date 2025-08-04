import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';


class DisclaimerScreen extends StatelessWidget {
  DisclaimerScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  final NavigationController navigationController = Get.find<
      NavigationController>();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: "YesTable Disclaimer",
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
                customText(
                  text:
                  "YesTable is a platform designed to assist users in gathering and organizing dietary preferences, restrictions, and allergy-related information for social events and gatherings. YesTable does not verify the accuracy of the information submitted by users and does not provide medical advice, food safety guidance, or nutritional counseling.",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                  maxLines: 100,
                ),
                SizedBox(height: 2.h),
                customText(
                  text: "By using YesTable, you acknowledge and agree that:",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
                SizedBox(height: 2.h),
                _bullet(
                    "All hosts remain solely responsible for verifying ingredients, preventing cross-contact, and making final decisions regarding food preparation and service."),
                _bullet(
                    "All guests remain solely responsible for accurately and clearly disclosing their dietary needs and making informed decisions regarding the consumption of food."),
                _bullet(
                    "YesTable shall not be held liable for any injury, illness, allergic reaction, or other adverse health outcome resulting from the preparation, serving, or consumption of food in connection with any event or gathering planned using this platform."),
                _bullet(
                    "YesTable does not guarantee the prevention of allergic reactions or other food-related incidents, and the platform is not a substitute for medical advice, professional judgment, or proper food safety protocols."),
                SizedBox(height: 2.h),
                customText(
                  text:
                  "Use of this platform is at your own risk. Users are encouraged to communicate directly and clearly when food allergies or severe dietary restrictions are involved.",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                  maxLines: 100,
                ),
                SizedBox(height: 4.h),
                // You can leave the checkbox + button section unchanged:
                Obx(() =>
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toggleCheckbox(!controller.isChecked
                                .value);
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
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                        if (controller.isChecked.value) {
                          if (navigationController.isUser.value) {
                            Get.toNamed("allownotificationscreen");
                          } else {
                            Get.toNamed("allowhostnotificationscreen");
                          }
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.4.h),
            child: Text(
              "•",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[800]),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
