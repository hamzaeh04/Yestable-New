import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/views/guest_screens/profile_setup_screens/profile_edit_screen.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/preferences_widget.dart';
import 'package:yestable/widget/privacy_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/extra_assitance_dropdown.dart';

class FoodPreferencesTwo extends StatelessWidget {
  FoodPreferencesTwo({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  final List<String> titles = [
    "Access To Quiet Space Away From Main Event",
    "Can Accommodate Larger Seating",
    "Space is Wheelchair Accessible",
    "ASL Interpreter Available Upon Request",
    "Vegan Menu Option",
    "Gluten-Free Menu Option",
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
    "Please Do Not Bring Item Containing (Eg: XYZ)",
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
                  Row(
                    children: [
                      backButton(),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Get.toNamed("allownotificationscreen");
                        },
                        child: customText(
                          text: "Skip",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: greenColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "We're Here For You!",
                    fontSize: 22.5.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                  customText(
                    text:
                        "This helps your host make thoughtful decisions.\nShare as much as you like.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "Mobility Concerns",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Type here...", // 💬 Your hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "WorkSans",
                      ), // optional: customize hint text color
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ), // ✨ Lightened bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ), // optional: slightly darker on focus
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Seating Requirements",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  // preferencesWidget("chair without arms"),
                  Column(
                    spacing: 1.0.h,
                    children: [
                      SizedBox(height: 0.1.h),
                      seatingList('Larger Seat Or Chair Without Arms', 0),
                      seatingList('Chair With Arms', 1),
                      seatingList('Seating Near Restroom', 2),
                      seatingList('Other', 3),
                    ],
                  ),

                  SizedBox(height: 0.5.h),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Needing A Quiet Area",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      yesOrNoItem('Yes', controller),
                      SizedBox(width: 2.w),
                      yesOrNoItem('No', controller),
                    ],
                  ),
                  SizedBox(height: 0.6.h),

                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "May Need Extra Assistance",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.h),
                  // ─── in your build() ────────────────────────────────────────────────
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     // ── header row with rotating arrow ──────────────────────────────
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Obx(() =>
                  //           customText(
                  //             text: controller.selectedOption.value,              // shows chosen text
                  //             fontSize: 16.sp,
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () => controller.toggleDropdown(),
                  //           child: Obx(
                  //                 () => AnimatedRotation(
                  //               turns: controller.isExpanded.value ? 0.5 : 0.0, // 180°
                  //               duration: const Duration(milliseconds: 300),
                  //               child: const Icon(Icons.keyboard_arrow_down),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //
                  //     // ── dropdown sheet (renders only when expanded) ─────────────────
                  //     Obx(
                  //           () => controller.isExpanded.value
                  //           ? Container(
                  //         margin: EdgeInsets.only(top: 1.h),
                  //         padding: EdgeInsets.zero, // ✅ No top & bottom padding
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(15),
                  //           boxShadow: [
                  //             BoxShadow(color: Colors.black12, blurRadius: 4),
                  //           ],
                  //         ),
                  //         child: ListView.separated(
                  //           padding: EdgeInsets.zero,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           shrinkWrap: true,
                  //           itemCount: controller.options.length,
                  //           separatorBuilder: (_, __) =>
                  //               Container(height: 1, color: Colors.grey[300]),
                  //           itemBuilder: (_, index) {
                  //             final value = controller.options[index];
                  //             final selected = controller.selectedOption.value == value;
                  //
                  //             return InkWell(
                  //               onTap: () => controller.selectOption(value),
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 4.w,
                  //                   vertical: 1.2.h,
                  //                 ),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         if (value == "Other") ...[
                  //                           Image.asset(
                  //                             "assets/png/icons/others_icon.png",
                  //                             width: 16.sp,
                  //                             height: 16.sp,
                  //                             color: Colors.black, // optional if your icon is single color and needs tint
                  //                           ),
                  //                           SizedBox(width: 2.w),
                  //                         ],
                  //                         customText(
                  //                           text: value,
                  //                           fontSize: 15.sp,
                  //                           fontWeight: FontWeight.w400,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     if (selected)
                  //                       Icon(Icons.check, size: 16.sp, color: Colors.black),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       )
                  //           : const SizedBox.shrink(),
                  //     ),
                  //
                  //   ],
                  // ),
                  Column(
                    spacing: 1.h,
                    children: [
                      seatingList('Help Carrying Plate', 4),
                      seatingList('Seating Near A Restroom', 5),
                      seatingList('Non Verbal', 6),
                      seatingList('Bringing A Care Aide', 7),
                      seatingList('Hearing Loss', 8),
                      seatingList('Assistance Walking In', 9),
                      seatingList('Other', 10),
                    ],
                  ),
                  // seatingList('Help Carrying Plate', 4),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Seating Near A Restroom', 5),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Non Verbal', 6),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Bringing A Care Aide', 7),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Hearing Loss', 8),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Assistance Walking In', 9),
                  // SizedBox(height: 0.7.h,),
                  // seatingList('Other', 10),
                  SizedBox(height: 2.h),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 3.h,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Need Anything alse",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write Your Needs Here", // 💬 Your hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "WorkSans",
                      ), // optional: customize hint text color
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ), // ✨ Lightened bottom border
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ), // optional: slightly darker on focus
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 1.h),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding:EdgeInsets.symmetric(horizontal: 6.w),
            //       child: customText(
            //         text: "Would You Like To Let Your Guests Know That You Will Be Offering: (Check All That Apply)",
            //         fontSize: 20.sp,
            //         fontFamily: "CormorantGaramond",
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: 1.5.h),
            //     ListView.builder(
            //       itemCount: titles.length,
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       padding: EdgeInsets.zero, // 🔥 This removes default padding
            //       itemBuilder: (context, index) {
            //         return Column(
            //           children: [
            //             yesNoWidget(title: titles[index], index + 1,),
            //             Divider(
            //               thickness: 1,
            //               color: Colors.grey.shade400,
            //               height: 3.h,
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   ],
            // ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 6.w),
            //   child: customText(
            //     text: "Other Menu Option I.E Halal, Kosher",
            //     fontSize: 17.sp,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 6.w),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Type Here", // 💬 Your hint text
            //       hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
            //       enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
            //       ),
            //       focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
            //       ),
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey.shade400,
            //   height: 3.h,
            // ),
            // yesNoWidget(title: "All Gender Or Faimly Restroom", 100, text1: "All Gender" ,text2: "Faimly Restroom",imgYes: "assets/png/icons/all_gender.png",imgNo: "assets/png/icons/faimly_restroom.png"),
            // SizedBox(height: 1.h),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding:EdgeInsets.symmetric(horizontal: 6.w),
            //       child: customText(
            //         text: "Would You Like To Let Your Guests Know About: (Check All That Apply)",
            //         fontSize: 20.sp,
            //         fontFamily: "CormorantGaramond",
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: 1.5.h),
            //     ListView.builder(
            //       itemCount: checkList.length,
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       padding: EdgeInsets.zero, // 🔥 This removes default padding
            //       itemBuilder: (context, index) {
            //         final bool isSpecialIndex = index == 8;
            //         final bool isOkIndex = index == 13;
            //         return Column(
            //           children: [
            //             yesNoWidget(title: checkList[index], index + 1,text1: isOkIndex ? "Ok":null,text2: isSpecialIndex ? "Non Swimming Event": null,myBool: false),
            //             Divider(
            //               thickness: 1,
            //               color: Colors.grey.shade400,
            //               height: 3.h,
            //             ),
            //
            //           ],
            //         );
            //       },
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 6.w),
            //       child: customText(
            //         text: "Others",
            //         fontSize: 17.sp,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 6.w),
            //       child: TextField(
            //         decoration: InputDecoration(
            //           hintText: "Type Here", // 💬 Your hint text
            //           hintStyle: TextStyle(color: Colors.grey), // optional: customize hint text color
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.grey.shade300), // ✨ Lightened bottom border
            //           ),
            //           focusedBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.grey.shade500), // optional: slightly darker on focus
            //           ),
            //         ),
            //       ),
            //     ),
            //     Divider(
            //       thickness: 1,
            //       color: Colors.grey.shade400,
            //       height: 3.h,
            //     ),
            //   ],
            // ),
            // SizedBox(height: 1.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Hosting An Event?",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: greenColor,
                      ),
                      Transform.scale(
                        scale: 7.w / 50,
                        child: Obx(
                          () => CupertinoSwitch(
                            activeTrackColor: blackColor,
                            value: controller.switchValue.value,
                            onChanged: (val) => controller.toggleSwitch(val),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    height: 2.h,
                  ),
                ),
                SizedBox(height: 1.5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 6.w),

                    Obx(() =>
                       InkWell(
                        onTap: (){
                          if (!controller.isSelected.value) {
                            privacyDialog(context);
                          } else {
                            // Checkbox is TRUE → just uncheck
                            controller.checkBox();
                          }
                        },
                        child: Container(
                          height: 3.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isSelected == false ? Colors.white : radioButtonBlueColor,
                          ),
                          child: Icon(Icons.check, size: 14.sp, color: Colors.white,),
                        ),
                      ),
                    ),

                    SizedBox(width: 2.w),
                    customText(text: 'I Agree To All', fontSize: 14.sp),
                    SizedBox(width: 1.w),
                    // Policy text with underline
                    InkWell(
                      onTap: () {
                        // handle Policy click
                      },
                      child: customText(
                        text: 'Policy',
                        fontSize: 14.sp,
                        txtDecoration: TextDecoration.underline,
                        height: 0.1.h,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    customText(text: '&', fontSize: 14.sp),
                    SizedBox(width: 1.w),
                    // Terms of Condition text with underline
                    InkWell(
                      onTap: () {
                        // handle Terms click
                      },
                      child: customText(
                        text: 'Terms Of Condition',
                        fontSize: 14.sp,
                        txtDecoration: TextDecoration.underline,
                        height: 0.1.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      Get.toNamed("allownotificationscreen");
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

Widget seatingList(String title, int index) {
  ProfileController controller = Get.find<ProfileController>();
  return Obx(
    () => InkWell(
      onTap: () => controller.updatePronounIsSelected(index),
      child: Row(
        children: [
          Container(
            //padding: EdgeInsets.all(0.6.w),
            height: 1.8.h,
            width: 4.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child:
                controller.pronounIsSelected.value == index
                    ? Container(
                      height: 1.h,
                      width: 1.w,
                      decoration: BoxDecoration(
                        color: radioButtonBlueColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
          ),
          SizedBox(width: 1.5.w),
          customText(text: title, fontSize: 15.sp),
        ],
      ),
    ),
  );
}

Widget yesOrNoItem(String title, ProfileController controller) {
  return Obx(() {
    final bool isSelected = controller.selectedValue.value == title;

    // decide selected color
    final Color selectedColor = title == 'No' ? redColor : greenColor;

    return InkWell(
      onTap: () => controller.select(title),
      borderRadius: BorderRadius.circular(18.sp),
      child: Container(
        height: 3.4.h,
        width: 19.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.sp),
          color: isSelected ? selectedColor : backgroundColor,
          border: Border.all(
            color: isSelected ? selectedColor : greyBorderColor,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                title == 'No' ? Icons.close : Icons.check,
                size: 17.sp,
                color: isSelected ? Colors.white : Colors.black,
              ),
              SizedBox(width: 0.8.w),
              customText(
                text: title,
                fontSize: 14.5.sp,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  });
}
