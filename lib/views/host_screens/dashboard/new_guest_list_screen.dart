import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/home_screen_widget.dart';

class NewGuestListScreen extends StatelessWidget {
  NewGuestListScreen({super.key});

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
                    onTap: () => Get.back(),
                  ),
                  SizedBox(width: 2.w),
                  customText(
                    text: "Guest List",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Scrollable Body
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  width: double.infinity,
                  color: backgroundColor,
                  child: Column(
                    children: [
                      /// Fixed Search Bar
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: "WorkSans",
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 1.2.h,
                              horizontal: 4.w,
                            ),
                            hintText: 'Search Here',
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "WorkSans",
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                              borderSide: BorderSide(
                                color: lightgreenColor,
                                width: 0.2.w,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.sp),
                              borderSide: BorderSide(
                                color: lightgreenColor,
                                width: 0.2.w,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Image.asset(
                                "assets/png/icons/search_icon.png",
                                height: 2.h,
                                width: 2.h,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minHeight: 2.h,
                              minWidth: 2.h,
                            ),
                          ),
                        ),
                      ),

                      /// Guest List (Scrollable)
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          children: [


                            /// Manually called guestListWiget with index
                            guestListWiget(
                              index: 0,
                              url:
                                  "assets/png/guest_list_images/guest_list1.png",
                              name: "Samuel Kendrio",
                              status: "VIP Guest • Table 1",
                              containerText: "Confirmed",
                              allergenPresent: false,
                            ),
                            guestListWiget(
                              index: 1,
                              url:
                                  "assets/png/guest_list_images/guest_list2.png",
                              name: "Michael Smith",
                              status: "Family Friend • Table 2",
                              containerText: "Confirmed",
                              allergenPresent: true,
                              allergy: "Severe nut allergy",
                            ),
                            guestListWiget(
                              index: 2,
                              url:
                                  "assets/png/guest_list_images/guest_list3.png",
                              name: "Samuel Kenleo",
                              status: "Colleague • Table 3",
                              containerText: "Pending",
                            ),
                            guestListWiget(
                              index: 3,
                              url:
                                  "assets/png/guest_list_images/guest_list4.png",
                              name: "Samuel Kendrale",
                              status: "Family • Table 1",
                              containerText: "Confirmed",
                              allergenPresent: true,
                              allergy: "Gluten intolerance",
                            ),
                            guestListWiget(
                              index: 4,
                              url:
                                  "assets/png/guest_list_images/guest_list3.png",
                              name: "Samuel Kenleo",
                              status: "Business Partner • Table 2",
                              containerText: "Declined",
                            ),
                            guestListWiget(
                              index: 5,
                              url:
                                  "assets/png/guest_list_images/guest_list2.png",
                              name: "Michael Smith",
                              status: "Family Friend • Table 2",
                              containerText: "Confirmed",
                              allergenPresent: true,
                              allergy: "Severe nut allergy",
                            ),
                            guestListWiget(
                              index: 6,
                              url:
                                  "assets/png/guest_list_images/guest_list3.png",
                              name: "Samuel Kenleo",
                              status: "Colleague • Table 3",
                              containerText: "Pending",
                            ),
                            guestListWiget(
                              index: 7,
                              url:
                                  "assets/png/guest_list_images/guest_list4.png",
                              name: "Samuel Kendrale",
                              status: "Family • Table 1",
                              containerText: "Confirmed",
                              allergenPresent: true,
                              allergy: "Gluten intolerance",
                            ),
                            guestListWiget(
                              index: 8,
                              url:
                                  "assets/png/guest_list_images/guest_list3.png",
                              name: "Samuel Kenleo",
                              status: "Business Partner • Table 2",
                              containerText: "Declined",
                            ),
                            SizedBox(height: 5.h),
                          ],
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

  Widget guestListWiget({
    required int index,
    required String url,
    String? name,
    String? status,
    String? containerText,
    Color? containerColor,
    bool? allergenPresent,
    String? allergy,
  }) {
    return Container(
      color: index % 2 == 1 ? guestlistbackgroundColor : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(url, width: 18.w, height: 18.w, fit: BoxFit.cover),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name and Icons Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: customText(
                          text: name,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Image.asset(
                        "assets/png/icons/guest_list_pin.png",
                        width: 4.w,
                        color: allergenPresent == true ? Colors.blue : null,
                      ),
                      SizedBox(width: 3.w),
                      Image.asset(
                        "assets/png/icons/guest_list_alert.png",
                        width: 4.w,
                        color:
                            allergenPresent == true ? allergenredColor : null,
                      ),
                      SizedBox(width: 3.w),
                      Image.asset(
                        "assets/png/icons/guest_list_hamburg.png",
                        width: 4.w,
                      ),
                    ],
                  ),

                  /// Status
                  customText(
                    text: status,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "WorkSans",
                    color: darkGreyColor
                  ),
                  SizedBox(height: 0.3.h),

                  /// Badge + Allergy
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 0.3.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color:
                          containerText == "Confirmed"
                                  ? lightGreenColor
                                  : containerText == "Pending"
                                  ? lightyellowColor
                                  : containerText == "Declined"
                                  ? lightredColor
                                  : null,
                        ),
                        child: customText(
                          text: containerText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "WorkSans",
                        ),
                      ),
                      if (allergenPresent == true) ...[
                        SizedBox(width: 3.w),
                        Image.asset(
                          "assets/png/guest_list_images/allergy_icon.png",
                          width: 4.w,
                        ),
                        SizedBox(width: 2.w),
                        customText(
                          text: allergy,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "WorkSans",
                          color: Colors.red,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
