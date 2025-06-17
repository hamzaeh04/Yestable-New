import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/views/host_screens/host_profile_setup_screens/host_food_preference_two.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';

class HostFoodPreferenceOne extends StatelessWidget {
  HostFoodPreferenceOne({super.key});

  final List<Map<String, String>> foodOptions = [
    {"name": "Italian", "imgPath": "assets/png/profile_food_images/pizza.png"},
    {"name": "American Comfort", "imgPath": "assets/png/profile_food_images/burger.png"},
    {"name": "Mexican", "imgPath": "assets/png/profile_food_images/mexican.png"},
    {"name": "Mediterranean", "imgPath": "assets/png/profile_food_images/mediterranean.png"},
    {"name": "Japanese", "imgPath": "assets/png/profile_food_images/japnese.png"},
    {"name": "Indian", "imgPath": "assets/png/profile_food_images/indian.png"},
    {"name": "Thai", "imgPath": "assets/png/profile_food_images/thai.png"},
    {"name": "Other", "imgPath": "assets/png/icons/others_icon.png"},
  ];

  final List<Map<String, String>> yuckList = [
    {"name": "Cilantro", "imgPath": "assets/png/profile_food_images/cilantro.png"},
    {"name": "Mushrooms", "imgPath": "assets/png/profile_food_images/cilantro.png"},
    {"name": "Mayonnaise", "imgPath": "assets/png/profile_food_images/mayonise.png"},
    {"name": "Olives", "imgPath": "assets/png/profile_food_images/olive.png"},
    {"name": "Blue Cheese", "imgPath": "assets/png/profile_food_images/bluecheese.png"},
    {"name": "Raw Onions", "imgPath": "assets/png/profile_food_images/onion.png"},
    {"name": "Spicy Heat", "imgPath": "assets/png/profile_food_images/spicyfood.png"},
    {"name": "Other", "imgPath": "assets/png/icons/others_icon.png"},
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
                "assets/png/food_preferences_banner.png",
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
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Your Taste Preferences",
                    fontSize: 24.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),customText(
                      text: "It's stronger than just a preference",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: darkGreyColor
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "What Makes You Say Yes?",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 8.0,  // horizontal space between items
                    runSpacing: 8.0,  // vertical space between rows
                    children: List.generate(
                      foodOptions.length,
                          (index) => foodPreferencesOne(index + 1, foodOptions[index]['name']!,imgpath: foodOptions[index]['imgPath']),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "The Yuck List",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  customText(
                      text: "What should we keep off your plate?",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor
                  ),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 8.0,  // horizontal space between items
                    runSpacing: 8.0,  // vertical space between rows
                    children: List.generate(
                      yuckList.length,
                          (index) => foodPreferencesOne(index + 8, yuckList[index]['name']!,imgpath: yuckList[index]['imgPath']),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    borderColor: greenColor,
                    onTap: () {
                      Get.to(HostFoodPreferenceTwo());
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
