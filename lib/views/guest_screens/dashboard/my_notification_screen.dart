import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/home_screen_widget.dart';

class MyNotificationScreen extends StatelessWidget {
  MyNotificationScreen({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    color: lightgreenColor,
                    iconsize: 16.sp,
                    onTap: () {
                      controller.goToHome();
                    },
                  ),
                  SizedBox(width: 2.w),
                  customText(
                    text: "My Notifications",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Expanded Scrollable Section
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: backgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Tab Bar Widget
                      Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 3.h,
                          ),
                          child: Row(
                            children: List.generate(controller.tabs.length, (
                              index,
                            ) {
                              bool isSelected =
                                  controller.selectedIndex.value == index;
                              return Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: GestureDetector(
                                  onTap: () => controller.selectTab(index),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 0.7.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? greenColor
                                              : greenColor.withAlpha(60),
                                      borderRadius: BorderRadius.circular(
                                        30.sp,
                                      ),
                                    ),
                                    child: customText(
                                      text: controller.tabs[index],
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isSelected ? whiteColor : greenColor,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                      /// Tab content area
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: customText(
                                    text: "Today",
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "CormorantGaramond",
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                // 1. cheque = true
                                myNotificayionWidget(
                                  url: "assets/png/notification_img/notification1.png",
                                  msgtitle: "Vegan Brunch starts in 2 hours!",
                                  msgText: "123 Main St | Menu safe for you",
                                  cheque: false,
                                ),

                                // 2. cheque = true
                                myNotificayionWidget(
                                  url: "assets/png/notification_img/notification2.png",
                                  msgtitle: "Alex invited you to \"Taco Night\"",
                                  msgText: "Harbor 14B | Bring sunscreen!",
                                  cheque: true,
                                ),

                                // 3. cheque = false
                                myNotificayionWidget(
                                  url: "assets/png/notification_img/notification3.png",
                                  msgtitle: "Jamie Wants To Connect",
                                  msgText: "Rain forecasted | See details",
                                  cheque: true,
                                ),

                                // 4. cheque = false
                                myNotificayionWidget(
                                  url: "assets/png/notification_img/notification4.png",
                                  msgtitle: "Maria Joseph Mention You",
                                  msgText: "15% off your next booking",
                                  cheque: false,
                                ),

                                // 5. cheque = false
                                myNotificayionWidget(
                                  url: "assets/png/notification_img/notification5.png",
                                  msgtitle: "Sam Replied To Your Recipe Post",
                                  msgText: "Check who's interested",
                                  cheque: false,
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    customText(
                                      text: "View More",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(Icons.keyboard_arrow_down,size: 17.sp),
                                  ],
                                ),
                                SizedBox(height: 1.5.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                        text: "Suggested For You",
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "CormorantGaramond",
                                      ),
                                      SizedBox(width: 2.w),
                                      customText(
                                        text: "View All",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: blueColor,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                suggestedForYou(
                                  url: "assets/png/chat_images/guest4.png",
                                  msgtitle: "Samuel Kendrio",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),
                                suggestedForYou(
                                  url: "assets/png/chat_images/user1.png",
                                  msgtitle: "Floyed Gerhold",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),
                                suggestedForYou(
                                  url: "assets/png/chat_images/user1.png",
                                  msgtitle: "Kimberly Mayert",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),
                                suggestedForYou(
                                  url: "assets/png/chat_images/user1.png",
                                  msgtitle: "Carol Brakus",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),
                                suggestedForYou(
                                  url: "assets/png/chat_images/user1.png",
                                  msgtitle: "Natasha Adams",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),
                                suggestedForYou(
                                  url: "assets/png/chat_images/user1.png",
                                  msgtitle: "Nelson Dickinson",
                                  msgText: "20+ Mutual Friends",
                                  cheque: true,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myNotificayionWidget({
    required String url,
    String? msgtitle,
    String? msgText,
    bool cheque = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w), // Left padding only
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(url, width: 11.w, height: 11.5.w, fit: BoxFit.cover),
          SizedBox(width: 3.w), // spacing between image and text
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.w, top: 0.8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title Row
                          Row(
                            mainAxisAlignment:
                            cheque ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: customText(
                                  text: msgtitle ?? "",
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                  //fontFamily: "CormorantGaramond",
                                ),
                              ),

                              SizedBox(width: cheque ? 2.w : 0), // only add spacing if cheque is true

                              if (!cheque) // if false, push time to end
                                customText(
                                  text: "1 h",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: darkGreyColor,
                                )
                              else
                                customText(
                                  text: "",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: darkGreyColor,
                                ),
                            ],
                          ),
                          SizedBox(height: 0.2.h),

                          /// Message Text
                          customText(
                            text: msgText ?? "my text",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: darkGreyColor,
                          ),
                          SizedBox(height: 0.5.h),
                        ],
                      ),
                    ), // add spacing so buttons don't overlap
                    Divider(),
                  ],
                ),

                /// ✅ Correct use of Positioned
                if (cheque)
                  Positioned(
                    top: 16.sp, // Adjust based on actual visual
                    right: 7.w,
                    child: Row(
                      children: [
                        buttonWidget(
                          "Accept",
                          whiteColor,
                          colors: greenColor,
                          fontsize: 12.sp,
                          height: 2.h,
                          width: 12.w,
                        ),
                        SizedBox(width: 2.w),
                        Icon(Icons.close, size: 14.sp, color: greenColor),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget suggestedForYou({
    required String url,
    String? msgtitle,
    String? msgText,
    bool cheque = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w), // Left padding only
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(url, width: 11.w, height: 11.5.w, fit: BoxFit.cover),
          SizedBox(width: 3.w), // spacing between image and text
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.w, top: 0.8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title Row
                          Row(
                            mainAxisAlignment:
                            cheque
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: customText(
                                  text: msgtitle ?? "",
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                  //fontFamily: "CormorantGaramond",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 0.2.h),

                          /// Message Text
                          customText(
                            text: msgText ?? "my text",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: darkGreyColor,
                          ),
                          SizedBox(height: 0.5.h,)
                        ],
                      ),
                    ), // add spacing so buttons don't overlap
                    Divider(),
                  ],
                ),

                /// ✅ Correct use of Positioned
                if (cheque)
                  Positioned(
                    top: 17.sp, // Adjust based on actual visual
                    right: 7.w,
                    child: Row(
                      children: [
                        buttonWidget(
                          "Add Friend",
                          whiteColor,
                          colors: greenColor,
                          fontsize: 12.sp,
                          height: 2.h,
                          width: 15.w,
                        ),
                        SizedBox(width: 2.w),
                        Icon(Icons.close, size: 14.sp, color: greenColor),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
