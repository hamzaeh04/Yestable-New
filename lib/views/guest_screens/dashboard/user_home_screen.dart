import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/event_dialog.dart';
import 'package:yestable/widget/redirecting_dialog.dart';
import '../../../widget/home_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Hi, Sarah Scarnio!",
                        fontSize: 20.sp,
                        fontFamily: "CormorantGaramond",
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                      customText(
                        text: "May 01, 2025",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      controller.goTSearchScreen();
                    },
                      child: homeIconWidget(icon: Icons.search)
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: (){
                      controller.goToNotificationPage();
                    },
                      child: homeIconWidget(icon: Icons.notifications)),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Main Scrollable Body with Rounded Corners
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
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dinner Calendar Header
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      text: "Dinner Calander",
                                      fontSize: 20.sp,
                                      fontFamily: "CormorantGaramond",
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                    customText(
                                      text: "Your Booked event at a glance",
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 2.h,
                                          width: 2.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: greenColor,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        customText(
                                          text: "Lunch",
                                          fontSize: 13.sp,
                                          fontFamily: "CormorantGaramond",
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 2.h,
                                          width: 2.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: blueColor,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        customText(
                                          text: "Dinner",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: blackColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),

                          // Calendar Image
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: (){
                                showEventDialog(context);
                              },
                                child: Image.asset("assets/png/calender.png")),
                          ),
                          SizedBox(height: 3.h),

                          // Invitations
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "Invitations",
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "CormorantGaramond",
                                  color: blackColor,
                                ),
                                InkWell(
                                  onTap: () => controller.goToSeeAllPage(),
                                  child: Row(
                                    children: [
                                      customText(
                                        text: "View All",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                      SizedBox(width: 1.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: blackColor,
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              children: [
                                invitationWidget(
                                  "Jenera Dinner Event",
                                  "20+ Attendees",
                                  "In New York",
                                  "May 12, 2025",
                                  "assets/png/dinner_event.png",
                                ),
                                SizedBox(width: 4.w),
                                invitationWidget(
                                  "Parkinson Dinner Event",
                                  "35+ Attendees",
                                  "Los Angeles",
                                  "May 18, 2025",
                                  "assets/png/dinner_event.png",
                                ),
                                SizedBox(width: 4.w),
                                invitationWidget(
                                  "Scorpio Dinner Event",
                                  "50+ Attendees",
                                  "Miami Beach",
                                  "May 25, 2025",
                                  "assets/png/dinner_event.png",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),

                          // Upcoming Events
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "Upcoming Events",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "CormorantGaramond",
                                  color: blackColor,
                                ),
                                InkWell(
                                  onTap: () => controller.viewAllEvents(),
                                  child: Row(
                                    children: [
                                      customText(
                                        text: "View All",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                      SizedBox(width: 1.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: blackColor,
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 41.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 3.w),
                                  child: upComingEventWidget(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        foregroundColor: whiteColor,
        shape: const CircleBorder(),
        onPressed: () {
          showRedirectingDialog(context);
        },
        child: Image.asset(
          "assets/png/floating_bar_icon.png",
          height: 6.h,
          width: 6.w,
        ),
      ),
    );
  }
}
