import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/button_widget.dart';

import '../../guest_screens/profile_setup_screens/profile_edit_screen.dart';

class CreateNewEventScreen extends StatelessWidget {
  CreateNewEventScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final eventId = Get.arguments;
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
                  SizedBox(width: eventId == null ? 10.w: 17.w),
                  customText(
                    text: eventId == null ? "Create an Event": "Edit Event",
                    fontWeight: FontWeight.w500,
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
                  topLeft: Radius.circular(26.sp),
                  topRight: Radius.circular(26.sp),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 3.2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Container(
                        height: 25.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.transparent,
                        ),
                        child: Obx(() {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16.sp),
                            child: Stack(
                              children: [
                                controller.profilePicture.value != null
                                    ? Image.file(
                                  controller.profilePicture.value!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                                    : Image.asset(
                                  "assets/png/event_widget_icon/event.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),

                                if(controller.profilePicture.value == null)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                    onTap: () {
                                      controller.pickFromGallery();
                                    },
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
                                            "assets/png/icons/gallery.png",
                                            height: 18.sp,
                                            width: 18.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2.w),
                                          customText(
                                            text: "Select a cover photo",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                if(controller.profilePicture.value != null)
                                Positioned(
                                  top: 1.3.h,
                                  right: 2.5.w,
                                  child: InkWell(
                                    onTap: controller.removeImage,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.7.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5D8783).withOpacity(0.75),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.delete_outline_sharp,
                                        color: whiteColor,
                                        size: 5.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.5.w),
                          child: customText(
                            textAlign: TextAlign.start,
                            text: "Basic Details",
                            fontWeight: FontWeight.w500,
                            fontSize: 19.sp,
                            color: blackColor.withOpacity(0.4),
                            fontFamily: "CormorantGaramond",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  customText(text: "Event Name", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 2.2.h),
                              Row(
                                children: [
                                  customText(text: "Date", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 2.3.h),
                              Row(
                                children: [
                                  customText(text: "Event Time", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 2.2.h),
                              Row(
                                children: [
                                  customText(text: "Event Type", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 2.8.h),
                              Row(
                                children: [
                                  customText(text: "Location", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 2.5.h),
                              customText(text: "Check Guest\nNeeds Automatically.", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 2.h,),
                              customText(
                                text: "Enable Group\nConversation",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 3.6.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  customText(
                                      textAlign: TextAlign.start,
                                      text: "Extras",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19.sp,
                                      color: blackColor.withOpacity(0.4)),
                                ],
                              ),
                              customText(text: "Invitation Message", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 4.4.h),
                              customText(text: "Parking Details", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 4.2.h),
                              customText(text: "Add Note", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 3.4.h),
                              customText(text: "Reminder\nNotification", fontWeight: FontWeight.w500, fontSize: 15.sp),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // customText(text: "Gizelle Dinner Event", fontWeight: FontWeight.w400, fontSize: 15.sp),
                              customProfileField(
                                hint: 'Gizelle Dinner Event',
                                controller: eventController.eventName
                              ),
                              SizedBox(height: 0.25.h),
                              const Divider(),
                              // customText(text: "May 03, 2025", fontWeight: FontWeight.w400, fontSize: 15.sp),
                              customProfileField(
                                hint: 'May 03, 2025',
                                readonly: true,
                                controller: eventController.eventDate,
                                  suffixIcon: Icon(Icons.date_range), onSuffixTap: (){
                                eventController.pickDateOrTime(context: context, controller: eventController.eventDate, type: "date");
                              }
                              ),
                              SizedBox(height: 0.25.h),
                              const Divider(),
                              customProfileField(readonly: true, hint: "07:00 AM", controller: eventController.eventTime, suffixIcon: Icon(Icons.access_time_outlined), onSuffixTap: (){
                                eventController.pickDateOrTime(context: context, controller: eventController.eventTime, type: "time");
                              }),
                              SizedBox(height: 0.25.h),
                              const Divider(),
                              // --- EVENT TYPE DROPDOWN ---
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(

                                  customButton: Obx(() => Row(
                                    children: [
                                      customText(
                                        text: eventController.selectedEventType.value ?? "🍽️ Dinner Party",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                      ),
                                    ],
                                  )),
                                  items: ["🍽️ Dinner Party", "🎂 Birthday Celebration", "🍸 Cocktail", "⭐ Holiday","🥞 Brunch"]
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: customText(
                                      text: item,
                                      fontSize: 14.sp,         // Customize font size
                                      fontFamily: "WorkSans",
                                    ),
                                  ))
                                      .toList(),

                                  onChanged: (value) {
                                    if(value != null) {
                                      eventController.selectedEventType.value = value;
                                      eventController.eventType.text = value;
                                    }
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    width: 50.w,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor, // Background color of the dropdown sheet
                                    ),
                                    elevation: 8,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 45, // Height of each option in the list
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                  ),
                                )
                              ),
                              SizedBox(height: 0.25.h),
                              const Divider(),
                              SizedBox(height: 0.25.h),

                                  Obx(() {
                                    if (eventController.locationController.isLoading.value) {
                                      return const Center(child: CircularProgressIndicator(color: greenColor,));
                                    }
                                    return Row(
                                      children: [
                                        Expanded(
                                            child: customProfileField(readonly: true, hint: "132 My Street, Pasadena, CA 91101",
                                                controller: eventController.locationController.addressController,
                                            )
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 3.w),
                                          child: InkWell(
                                              onTap: () async{
                                                await eventController.locationController.getUserLocation();
                                                eventController.locationController.addressController.text =
                                                    eventController.locationController.address.value;
                                    },
                                              child: Image.asset('assets/png/icons/location_pointer.png', width: 6.w)),
                                        ),

                                      ],
                                    );
                                  }),
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
                                        onChanged: (val) => controller.toggleSwitch(val),
                                      ),
                                    ),
                                  ),
                                ],
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
                                        value: controller.switchValue3.value,
                                        onChanged: (val) => controller.toggleSwitch3(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              SizedBox(height: 6.h),

                              customProfileField(hint: 'You\'re invited to a dinner party', size: 14.8.sp,
                                  controller: eventController.inviteMsg
                              ),
                              SizedBox(height: 1.25.h),
                              const Divider(),
                              SizedBox(height: 1.25.h),
                              customProfileField(hint: 'Street parking after 6pm; Lot behind venue.', size: 14.8.sp,
                                  controller: eventController.parkingDetails
                              ),
                              SizedBox(height: 1.25.h),
                              const Divider(),
                              SizedBox(height: 1.25.h),
                              customProfileField(hint: 'Add extra details for your guests.', size: 14.8.sp,
                                  controller: eventController.addNote
                              ),
                              SizedBox(height: 1.25.h),
                              const Divider(),
                              SizedBox(height: 1.25.h),
                              // --- REMINDER DROPDOWN ---
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  customButton: Obx(() => Row(
                                    children: [
                                      customText(
                                        text: eventController.selectedReminderTime.value ?? "Select time",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: eventController.selectedReminderTime.value == null ? Colors.grey : blackColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                      ),
                                    ],
                                  )),
                                  items: ["15 mins before", "1 hour before", "1 day before"]
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: customText(
                                      text: item,

                                        color: blackColor,       // Customize item text color
                                        fontSize: 14.sp,         // Customize font size
                                        fontFamily: "WorkSans",  // Customize font family
                                        fontWeight: FontWeight.w400,
                                    ),
                                  ))
                                      .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          eventController.selectedReminderTime.value = value;
                                          eventController.eventReminder.text = value;
                                        }
                                        },
                                  dropdownStyleData: DropdownStyleData(
                                    width: 45.w,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor, // Background color of the dropdown sheet
                                    ),
                                    elevation: 8,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 45,
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                  ),
                                )
                              ),
                              SizedBox(height: 1.25.h),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: buttonWidget("Continue", whiteColor, colors: greenColor, onTap: () {
                        // Get.toNamed("guestlistscreen");
                        Get.toNamed("foodmenuscreen", arguments: eventId);
                      }),
                    ),
                    SizedBox(height: 3.h),
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
