import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/event_widget.dart';
import '../../../widget/home_screen_widget.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();
  final prefs = SharedPreferencesMethod.storage;

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
                  // InkWell(
                  //   onTap: () {
                  //     // controller.goTSearchScreen();
                  //
                  //   },
                  //   child: homeIconWidget(
                  //     imagePath: "assets/png/icons/search_icon.png",
                  //   ),
                  // ),
                  // SizedBox(width: 2.w),
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

            /// 👇 This is the scrollable bottom half with rounded corners
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  width: double.infinity,
                  color: backgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 3.h,
                          ),
                          child: customText(
                            text: "Upcoming Events",
                            fontSize: 19.sp,
                            fontFamily: "CormorantGaramond",
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                        Obx(() {
                          final eventData = eventController.getAllEventsModel.value?.data?.data;

                          // Loader for first page
                          if (eventController.isLoadingAllEvents.value)
                            return Column(
                              children: [
                                SizedBox(height: 27.h),
                                Center(
                                  child: CircularProgressIndicator(color: greenColor),
                                ),
                              ],
                            );

                          // No data
                          if (eventData == null || eventData.isEmpty)
                            return Column(
                              children: [
                                SizedBox(height: 27.h),
                                Center(
                                  child: customText(
                                    text: 'No upcoming events found!',
                                    fontSize: 14.5.sp,
                                  ),
                                ),
                              ],
                            );

                          return Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: eventData.length,
                                itemBuilder: (context, index) {
                                  final data = eventData[index];
                                  String displayLocation =
                                  (data?.location?.coordinates != null)
                                      ? "${data!.location!.coordinates![1]}, ${data.location!.coordinates![0]}"
                                      : "132 My Street, Kingston, New York 12486";

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25.sp),
                                              color: blueColor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2.w,
                                                vertical: 0.5.h,
                                              ),
                                              child: customText(
                                                text: "In ${controller.getRemainingTime(data?.eventTime?? DateTime.now())}",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: whiteColor,
                                                fontFamily: "CormorantGaramond",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed("eventdetailsscreen", arguments: data?.id);
                                          },
                                          child: eventScreenWidget(
                                            bgcolor: backgroundColor,
                                            image: data!.image,
                                            eventName: data?.eventName ?? "Sophia Dinner Event",
                                            eventDate: controller.formatDate2(data?.eventTime),
                                            eventTime: controller.formatTime2(data?.eventTime),
                                            eventHost: data?.host?.name ?? "Sophia Andreas",
                                            eventLocation: data?.address ?? "12 Mississippi, USA",
                                            value: (data.dietaryCompatibilityScore!.toDouble()/100),
                                            estimatedGuest: data.estimatedGuests.toString(),
                                            joinedGuest: data.numGuests.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 2.h),

                              // Load More Button
                              if (eventController.currentPage.value < eventController.totalPages.value)
                                ElevatedButton(
                                  onPressed: eventController.isLoadingMore.value
                                      ? null
                                      : () => eventController.getAllEvents(loadMore: true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: greenColor,
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                                  ),
                                  child: eventController.isLoadingMore.value
                                      ? SizedBox(
                                    height: 2.h,
                                    width: 2.h,
                                    child: CircularProgressIndicator(
                                      color: greenColor,
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : customText(
                                    text: "Load More",
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              SizedBox(height: 5.h,)
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
