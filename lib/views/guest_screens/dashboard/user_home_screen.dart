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
    bool isHost = prefs.getString(LocalDBKeys.ISHOST) == "true";
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
                        height: 0.1.h,
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
                    onTap: () {
                      Get.toNamed("viewallinvitation");
                    },
                    child: homeIconWidget(
                      imagePath: "assets/png/icons/add-user.png",
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  InkWell(
                    onTap: () {
                      Get.toNamed("mynotificationscreen");
                    },
                    child: homeIconWidget(icon: Icons.notifications),
                  ),
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
                                      text: "Dinner Calendar",
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
                                          decoration: const BoxDecoration(
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
                                          decoration: const BoxDecoration(
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

                          // Calendar Box
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                child: Obx(() {
                                  // Force GetX reactive tracking for calendar data updates
                                  final _ = eventController.getAllEventsModel.value;

                                  return TableCalendar(
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: eventController.focusedDay.value,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(eventController.selectedDay.value, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      eventController.selectedDay.value = selectedDay;
                                      eventController.focusedDay.value = focusedDay;

                                      showEventDialog(
                                        context,
                                        selectedDay,
                                      );
                                    },

                                    /// 🔥 EVENTS SOURCE
                                    eventLoader: (day) {
                                      int count = 0;

                                      // 1. Try to get count from calendar API data
                                      final calendar = eventController.getAllEventsModel.value?.data?.calendar;
                                      if (calendar != null) {
                                        final monthName = calendar.month ?? "";
                                        final currentMonthName = _getMonthName(day.month);
                                        if (monthName.trim().toLowerCase() == currentMonthName.trim().toLowerCase()) {
                                          final dates = calendar.dates;
                                          if (dates != null) {
                                            final dateInfo = dates[day.day.toString()];
                                            if (dateInfo != null) {
                                              count = dateInfo.eventCount ?? (dateInfo.eventIds?.length ?? 0);
                                            }
                                          }
                                        }
                                      }

                                      // 2. Fallback: Scan upcomingEvents list directly for matching date
                                      if (count == 0) {
                                        final upcomingEvents = eventController.getAllEventsModel.value?.data?.data ?? [];
                                        final matchingEvents = upcomingEvents.where((e) {
                                          return e.eventTime != null &&
                                              e.eventTime!.year == day.year &&
                                              e.eventTime!.month == day.month &&
                                              e.eventTime!.day == day.day;
                                        }).toList();
                                        count = matchingEvents.length;
                                      }

                                      if (count == 0) return [];
                                      return List.generate(count, (index) => index);
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
                                        color: foodBoundariesBorderGreenColor,
                                        borderRadius: BorderRadius.circular(12.sp),
                                      ),
                                      todayTextStyle: TextStyle(
                                        color: whiteColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      cellMargin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                                    ),

                                    /// 🔥 MULTIPLE MARKERS
                                    calendarBuilders: CalendarBuilders(
                                      selectedBuilder: (context, day, focusedDay) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                                          decoration: BoxDecoration(
                                            color: foodBoundariesBorderGreenColor.withAlpha(160),
                                            borderRadius: BorderRadius.circular(12.sp),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${day.day}',
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      markerBuilder: (context, date, events) {
                                        if (events.isEmpty) return const SizedBox();

                                        // Using Positioned inside TableCalendar's underlying Stack layout to force space down
                                        return Positioned(
                                          bottom: 1, // Controls the distance from the bottom edge of the cell matrix
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: events.asMap().entries.map((entry) {
                                                  final index = entry.key;
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                      left: index * 6.0, // Clean horizontal separation space
                                                    ),
                                                    height: 5.5,
                                                    width: 5.5,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: greenColor,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),

                          // Upcoming Events Label
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

                          // Upcoming Events Content
                          Obx(() {
                            final eventData = eventController.getAllEventsModel.value?.data?.data;
                            if (eventController.isLoadingAllEvents.value == true) {
                              return Padding(
                                padding: EdgeInsets.only(top: 7.h),
                                child: SizedBox(
                                  child: Center(child: CircularProgressIndicator(color: greenColor)),
                                ),
                              );
                            }
                            if (eventData == null || eventData.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(top: 7.h),
                                child: Center(child: customText(text: 'No events found!', fontSize: 14.5.sp)),
                              );
                            }
                            return SizedBox(
                              height: 43.5.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                itemCount: eventData.length,
                                itemBuilder: (context, index) {
                                  final data = eventData[index];
                                  String displayLocation = (data.address != null)
                                      ? "${data.address}"
                                      : "132 My Street, Kingston, New York 12486";
                                  return Padding(
                                    padding: EdgeInsets.only(right: 3.w),
                                    child: upComingEventWidget(
                                      eventName: data.eventName ?? "Sophia Dinner Event",
                                      eventDate: controller.formatDate2(data.eventTime),
                                      eventTime: controller.formatTime2(data.eventTime),
                                      eventHost: data.host?.name ?? "Sophia Andreas",
                                      eventLocation: displayLocation,
                                      image: data.image,
                                      dietryscore: data.dietaryCompatibilityScore.toString(),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                          SizedBox(height: 10.h),
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


      floatingActionButton: isHost == false ? SizedBox.shrink() : buildCreateNewEventButton(context),
      floatingActionButtonLocation: isHost == false ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerFloat,
    );
  }
}

String _getMonthName(int month) {
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  if (month >= 1 && month <= 12) {
    return months[month - 1];
  }
  return "";
}
