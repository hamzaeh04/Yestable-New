import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/button_widget.dart';

class CreateNewEventScreen extends StatelessWidget {
  CreateNewEventScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed("bottomnavigationbar");
                    },
                    child: customText(
                      text: "Cancel",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  customText(
                    text: "Create A Event",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    fontFamily: "CormorantGaramond",
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                            height: 25.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              color: Colors.transparent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.sp),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/png/event_detail_img/event3.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                      decoration: BoxDecoration(
                                        color: lightgreenColor.withAlpha(250),
                                        borderRadius: BorderRadius.circular(30.sp),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/png/icons/gallery.png", // replace with your actual icon path
                                            height: 18.sp,
                                            width: 18.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2.w),
                                          customText(
                                            text: "Your Label Text",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(height: 1.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align columns to the top
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "Event Name",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Start Date",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "End Date (opt)",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.9.h),
                              customText(
                                text: "Event Timing",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Event Type",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Location",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 3.7.h),
                              customText(
                                text: "Auto-check\ndietary conflicts",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.3.h),
                              customText(
                                text: "Add Note",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.9.h),
                              customText(
                                text: "set Your Note\nReminder",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "Gizelle Dinner Event",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                color: darkGreyColor,
                              ),
                              const Divider(),
                              customText(
                                text: "May 03, 2025",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                color: darkGreyColor,
                              ),
                              const Divider(),
                              customText(
                                text: "Sarah Scarnio!",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                color: darkGreyColor,
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  customText(
                                    text: "07 : 00 AM",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: darkGreyColor,
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  customText(
                                    text: "Dinner Party",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: darkGreyColor,
                                  ),
                                  SizedBox(width: 2.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                              const Divider(),
                              customText(
                                text: "132 My Street, Kingston, New York 12486",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                color: darkGreyColor,
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Transform.scale(
                                    scale: 8.w / 50,
                                    child: Obx(
                                      () => CupertinoSwitch(
                                        activeTrackColor: blackColor,
                                        value: controller.switchValue.value,
                                        onChanged:
                                            (val) =>
                                                controller.toggleSwitch(val),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              SizedBox(height: 0.6.h),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Write your Notes Here',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets
                                          .zero, // Removes default padding
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                                maxLines: null,
                              ),
                              SizedBox(height: 1.h),
                              const Divider(),
                              Row(
                                children: [
                                  customText(
                                    text: "07 : 00 AM",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: darkGreyColor,
                                  ),
                                  SizedBox(width: 1.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  customText(
                                    text: "DD : MM : YY",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: darkGreyColor,
                                  ),

                                  SizedBox(width: 1.w),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: buttonWidget("Continue", whiteColor,colors: greenColor,
                        onTap: (){
                        Get.toNamed("guestlistscreen");
                        }
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
