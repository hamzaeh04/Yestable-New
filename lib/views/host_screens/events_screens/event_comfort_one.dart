import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/preferences_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class EventComfortOne extends StatelessWidget {
  EventComfortOne({super.key});

  final List<String> titles = [
    "Access To Quiet Space Away From Main Event",
    "Can Accomodate Larger Seating",
    "Space is Whealchair Accesible",
    "ASL Interpreter Available Upon Request",
    "Vegan Menu Option",
  ];
  final List<String> checkList = [
    "Pet Will Present",
    "Children Will Be Present",
    "Event Is Adults-Only",
    "Event May Have Smoke Present",
    "Event Is Smoke-Free",
    "Alchol Will Be Present",
    "This Is An Alchol-Free Event",
    "There Are Step To Climb",
    "Swimming Pool Is Present",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Peanuts Will Be Served",
    "The Event Ends At A Firetime",
    "Please Dont Bring Item Containing(Eg: XYZ)"
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
                  SizedBox(height: 1.h),
                  loadingStepIndicator("1/3", 0.35),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Event Comfort & Accessibility",
                    fontSize: 22.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                    height: 0.12.h,
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
                    text: "1. Would You Like To Let Your Guest Know That You Will Be Offering(Check All That Apply)",
                    fontSize: 16.sp,
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
                fontSize: 15.sp,
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
            yesNoWidget(title: "All Gender Or Faimly Restroom", 6, text1: "All Gender" ,text2: "Faimly Restroom"),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: buttonWidget(
                "Continue",
                whiteColor,
                colors: greenColor,
                onTap: () {
                  Get.toNamed("eventcomforttwo");
                },
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
