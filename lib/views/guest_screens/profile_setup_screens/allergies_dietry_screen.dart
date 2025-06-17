import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/allergens_widget.dart';
import 'package:yestable/widget/back_button_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/loading_step_indicator.dart';

class AllergiesDietryScreen extends StatelessWidget {
  AllergiesDietryScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());
  final List<String> allergens = [
    "🥜 Peanuts",
    "🦐 Shellfish",
    "🥛 Dairy",
    "🌾 Gluten",
    "🥚 Eggs",
  ];final List<String> levels = [
    "🚨 Severe Allergy",
    "🤧 Mild Or Digestive Reaction",
    "🙏🏼 Avoid For Belief Or Culture",
    "👋 No Allergy Just A Pereference",
  ];final List<String> more = [
    "🚨 Vegan",
    "🤧 Vegetarian",
    "🙏🏼 Halal",
    "👋 Kosher",
    "👋 keto",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loadingStepIndicator("3/6", 0.5),
                    backButton(),
                    SizedBox(height: 1.h),
                    customText(
                      text: "Food Boundaries & Beliefs",
                      fontSize: 24.sp,
                      fontFamily: "CormorantGaramond",
                      fontWeight: FontWeight.w600,
                    ),
                    customText(
                      text: "Sharing this helps others plan with care",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700]
                    ),
                    SizedBox(height: 2.h),
                    customText(
                      text: "Common Allergens",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.h),
          ListView.builder(
            itemCount: allergens.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context,index){
                return allergenWidget(index + 1, allergens[index]);
              }
          ),

                    Obx(() => controller.other.value
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
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                            "Lorem ipsum dolor sit amet consectetur. Nec arcu enim consequat pulvinar proin urna ac tempus. Nulla viverra dui tellus nisi mont es sit tellus ac pellentesque.",
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
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
                          onTap: () {
                            // your action here
                          },
                        ),
                      ],
                    )
                        : others(title: "others")),
                    SizedBox(height: 3.h),
                    customText(
                      text: "Severity Level",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.h),
                    customText(
                      text: "Helps hosts understand how careful they need to be",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: darkGreyColor
                    ),
                    SizedBox(height: 1.h),
                    ListView.builder(
                        itemCount: levels.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          return allergenWidget(index + 6, levels[index]);
                        }
                    ),
                    SizedBox(height: 2.h),
                    customText(
                      text: "More about your plate",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.h),
                    ListView.builder(
                        itemCount: more.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          return allergenWidget(index + 10, more[index]);
                        }
                    ),
                    Obx(() => controller.other.value
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
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                            "Lorem ipsum dolor sit amet consectetur. Nec arcu enim consequat pulvinar proin urna ac tempus. Nulla viverra dui tellus nisi mont es sit tellus ac pellentesque.",
                            hintStyle: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide(
                                color: Color(0xFF5D8783),
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
                          onTap: () {
                            // your action here
                          },
                        ),
                      ],
                    )
                        : others(title: "others")),
                    SizedBox(height: 2.h),
                    buttonWidget(
                      "Continue",
                      whiteColor,
                      colors: greenColor,
                      onTap: () {
                        Get.toNamed("foodpreferencesone");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
