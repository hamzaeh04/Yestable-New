import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class EventComfortThree extends StatelessWidget {
  EventComfortThree({super.key});
  final NavigationController controller = Get.find<NavigationController>();

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
                "assets/png/new_guest_illustrations/event_comfort_three.png",
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
                  loadingStepIndicator("3/3", 0.90),
                  backButton(),
                  SizedBox(height: 2.h),

                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text: "3. May Guest Contact You About Dietry Or Access Concerns",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                yesNoWidget(7),
                SizedBox(height: 1.h),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                  height: 3.h,
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customText(
                          text: "Display Menu Items on the Event\nScreen for Guest Preview.",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Obx(() => CupertinoSwitch(
                            value: controller.isSelected.value,
                            activeTrackColor: Colors.black,
                            onChanged: (value) {
                              controller.isSelected.value = value;
                            },
                          )),
                          SizedBox(width: 2.w),
                          Obx(() => controller.isSelected.value
                              ? Text(
                            "OK",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                              : SizedBox.shrink()),
                        ],
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
                      Get.toNamed("eventpublishscreen");
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
