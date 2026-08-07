import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/views/guest_screens/profile_setup_screens/profile_edit_screen.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/preferences_widget.dart';
import 'package:yestable/widget/privacy_dialog.dart';
import 'package:yestable/widget/update_sent_sucessfull_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/extra_assitance_dropdown.dart';

class FoodPreferencesTwo extends StatelessWidget {
  FoodPreferencesTwo({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // See allergies_dietry_screen.dart: don't prefill from the guest's
      // own saved profile when setting a MEMBER's preferences.
      if (controller.isEdit.value == true && controller.isPreferences.value != true) {
        controller.populateFoodPreferencesTwo();
      }
    });
  }
  final ProfileController controller = Get.find<ProfileController>();
  final NavigationController navigationController = Get.find<NavigationController>();
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
                  backButton(),

                  SizedBox(height: 1.h),
                  customText(
                    text: " We're Here For You!",
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
                    controller: controller.mobilityConcerns,
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
                  SizedBox(height: 1.h),

                  // preferencesWidget("chair without arms"),
                  Column(
                    spacing: 1.0.h,
                    children: [
                      seatingList('Larger Seat Or Chair Without Arms', 0),
                      seatingList('Chair With Arms', 1),
                      seatingList('Seating Near Restroom', 2),
                      seatingList('Other', 3),
                    ],
                  ),
                  Obx(
                        () => controller.showSeatingOther.value
                        ? Column(
                      children: [
                        TextField(
                          controller: controller.seatingOther,
                          onChanged: (val) {
                            controller.updateOtherFields();
                            controller.removeOtherIfEmpty();
                          },
                          decoration: InputDecoration(
                            hintText: "Type here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "WorkSans",
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                      ],
                    )
                        : Divider(
                      thickness: 1,
                      color: Colors.grey.shade400,
                      height: 3.h,
                    ),
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
                  Column(
                    spacing: 1.h,
                    children: [
                      seatingList('Help Carrying Plate', 4),
                      seatingList('Non Verbal', 5),
                      seatingList('Bringing A Care Aide', 6),
                      seatingList('Hearing Loss', 7),
                      seatingList('Assistance Walking In', 8),
                      seatingList('Other', 9),
                    ],

                  ),
                  Obx(
                    () =>
                        controller.showAssistanceOther.value
                            ? Column(
                              children: [
                                TextField(
                                  controller: controller.assistanceOther,
                                  onChanged: (val) {
                                    controller.updateOtherFields();
                                    controller.removeOtherIfEmpty();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Type here...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSans",
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                              ],
                            )
                            : Divider(
                              thickness: 1,
                              color: Colors.grey.shade400,
                              height: 3.h,
                            ),
                  ),

                  // Obx(() {
                  //   bool showOtherField = controller.selectExtraAssistance.contains('other');
                  //
                  //   return Column(
                  //     children: [
                  //       if (!showOtherField) SizedBox(height: 0.6.h),
                  //       if (!showOtherField)
                  //         Divider(
                  //           thickness: 1,
                  //           color: Colors.grey.shade400,
                  //           height: 3.h,
                  //         ),
                  //       if (showOtherField)
                  //         TextField(
                  //           controller: controller.assistanceOther,
                  //           onChanged: (val) {
                  //             controller.updateOtherFields();
                  //             controller.removeOtherIfEmpty();
                  //           },
                  //           decoration: InputDecoration(
                  //             hintText: "Type here...",
                  //             hintStyle: TextStyle(
                  //               color: Colors.grey,
                  //               fontFamily: "WorkSans",
                  //             ),
                  //             enabledBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(color: Colors.grey.shade300),
                  //             ),
                  //             focusedBorder: UnderlineInputBorder(
                  //               borderSide: BorderSide(color: Colors.grey.shade500),
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   );
                  // }),

                  //SizedBox(height: 1.h),
                  customText(
                    text: "Need Anything alse",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextField(
                    controller: controller.anythingElse,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.5.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       customText(
                //         text: "Hosting An Event?",
                //         fontSize: 17.sp,
                //         fontWeight: FontWeight.w500,
                //         color: greenColor,
                //       ),
                //       Transform.scale(
                //         scale: 7.w / 50,
                //         child: Obx(
                //           () => CupertinoSwitch(
                //             activeTrackColor: blackColor,
                //             value: controller.switchValue.value,
                //             onChanged: (val) => controller.toggleSwitch(val),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 0.5.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                //   child: Divider(
                //     thickness: 1,
                //     color: Colors.grey.shade400,
                //     height: 2.h,
                //   ),
                // ),
                SizedBox(height: 1.5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 6.w),

                    Obx(
                      () => InkWell(
                        onTap: () {
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
                            color:
                                controller.isSelected == false
                                    ? Colors.white
                                    : radioButtonBlueColor,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 14.sp,
                            color: Colors.white,
                          ),
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
                      // final index = controller.selectedIndex.value;
                      // print(controller.isPreferences.value);
                      // if (controller.isPreferences.value == true) {
                      //   print(controller.isPreferences.value);
                      //   controller.placeCompleted[index] = true;
                      //   // Show dialog
                      //   updateSentSuccessfull(context, desc: "Your preference for this person has been added successfully");
                      //
                      //   // Delay + navigation
                      //   Future.delayed(Duration(seconds: 3), () {
                      //     if(controller.isPreferences.value == true) { // check again
                      //       Get.toNamed('profileeditscreen');
                      //       controller.isPreferences.value = false;
                      //     }
                      //     print(controller.isPreferences.value);
                      //   });
                      // } else {
                      //   Get.toNamed("allownotificationscreen");
                      // }
                      controller.isPreferences.value == true ? controller.UpdateSeatingAssistance(context,isMember: true, memberId: controller.memberId) :
                      controller.UpdateSeatingAssistance(context);

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

  bool isSeating = index < controller.seating.length;

  return Obx(() {
    String value =
    isSeating
        ? controller.seating[index]
        : controller.assistance[index - controller.seating.length];

    bool isSelected;

    if (isSeating) {
      if (value == 'other') {
        isSelected = controller.showSeatingOther.value;
      } else {
        isSelected = controller.selectSeatingRequirements.contains(value);
      }
    } else {
      if (value == 'other') {
        isSelected = controller.showAssistanceOther.value;
      } else {
        isSelected = controller.selectExtraAssistance.contains(value);
      }
    }

    return InkWell(
      onTap: () {
        if (isSeating) {
          controller.toggleSeatingSelection(index);
        } else {
          controller.toggleAssistanceSelection(index);
        }
      },
      child: Row(
        children: [
          Container(
            height: 1.8.h,
            width: 4.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: isSelected
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
    );
  });
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
