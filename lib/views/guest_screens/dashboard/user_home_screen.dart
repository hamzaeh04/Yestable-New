import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/outh_file/local_db_key.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/event_dialog.dart';
import 'package:yestable/widget/redirecting_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/event_floating_button.dart';
import '../../../widget/home_screen_widget.dart';
import '../../../widget/you_are_invited_dialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();
  final AuthController authController = Get.find<AuthController>();
  final prefs = SharedPreferencesMethod.storage;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // SIRF YEH SIMPLE CHECK: Kya dialog pehle dikha chuke hain?
    //   if (controller.hasShownInvitedDialog.value == false) {
    //
    //     // 1. Foran lock kar dein taake dobara na chale
    //     controller.hasShownInvitedDialog.value = true;
    //
    //     // 2. Dialog dikha dein
    //     youAreInvitedDialog(context);
    //
    //     print("Dialog shown for the first time.");
    //   }
    // });
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
                        text: "Hi, ${prefs.getString(LocalDBKeys.USERFULLNAME) ?? ""}!",
                        fontSize: 20.sp,
                        fontFamily: "CormorantGaramond",
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                        height: 0.1.h
                      ),
                      customText(
                        text: controller.formatDate2(DateTime.now()) ?? "May 01, 2025",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      // controller.goTSearchScreen();
                    },
                      child: homeIconWidget(imagePath: "assets/png/icons/search_icon.png", )
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: (){
                      Get.toNamed("mynotificationscreen");
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
                                      text: "Dinner Calender",
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
                                          fontWeight: FontWeight.w400,
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
                            child: Container(

                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16.sp),

                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    showEventDialog(context);
                                  },
                                  child: AbsorbPointer(
                                    child: Column(
                                      children: [
                                        TableCalendar(
                                          firstDay: DateTime.utc(2010, 10, 16),
                                          lastDay: DateTime.utc(2030, 3, 14),
                                          focusedDay: DateTime.now(),

                                        /// 🔥 EVENTS SOURCE
                                        eventLoader: (day) {
                                          Map<DateTime, List> events = {
                                            DateTime.utc(2026, 3, 26): ['event1', 'event2'],
                                            DateTime.utc(2026, 3, 27): ['event1'],
                                          };

                                          return events[DateTime.utc(day.year, day.month, day.day)] ?? [];
                                        },

                                        headerVisible: false,

                                        daysOfWeekHeight: 4.h,
                                        rowHeight: 4.8.h,

                                        daysOfWeekStyle: DaysOfWeekStyle(
                                          weekdayStyle: TextStyle(
                                            color: foodBoundariesBorderGreenColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          weekendStyle: TextStyle(
                                            color: foodBoundariesBorderGreenColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        calendarStyle: CalendarStyle(
                                          defaultTextStyle: TextStyle(
                                            color: blackColor,
                                            fontSize: 14.5.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          weekendTextStyle: TextStyle(
                                            color: blackColor,
                                            fontSize: 14.5.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          outsideTextStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),

                                          todayDecoration: BoxDecoration(
                                            color: foodBoundariesBorderGreenColor.withAlpha(160),
                                            borderRadius: BorderRadius.circular(12.sp),
                                          ),
                                          todayTextStyle: TextStyle(
                                            color: whiteColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),

                                          selectedDecoration: BoxDecoration(
                                            color: foodBoundariesBorderGreenColor,
                                            borderRadius: BorderRadius.circular(12.sp),
                                          ),
                                          selectedTextStyle: TextStyle(
                                            color: whiteColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),

                                          cellMargin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                                        ),

                                        /// 🔥 MULTIPLE MARKERS (2 dots: green + blue)
                                        calendarBuilders: CalendarBuilders(
                                          markerBuilder: (context, date, events) {
                                            if (events.isEmpty) return SizedBox();

                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: events.take(2).toList().asMap().entries.map((entry) {
                                                int index = entry.key;

                                                return Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 1, vertical: 0.6.h),
                                                  width: 1.w,
                                                  height: 1.h,
                                                  decoration: BoxDecoration(
                                                    color: index == 0 ? greenColor : blueColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                );
                                              }).toList(),
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
                          SizedBox(height: 1.h),

                          // // Invitations
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 4.w),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       customText(
                          //         text: "Invitations",
                          //         fontSize: 19.sp,
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "CormorantGaramond",
                          //         color: blackColor,
                          //       ),
                          //       InkWell(
                          //         onTap: () => controller.goToSeeAllPage(),
                          //         child: Row(
                          //           children: [
                          //             customText(
                          //               text: "View All",
                          //               fontSize: 14.sp,
                          //               fontWeight: FontWeight.w400,
                          //               color: blackColor,
                          //             ),
                          //             SizedBox(width: 1.w),
                          //             Icon(
                          //               Icons.arrow_forward,
                          //               color: blackColor,
                          //               size: 16.sp,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 1.h),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   padding: EdgeInsets.symmetric(horizontal: 4.w),
                          //   child: Row(
                          //     children: [
                          //       invitationWidget(
                          //         "Jenera Dinner Event",
                          //         "20+ Attendees",
                          //         "In New York",
                          //         "May 12, 2025",
                          //         "assets/png/dinner_event.png",
                          //       ),
                          //       SizedBox(width: 4.w),
                          //       invitationWidget(
                          //         "Parkinson Dinner Event",
                          //         "35+ Attendees",
                          //         "Los Angeles",
                          //         "May 18, 2025",
                          //         "assets/png/dinner_event.png",
                          //       ),
                          //       SizedBox(width: 4.w),
                          //       invitationWidget(
                          //         "Scorpio Dinner Event",
                          //         "50+ Attendees",
                          //         "Miami Beach",
                          //         "May 25, 2025",
                          //         "assets/png/dinner_event.png",
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                      SizedBox(width: 1.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: blackColor,
                                        size: 15.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Obx((){
                            final eventData = eventController.getAllEventsModel.value?.data?.data;
                            if(eventController.isLoadingAllEvents.value == true)
                              return Padding(
                                padding: EdgeInsets.only(top: 7.h),
                                child: SizedBox(
                                    child: Center(child: CircularProgressIndicator(color: greenColor,))),
                              );
                            if(eventData == null || eventData.isEmpty)
                              return Padding(
                                  padding: EdgeInsets.only(top: 7.h),
                                  child: Center(child: customText(text: 'No events found!', fontSize: 14.5.sp))
                              );
                            return SizedBox(
                              height: 42.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                itemCount: eventData?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final data = eventData?[index];
                                  String displayLocation = (data?.location?.coordinates != null)
                                      ? "${data!.location!.coordinates![1]}, ${data.location!.coordinates![0]}"
                                      : "132 My Street, Kingston, New York 12486";
                                  return Padding(
                                    padding: EdgeInsets.only(right: 3.w),
                                    child: upComingEventWidget(
                                        eventName: data?.eventName  ?? "Sophia Dinner Event",
                                        eventDate: controller.formatDate2(data?.eventTime),
                                        eventTime: controller.formatTime2(data?.eventTime),
                                        eventHost: data?.host?.name ?? "Sophia Andreas",
                                        eventLocation: displayLocation,
                                      image: data?.image
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
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
        onPressed: () async {
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
