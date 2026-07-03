import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/event_controller.dart';
import '../controllers/navigation_controller.dart';
import 'event_widget.dart';
import 'home_screen_widget.dart';

void showEventDialog(BuildContext context, DateTime selectedDay) {
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center( // Wrap Dialog in Center to allow full-width
        child: Container(
          width: 90.w, // Increased width
          child: Dialog(
            insetPadding: EdgeInsets.zero, // Disable default padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.sp),
            ),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: 60.h,
              ),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: backgroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: controller.formatDate2(selectedDay),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.5.h),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.close, size: 18.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    // Event 1
                    Obx((){
                      if (eventController.isLoadingAllEvents.value == true) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: SizedBox(
                              child: Center(child: CircularProgressIndicator(color: greenColor,))),
                        );
                      }

                      final calendar = eventController.getAllEventsModel.value?.data?.calendar;
                      List<String> targetEventIds = [];
                      if (calendar != null) {
                        final monthName = calendar.month ?? "";
                        final currentMonthName = _getMonthName(selectedDay.month);
                        if (monthName.toLowerCase() == currentMonthName.toLowerCase()) {
                          final dates = calendar.dates;
                          if (dates != null) {
                            final dateInfo = dates[selectedDay.day.toString()];
                            if (dateInfo != null) {
                              targetEventIds = dateInfo.eventIds ?? [];
                            }
                          }
                        }
                      }

                      final allEvents = eventController.getAllEventsModel.value?.data?.data ?? [];
                      final eventData = allEvents.where((e) {
                        final matchesId = targetEventIds.contains(e.id);
                        final matchesDate = e.eventTime != null &&
                            e.eventTime!.year == selectedDay.year &&
                            e.eventTime!.month == selectedDay.month &&
                            e.eventTime!.day == selectedDay.day;
                        return matchesId || matchesDate;
                      }).toList();

                      if (eventData.isEmpty) {
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.h),
                            child: Center(child: customText(text: 'No events found!', fontSize: 14.5.sp))
                        );
                      }

                      return SizedBox(
                        height: 40.h, // or any max height you want
                        child: ListView.builder(
                          itemCount: eventData.length,
                          itemBuilder: (context, index) {
                            final data = eventData[index];
                            String displayLocation = (data.address != null)
                                ? "${data.address}"
                                : "132 My Street, Kingston, New York 12486";
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    color: blueColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                                    child: customText(
                                      text: "In ${controller.getRemainingTime(data.eventTime ?? DateTime.now())}" ?? "In 13 Hrs",
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: whiteColor,
                                      fontFamily: "CormorantGaramond",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed("eventdetailsscreen", arguments: data.id);
                                    },
                                    child: eventScreenWidget(
                                        bgcolor: backgroundColor,
                                        eventName: data.eventName ?? "Sophia Dinner Event",
                                        eventDate: controller.formatDate2(data.eventTime),
                                        eventTime: controller.formatTime2(data.eventTime),
                                        eventHost: data.host?.name ?? "Sophia Andreas",
                                        eventLocation: displayLocation,
                                        image: data.image,
                                        value: ((data.dietaryCompatibilityScore ?? 0).toDouble() / 100),
                                        estimatedGuest: (data.estimatedGuests ?? 0).toString(),
                                        joinedGuest: (data.numGuests ?? 0).toString(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    })
                    // SizedBox(height: 1.h),
                    // // Event 2
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25.sp),
                    //         color: blueColor,
                    //       ),
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                    //         child: customText(
                    //           text: "In 20 Hrs",
                    //           fontSize: 13.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: whiteColor,
                    //           fontFamily: "CormorantGaramond",
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 4.w),
                    //     Expanded(
                    //       child: InkWell(
                    //         onTap: () {
                    //           Get.toNamed("eventdetailsscreen");
                    //         },
                    //         child: eventScreenWidget(bgcolor: backgroundColor),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
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



