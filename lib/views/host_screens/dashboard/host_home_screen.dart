import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/event_dialog.dart';
import '../../../widget/complete_guest_dialog.dart';
import '../../../widget/home_screen_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collection/collection.dart';


class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isProfileComplete.value &&
          !controller.hasCheckedProfile.value) {
        controller.hasCheckedProfile.value = true;
        completeGuestProfileDialog(context);
      }
    });
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
                        text: "Hi, Gizelle Jekronia",
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
                    onTap: () {
                      controller.goTSearchScreen();
                    },
                    child: homeIconWidget(icon: Icons.search),
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {
                      controller.goToNotificationPage();
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
                                      text: "Quick Report",
                                      fontSize: 20.sp,
                                      fontFamily: "CormorantGaramond",
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                    customText(
                                      text:
                                      "Lorem ipsum dolor sit amet consectetur.",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                    SizedBox(height: 1.5.h),
                                    // Inside your Column > children, replace the Container block with this:
                                    Obx(
                                          () => Container(
                                        width: 88.w,
                                        height: 4.5.h,
                                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.sp),
                                          border: Border.all(color: const Color(0xFF5A7C79)),
                                          color: const Color(0xFFF6EEEB),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            value: controller.selectedEvent.value.isEmpty
                                                ? null
                                                : controller.selectedEvent.value,

                                            iconStyleData: const IconStyleData(
                                              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                              iconSize: 24,
                                            ),

                                            hint: customText(
                                              text: "Select The Event",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),

                                            dropdownStyleData: DropdownStyleData(
                                              offset: const Offset(0, -7),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.sp),
                                                color: Colors.white,
                                              ),
                                            ),

                                            // ✅ Fix: Show selected value without tick
                                            selectedItemBuilder: (context) {
                                              return controller.events.map((value) {
                                                return Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: customText(
                                                    text: value,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                );
                                              }).toList();
                                            },

                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                controller.selectEvent(newValue);
                                              }
                                            },

                                            // ✅ Dropdown list with check and dividers
                                            items: controller.events.mapIndexed((index, value) {
                                              final isLast = index == controller.events.length - 1;

                                              return DropdownMenuItem<String>(
                                                value: value,
                                                enabled: true,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 1.h), // consistent spacing for all items
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          customText(
                                                            text: value,
                                                            fontSize: 15.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          if (controller.selectedEvent.value == value)
                                                            Icon(Icons.check, size: 18.sp),
                                                        ],
                                                      ),
                                                    ),
                                                    if (!isLast)
                                                      Container(
                                                        height: 1,
                                                        color: Colors.grey[300],
                                                      ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),

                                          ),
                                        ),
                                      ),
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
                                onTap: () {
                                  showEventDialog(context);
                                },
                                child: Container(
                                  height: 30.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          20.sp),
                                      color: whiteColor

                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 3.h),

                          // Invitations
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  text: "RSVP",
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "CormorantGaramond",
                                  color: blackColor,
                                ),
                                Row(
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
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              children: [
                                adminHomeWidget(
                                  eventname: "Gizelle Dinner Event",
                                  confirmedamount: "25 Guest Confirmed",
                                  value: 0.85
                                ), adminHomeWidget(
                                  eventname: "Gizelle Lunch Event",
                                  confirmedamount: "24 Guest Confirmed",
                                    progress: "(25/24)",
                                  value: 0.95
                                ), adminHomeWidget(
                                  eventname: "Thanksgiving Dinner Event",
                                  confirmedamount: "08 Guest Confirmed",
                                    progress: "(15/08)",
                                  value: 0.65

                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
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
      floatingActionButton: buildCreateNewEventButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget adminHomeWidget({String? eventname, String? confirmedamount,String? progress,double? value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: GestureDetector(
        onTap: () {
          Get.toNamed("eventdetailsscreen");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with image and content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: Image.asset(
                    "assets/png/admin_home_foodpic.png",
                    height: 7.h,
                    width: 15.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 3.w),

                // Text content beside image
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row with Event name and (30/25)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: customText(
                              text: eventname ?? "",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "CormorantGaramond",
                              color: blackColor,
                            ),
                          ),
                          customText(
                            text: progress ?? "(30/25)",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ],
                      ),
                      customText(
                        text: confirmedamount ?? "",
                        // e.g. "25 Guest Confirmed"
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                      SizedBox(height: 0.8.h),
                      // Progress bar (inside content column)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.sp),
                        child: LinearProgressIndicator(
                          minHeight: 0.7.h,
                          value: value,
                          valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                          backgroundColor: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

Widget buildCreateNewEventButton(BuildContext context) {
  return SizedBox(
    height: 27.sp, // 🔁 Adjust height here
    child: FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed("createneweventscreen");
      },
      label: Row(
        children: [
          Icon(
            Icons.add,
            size: 20.sp,
            color: Colors.white,
          ),
          SizedBox(width: 2.w),
          customText(
            text: "Create A New Event",
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "CormorantGaramond",
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: blueColor,
      // ✅ use your desired color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.sp),
      ),
      elevation: 5,
    ),
  );
}

