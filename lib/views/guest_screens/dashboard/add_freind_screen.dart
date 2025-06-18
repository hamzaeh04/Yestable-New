import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/home_screen_widget.dart';

class AddFreindScreen extends StatelessWidget {
  AddFreindScreen({super.key});
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
                    text: "Add Friends",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
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
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: TextField(
                            style: TextStyle(
                                fontSize: 13.sp, fontFamily: "WorkSans"),
                            // Optional: shrink text size
                            decoration: InputDecoration(
                              isDense: true,
                              // Shrinks the vertical height
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.2.h, horizontal: 4.w),
                              // Reduce vertical padding
                              hintText: 'Search Here',
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, fontFamily: "WorkSans"),
                              filled: true,
                              fillColor: backgroundColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                                borderSide: BorderSide(
                                    color: lightgreenColor, width: 0.2.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                                borderSide: BorderSide(
                                    color: lightgreenColor, width: 0.2.w),
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
                        SizedBox(height: 2.h),
                        addFriendWidget(
                          url: "assets/png/chat_images/user1.png",
                          msgtitle: "Samuel Kendrio",
                          msgText: "20+ Mutual Friends",
                          cheque: true,
                          btnText: "Message",
                          place: "Live In New York"
                        ),
                        SizedBox(height: 1.h),
                        addFriendWidget(
                            url: "assets/png/chat_images/user1.png",
                            msgtitle: "Samuel Kendrio",
                            msgText: "20+ Mutual Friends",
                            cheque: true,
                            btnText: "Add Friend",
                            place: "Live In New York"
                        ),
                        SizedBox(height: 1.h),
                        addFriendWidget(
                            url: "assets/png/chat_images/user1.png",
                            msgtitle: "Samuel Kendrio",
                            msgText: "20+ Mutual Friends",
                            cheque: true,
                            btnText: "Add Friend",
                            place: "Live In New York"
                        ),
                        SizedBox(height: 1.h),
                        addFriendWidget(
                            url: "assets/png/chat_images/user1.png",
                            msgtitle: "Samuel Kendrio",
                            msgText: "20+ Mutual Friends",
                            cheque: true,
                            btnText: "Add Friend",
                            place: "Live In New York"
                        ),
                        /// Tab Bar Widget
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
  Widget addFriendWidget({
    required String url,
    String? msgtitle,
    String? msgText,
    String? btnText,
    String? place,
    bool cheque = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w), // Left padding only
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(url, width: 16.w, height: 16.w, fit: BoxFit.cover),
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
                              customText(
                                text: msgtitle ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "CormorantGaramond",
                              ),
                            ],
                          ),

                          customText(
                            text: place ?? "",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: darkGreyColor,
                          ),
                          SizedBox(height: 0.3.h),
                          /// Message Text
                          customText(
                            text: msgText ?? "my text",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: darkGreyColor,
                          ),
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
                          btnText ?? '',
                          whiteColor,
                          colors: greenColor,
                          fontsize: 14.sp,
                          height: 2.5.h,
                          width: 20.w,
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
