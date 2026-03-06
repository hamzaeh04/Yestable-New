import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/views/host_screens/host_profile_setup_screens/host_food_preference_two.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/constants_widgets.dart';
import '../../../controllers/profile_controller.dart';
import '../../../widget/allergens_widget.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/show_other_dialog_box.dart';

class YourRootAndRules extends StatelessWidget {
  YourRootAndRules({super.key});

  final ProfileController controller = Get.find<ProfileController>();


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
                "assets/png/new_guest_illustrations/food_preferences_one_banner.png",
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
                  SizedBox(height: 2.h),
                  loadingStepIndicator("3/6", 0.5),
                  Row(
                    children: [
                      backButton(),
                      Spacer(),
                      TextButton(onPressed: (){
                        Get.toNamed('foodpreferencesone');
                      }, child: customText(text: 'Skip', fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: greenColor,))
                    ],
                  ),

                  SizedBox(height: 1.h),
                  customText(
                    text: "Your Roots & Rules",
                    fontSize: 23.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),customText(
                      text: "What makes you say Yes?",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: darkGreyColor
                  ),
                  SizedBox(height: 2.h),
                  /// More About Plate
                  customText(
                    text: "More about your plate",
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 1.h),
                  ListView.builder(
                    itemCount: controller.more.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      String text = controller.more[index];
                      Widget? leadingWidget;
                      print(controller.selectedAllergens);
                      print(controller.getSelectedPlateString());
                      if (text.contains("Kosher")) {
                        leadingWidget = Image.asset(
                          "assets/png/profile_food_images/kosher_icon.png",
                          height: 16.sp,
                        );
                      } else if (text.contains("Keto")) {
                        leadingWidget = Image.asset(
                          "assets/png/profile_food_images/keto_icon.png",
                          height: 16.sp,
                        );
                      } else if (text.contains("Halal")) {
                        leadingWidget = Image.asset(
                          "assets/png/Halal.png",
                          height: 16.sp,
                        );
                      }
                      return allergenWidget(index + 1, text, icon: leadingWidget);
                    },
                  ),

                  /// Other Foods
                  Obx(
                        () => controller.other3.value
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Other",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 1.h),
                        TextField(
                          readOnly: true,
                          controller: controller.otherRootRuleController,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: foodBoundariesBorderGreenColor,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: foodBoundariesBorderGreenColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: foodBoundariesBorderGreenColor,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 1.h,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        buttonWidget(
                          "Edit Other",
                          whiteColor,
                          colors: blueColor,
                          height: 4.h,
                          fontsize: 15.sp,
                          onTap: () {
                            showCustomOtherDialog(controller: controller.otherRootRuleController);
                          },
                        ),
                      ],
                    )
                        : others(
                          onDone: (){
                            controller.otherToggleSwitch3();
                          },
                          textFieldController: controller.otherRootRuleController,
                      title: "Others",
                      path: "assets/png/icons/others_icon.png",
                    ),
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "What Are You In The Mood For?",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 0.7.h),
                  customText(
                      text: "Click your faves",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: darkGreyColor
                  ),

                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ...List.generate(
                        controller.foodOptions.length,
                            (index) {
                          final foodType = controller.foodOptions[index]['name']!;
                          return foodPreferencesOne(
                            index,
                            foodType,
                            imgpath: controller.foodOptions[index]['imgPath'],
                          );
                        },
                      ),

                      Obx((){
                        return controller.other2.value ?
                        Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: "Other",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 1.h),
                                TextField(
                                  readOnly: true,
                                  controller: controller.otherMoodController,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "WorkSans",
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: "WorkSans",
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.sp),
                                      borderSide: BorderSide(
                                        color: foodBoundariesBorderGreenColor,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.sp),
                                      borderSide: BorderSide(
                                        color: foodBoundariesBorderGreenColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.sp),
                                      borderSide: BorderSide(
                                        color: foodBoundariesBorderGreenColor,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: backgroundColor,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 1.h,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                buttonWidget(
                                  "Edit Other",
                                  whiteColor,
                                  colors: blueColor,
                                  height: 4.h,
                                  fontsize: 15.sp,
                                  onTap: () {
                                    showCustomOtherDialog(controller: controller.otherMoodController,);
                                  },
                                ),
                              ],
                            ):
                        GestureDetector(
                          onTap: () {
                            showCustomOtherDialog(
                              onDone: (){
                                controller.otherToggleSwitch2();
                              },
                              controller: controller.otherMoodController,
                            );
                          },
                          child: IntrinsicWidth(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 0.5.h),
                              height: 3.1.h,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.sp),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.1.w,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/png/icons/others_icon.png',
                                    height: 14.5.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  customText(
                                    text: "Others",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  // SizedBox(height: 2.h),
                  // customText(
                  //   text: "The Yuck List",
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  // SizedBox(height: 0.5.h),
                  // customText(
                  //     text: "What should we keep off your plate?",
                  //     fontSize: 15.sp,
                  //     fontWeight: FontWeight.w500,
                  //     color: darkGreyColor
                  // ),
                  // SizedBox(height: 1.h),
                  // Wrap(
                  //   spacing: 8.0,
                  //   runSpacing: 8.0,
                  //   children: [
                  //     // All regular items from yuckList
                  //     ...List.generate(
                  //       yuckList.length,
                  //           (index) => foodPreferencesOne(
                  //         index + 8,
                  //         yuckList[index]['name']!,
                  //         imgpath: yuckList[index]['imgPath'],
                  //       ),
                  //     ),
                  //
                  //     // ➕ Custom "Other" Widget at the end
                  //     GestureDetector(
                  //       onTap: () {
                  //         showCustomOtherDialog(
                  //           controller: otherTextController,
                  //           shareWithHost: shareToggle,
                  //           onDone: () {
                  //             controller.otherToggleSwitch(); // your custom logic
                  //             print("Typed Text: ${otherTextController.text}");
                  //           },
                  //         );
                  //       },
                  //       child: Container(
                  //         margin: EdgeInsets.symmetric(vertical: 0.5.h),
                  //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                  //         height: 4.h,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(25.sp),
                  //           border: Border.all(color: Colors.grey, width: 0.1.w),
                  //         ),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Image.asset(
                  //               'assets/png/icons/others_icon.png',
                  //               height: 16.sp,
                  //               color: Colors.black, // ensures black color if the image is an SVG/PNG icon with transparency
                  //             ),
                  //             SizedBox(width: 2.w),
                  //             customText(
                  //               text: "Other",
                  //               fontSize: 15.sp,
                  //               fontWeight: FontWeight.w500,
                  //               color: blackColor,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 2.h),
                  buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    borderColor: greenColor,
                    onTap: () {
                      // Get.to(HostFoodPreferenceTwo());
                      controller.UpdateAllergensPlate();
                      // Get.toNamed('foodpreferencesone');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
