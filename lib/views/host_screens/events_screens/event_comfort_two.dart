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

class EventComfortTwo extends StatelessWidget {
  EventComfortTwo({super.key});

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              child: Image.asset(
                "assets/png/event_confort_two.png",
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
                    text: "2. Would You Like To Let Your Guest Know About(Check All That Apply)",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.5.h),
            ListView.builder(
              itemCount: checkList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
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
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      Get.toNamed("eventcomfortthree");
                    },
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

