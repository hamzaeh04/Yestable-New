import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class EventComfortTwo extends StatelessWidget {
  EventComfortTwo({super.key});

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              child: Image.asset(
                "assets/png/new_guest_illustrations/event_comfort_two.png",
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
                  loadingStepIndicator("2/3", 0.70),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text:
                    "2. Make your guests aware of (check all that apply).",
                    fontFamily: "CormorantGaramond",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            SizedBox(height: 1.5.h),

            /// ✅ Checklist
            ListView.builder(
              itemCount: checkList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // ✅ Agar index 8 hai to yesNoWidget nahi, sirf container
                    if (index == 8)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.h),
                        // padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4ECE6),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Swimming Pool",
                                fontSize: 15.5.sp, fontWeight: FontWeight.w400,color: blackColor
                            ),
                            SizedBox(height: 1.5.h),
                            selectedPill(text: "Pool Or Body Of Water Is Present"),
                            SizedBox(height: 1.h),
                            selectedPill(text: "Non-Swimming Event"),
                            SizedBox(height: 1.h),
                            customText(
                              text: "Optional",
                                fontSize: 15.5.sp, fontWeight: FontWeight.w400,color: blackColor
                            ),
                            SizedBox(height: 1.h),
                            unselectedOption(text: "Guests Are Welcome To Swim"),
                          ],
                        ),
                      )
                    else
                      yesNoWidget(title: checkList[index], index + 1), // baki sab normal

                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade400,
                      height: 3.h,
                    ),
                  ],
                );
              },
            ),


            /// Others
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Please Dont Bring Item Containing",
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type Here",
                          hintStyle: const TextStyle(color: Colors.grey,fontFamily: "WorkSans"),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Divider(),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Others",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type Here",
                          hintStyle: const TextStyle(color: Colors.grey,fontFamily: "WorkSans"),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      Get.toNamed("eventcomfortthree");
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
Widget selectedPill({required String text}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
    decoration: BoxDecoration(
      color: const Color(0xFF2F4F4F),
      borderRadius: BorderRadius.circular(30.sp),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            size: 16.sp,
            color: greenColor,
          ),
        ),
        SizedBox(width: 2.w),
        customText(
          text: text,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ],
    ),
  );
}
Widget unselectedOption({required String text}) {
  return Row(
    children: [
      Container(
        height: 22.sp,
        width: 22.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: greyBorderColor),
        ),
        child: Icon(
          Icons.check,
          size: 16.sp,
          color: Colors.black,
        ),
      ),
      SizedBox(width: 3.w),
      customText(
        text: text,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    ],
  );
}
