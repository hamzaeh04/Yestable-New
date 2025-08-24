import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/constants_widgets.dart';
import '../../../controllers/profile_controller.dart';
import '../../../widget/allergens_widget.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/show_other_dialog_box.dart';

class FoodPreferencesOne extends StatelessWidget {
  FoodPreferencesOne({super.key});

  final ProfileController controller = Get.find<ProfileController>();
  TextEditingController otherTextController = TextEditingController();
  RxBool shareToggle = false.obs;

  final List<Map<String, String>> foodOptions = [
    {"name": "Italian", "imgPath": "assets/png/profile_food_images/pizza.png"},
    {"name": "American Comfort", "imgPath": "assets/png/profile_food_images/burger.png"},
    {"name": "Mexican", "imgPath": "assets/png/profile_food_images/mexican.png"},
    {"name": "Mediterranean", "imgPath": "assets/png/profile_food_images/meditrain.png"},
    {"name": "Japanese", "imgPath": "assets/png/profile_food_images/sushi.png"},
    {"name": "Indian", "imgPath": "assets/png/profile_food_images/indian.png"},
    {"name": "Thai", "imgPath": "assets/png/profile_food_images/thai.png"},
  ];

  final List<Map<String, String>> yuckList = [
    {"name": "Cilantro", "imgPath": "assets/png/profile_food_images/dhaniya.png"},
    {"name": "Mushrooms", "imgPath": "assets/png/profile_food_images/mushroom_new.png"},
    {"name": "Mayonnaise", "imgPath": "assets/png/profile_food_images/mayonise.png"},
    {"name": "Olives", "imgPath": "assets/png/profile_food_images/olive.png"},
    {"name": "Blue Cheese", "imgPath": "assets/png/profile_food_images/bluecheese.png"},
    {"name": "Raw Onions", "imgPath": "assets/png/profile_food_images/onion.png"},
    {"name": "Spicy Heat", "imgPath": "assets/png/profile_food_images/spicyfood.png"},
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
                  SizedBox(height: 1.h),
                  loadingStepIndicator("4/6", 0.70),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Your Taste Preferences",
                    fontSize: 24.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),customText(
                    text: "What makes you say Yes?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor
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
                      // 🔁 Loop through foodOptions (first 5 items)
                      ...List.generate(
                        foodOptions.length,
                            (index) => foodPreferencesOne(
                          index + 1,
                          foodOptions[index]['name']!,
                          imgpath: foodOptions[index]['imgPath'],
                        ),
                      ),

                      // ➕ Manually added item (custom, opens dialog)
                      GestureDetector(
                        onTap: () {
                          showCustomOtherDialog(
                            controller: otherTextController,
                            shareWithHost: shareToggle,
                            onDone: () {
                              controller.otherToggleSwitch(); // your custom logic
                              print("Typed Text: ${otherTextController.text}");
                            },
                          );
                        },
                        child: IntrinsicWidth(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.5.h),
                            height: 4.h,
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
                                  'assets/png/icons/others_icon.png', // change to your desired icon
                                  height: 16.sp,
                                ),
                                SizedBox(width: 2.w),
                                customText(
                                  text: "Other",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  customText(
                      text: "The Yuck List",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 0.5.h),
                  customText(
                    text: "What should we keep off your plate?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: darkGreyColor
                  ),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      // All regular items from yuckList
                      ...List.generate(
                        yuckList.length,
                            (index) => foodPreferencesOne(
                          index + 9,
                          yuckList[index]['name']!,
                          imgpath: yuckList[index]['imgPath'],
                        ),
                      ),

                      // ➕ Custom "Other" Widget at the end
                      GestureDetector(
                        onTap: () {
                          showCustomOtherDialog(
                            controller: otherTextController,
                            shareWithHost: shareToggle,
                            onDone: () {
                              controller.otherToggleSwitch(); // your custom logic
                              print("Typed Text: ${otherTextController.text}");
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 0.5.h),
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          height: 4.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.sp),
                            border: Border.all(color: Colors.grey, width: 0.1.w),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/png/icons/others_icon.png',
                                height: 16.sp,
                                color: Colors.black, // ensures black color if the image is an SVG/PNG icon with transparency
                              ),
                              SizedBox(width: 2.w),
                              customText(
                                text: "Other",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),
                  buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    borderColor: greenColor,
                    onTap: () {
                      Get.toNamed("foodpreferencestwo");
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
