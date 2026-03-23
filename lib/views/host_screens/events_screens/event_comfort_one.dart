import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/preferences_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class EventComfortOne extends StatelessWidget {
  EventComfortOne({super.key});
  final EventController controller = Get.find<EventController>();

  final List<String> titles = [
    "Access To Quiet Space Away From Main Event",
    "Can Accommodate Larger Seating",
    "Space is Wheelchair Accessible",
    "ASL Interpreter Available Upon Request",
    "Vegan Menu Option",
  ];
  @override
  Widget build(BuildContext context) {
    final eventId = Get.arguments;
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
                "assets/png/new_guest_illustrations/event_comfort_one.png",
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
                    text: "1. Let your guests know what you are offering. Check all that apply!",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "CormorantGaramond",
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
                color: blackColor
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextField(
                controller: controller.otherComfortController,
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
            yesNoWidget(6, title: "Restroom"),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: buttonWidget(
                "Continue",
                whiteColor,
                colors: greenColor,
                onTap: () async {
                  // Currently assuming a specific event ID for testing
                  await controller.updateEventComfortMethod(eventId);
                  // Get.toNamed("eventcomforttwo");
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
