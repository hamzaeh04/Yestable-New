import 'package:dropdown_button2/dropdown_button2.dart';
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
                  SizedBox(width: 10.w),
                  customText(
                    text: "Create an Event",
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
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 25.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.sp),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/png/event_widget_icon/event.png",
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
                                Positioned(
                                    top: 1.3.h,
                                    right: 2.5.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.7.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5D8783).withOpacity(0.75),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.delete_outline_sharp, color: whiteColor, size: 5.w),
                                    ))
                              ],
                            ),
                          ),
                        ),
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
                              SizedBox(height: 2.2.h),
                              Row(
                                children: [
                                  customText(text: "Location", fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  customText(text: '*', color: redColor)
                                ],
                              ),
                              SizedBox(height: 3.7.h),
                              customText(text: "Check Guest\nNeeds Automatically.", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 2.h),
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
                              SizedBox(height: 5.h),
                              customText(text: "Parking Details", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 5.8.h),
                              customText(text: "Add Note", fontWeight: FontWeight.w500, fontSize: 15.sp),
                              SizedBox(height: 4.h),
                              customText(text: "Reminder\nNotification", fontWeight: FontWeight.w500, fontSize: 15.sp),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(text: "Gizelle Dinner Event", fontWeight: FontWeight.w400, fontSize: 15.sp),
                              SizedBox(height: 0.4.h),
                              const Divider(),
                              customText(text: "May 03, 2025", fontWeight: FontWeight.w400, fontSize: 15.sp),
                              SizedBox(height: 0.4.h),
                              const Divider(),
                              // --- EVENT TIME DROPDOWN ---
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  customButton: Row(
                                    children: [
                                      customText(text: "07 : 00 AM", fontWeight: FontWeight.w400, fontSize: 15.sp),
                                      SizedBox(width: 2.w),
                                      Icon(Icons.keyboard_arrow_down_rounded, size: 18.sp),
                                    ],
                                  ),
                                  items: ["07 : 00 AM", "08 : 00 AM", "09 : 00 AM", "10 : 00 AM"]
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: blackColor, // Change text color
                                        fontSize: 14.sp,    // Change font size
                                        fontFamily: "WorkSans", // Change font family
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    // Handle change
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    width: 35.w,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: whiteColor, // Background color of the dropdown sheet
                                    ),
                                    elevation: 8, // Optional: gives a shadow effect to the sheet
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40, // Adjust the height of each item in the list
                                    padding: EdgeInsets.only(left: 14, right: 14),
                                  ),
                                )
                              ),
                              SizedBox(height: 0.4.h),
                              const Divider(),
                              // --- EVENT TYPE DROPDOWN ---
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  customButton: Row(
                                    children: [
                                      customText(
                                        text: "🍽️ Dinner Party",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                                  items: ["🍽️ Dinner Party", "🎂 Birthday Celebration", "🍸 Cocktail", "⭐ Holiday","🥞 Brunch"]
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: blackColor,       // Change to your preferred text color
                                        fontSize: 14.sp,         // Change font size
                                        fontFamily: "WorkSans",  // Change to your desired font family
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    // Handle selection logic here
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
                              SizedBox(height: 0.4.h),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: customText(
                                      text: "132 My Street, Pasadena, CA 91101",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: darkGreyColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 3.w),
                                    child: Image.asset('assets/png/icons/location_pointer.png', width: 6.w),
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
                                        value: controller.switchValue.value,
                                        onChanged: (val) => controller.toggleSwitch(val),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              SizedBox(height: 3.4.h),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'You\'re invited to a dinner party',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontFamily: "WorkSans"),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(color: Colors.black, fontSize: 14.sp, fontFamily: "WorkSans"),
                                maxLines: null,
                              ),
                              SizedBox(height: 2.5.h),
                              const Divider(),
                              SizedBox(height: 0.8.h),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Street parking after 6pm; Lot behind venue.',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontFamily: "WorkSans"),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(color: Colors.black, fontSize: 14.sp, fontFamily: "WorkSans"),
                                maxLines: null,
                              ),
                              SizedBox(height: 1.h),
                              const Divider(),
                              SizedBox(height: 0.8.h),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Add extra details for your guests.',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontFamily: "WorkSans"),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: TextStyle(color: Colors.black, fontSize: 14.sp, fontFamily: "WorkSans"),
                                maxLines: null,
                              ),
                              SizedBox(height: 2.5.h),
                              const Divider(),
                              SizedBox(height: 1.h),
                              // --- REMINDER DROPDOWN ---
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  customButton: Row(
                                    children: [
                                      customText(
                                        text: "Select time",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                                  items: ["15 mins before", "1 hour before", "1 day before"]
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: blackColor,       // Customize item text color
                                        fontSize: 14.sp,         // Customize font size
                                        fontFamily: "WorkSans",  // Customize font family
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    // Logic for selection
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
                              SizedBox(height: 1.h),
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
                        Get.toNamed("guestlistscreen");
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
