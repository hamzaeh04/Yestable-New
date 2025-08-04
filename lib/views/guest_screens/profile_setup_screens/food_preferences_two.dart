import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/preferences_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/extra_assitance_dropdown.dart';

class FoodPreferencesTwo extends StatelessWidget {
  FoodPreferencesTwo({super.key});
final ProfileController controller = Get.find<ProfileController>();
  final List<String> titles = [
    "Access To Quiet Space Away From Main Event",
    "Can Accomodate Larger Seating",
    "Space is Whealchair Accesible",
    "ASL Interpreter Available Upon Request",
    "Vegan Menu Option",
  ];
  final List<String> checkList = [
    "Pets Will Present",
    "Children Will Be Present",
    "Event Is Adults-Only",
    "Event May Have Smoke Present",
    "Event Is Smoke-Free",
    "Alcohol Will Be Present",
    "This Is An Alcohol-Free Event",
    "There Are Steps To Climb",
    "Swimming Pool Is Present",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Peanuts Will Be Served",
    "The Event Ends At A Firm time",
    "Please Dont Bring Item Containing (Eg: XYZ)"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              child: Image.asset(
                "assets/png/new_guest_illustrations/food_pref_two.png",
                height: 30.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  loadingStepIndicator("5/6", 0.80),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text: "We're Here for You!",
                    fontSize: 24.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),customText(
                    text: "This helps your host make thoughtful decisions.\nShare as much as you like.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "Mobility Concern",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Type here...", // 💬 Your hint text
                      hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Requiring a chair",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  preferencesWidget("chair without arms"),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Needing a quiet area",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  preferencesWidget("Yes"),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "May Need Extra Assistance",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 2.h),
                  // ─── in your build() ────────────────────────────────────────────────
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── header row with rotating arrow ──────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() =>
                            customText(
                              text: controller.selectedOption.value,              // shows chosen text
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.toggleDropdown(),
                            child: Obx(
                                  () => AnimatedRotation(
                                turns: controller.isExpanded.value ? 0.5 : 0.0, // 180°
                                duration: const Duration(milliseconds: 300),
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── dropdown sheet (renders only when expanded) ─────────────────
                      Obx(
                            () => controller.isExpanded.value
                            ? Container(
                          margin: EdgeInsets.only(top: 1.h),
                          padding: EdgeInsets.zero, // ✅ No top & bottom padding
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.options.length,
                            separatorBuilder: (_, __) =>
                                Container(height: 1, color: Colors.grey[300]),
                            itemBuilder: (_, index) {
                              final value = controller.options[index];
                              final selected = controller.selectedOption.value == value;

                              return InkWell(
                                onTap: () => controller.selectOption(value),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 1.2.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (value == "Other") ...[
                                            Image.asset(
                                              "assets/png/icons/others_icon.png",
                                              width: 16.sp,
                                              height: 16.sp,
                                              color: Colors.black, // optional if your icon is single color and needs tint
                                            ),
                                            SizedBox(width: 2.w),
                                          ],
                                          customText(
                                            text: value,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                      if (selected)
                                        Icon(Icons.check, size: 16.sp, color: Colors.black),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),

                    ],
                  ),

                  SizedBox(height: 2.h),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Need Anything alse",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write Your Needs Here", // 💬 Your hint text
                      hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text: "Would You Like To Let Your Guest Know That You Will Be Offering: (Check All That Apply)",
                    fontSize: 20.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.5.h),
                ListView.builder(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero, // 🔥 This removes default padding
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        yesNoWidget(title: titles[index], index + 1),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                          height: 3.h,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "Other Menu Option I.E Halal,Kosher",
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type Here", // 💬 Your hint text
                  hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade400,
              height: 3.h,
            ),
            yesNoWidget(title: "All Gender Or Faimly Restroom", 6, text1: "All Gender" ,text2: "Faimly Restroom",imgYes: "assets/png/icons/all_gender.png",imgNo: "assets/png/icons/faimly_restroom.png"),
            SizedBox(height: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text: "Would You Like To Let Your Guest Know About: (Check All That Apply)",
                    fontSize: 20.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.5.h),
                ListView.builder(
                  itemCount: checkList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero, // 🔥 This removes default padding
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        yesNoWidget(title: checkList[index], index + 1),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                          height: 3.h,
                        ),

                      ],
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text: "Others",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type Here", // 💬 Your hint text
                      hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                  height: 3.h,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text: "May Guest Contact You About Dietry Or Access Concerns",
                    fontSize: 20.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                yesNoWidget(7),
                SizedBox(height: 2.h),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      Get.toNamed("disclaimerscreen");
                    },
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
