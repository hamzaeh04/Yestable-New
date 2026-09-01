import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/home_screen_widget.dart';
import 'package:yestable/widget/floating_home_button.dart';

class ProfileChatMessage extends StatelessWidget {
  const ProfileChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      screen: Scaffold(
        backgroundColor: greenColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    color: lightgreenColor,
                    iconsize: 16.sp,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/png/chat_images/user1.png",
                          height: 6.h,
                          width: 15.w,
                        ),
                        SizedBox(width: 2.w),
                        customText(
                          text: "Sidney Swaniawski",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                          fontFamily: "CormorantGaramond",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Scrollable bottom half with pinned input bar
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
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/png/chat_images/chat_background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // TODO: Add messages list here (scrollable area)

                      // Blue "Today" date bubble centered above input bar
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h), // Above input bar
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5.h,
                              horizontal: 5.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: customText(
                              text: "Today",
                              color: Colors.blueAccent,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),

                          ),
                        ),
                      ),

                      // Input bar pinned to bottom
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(25.sp),
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 1.h).copyWith(left: 1.w),
                                        hintText: "Write Something Here!",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontFamily: "WorkSans",
                                          fontWeight: FontWeight.w400
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                          maxHeight: 6.h,
                                          maxWidth: 6.w,
                                        ),
                                        suffixIcon: SizedBox(
                                          height: 5.h,
                                          width: 5.w,
                                          child: Image.asset(
                                            "assets/png/icons/office_pin_icon.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "WorkSans",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Image.asset(
                                  "assets/png/icons/send_message_icon.png",
                                  height: 6.h,
                                  width: 6.w,
                                )
                              ],
                            ),
                          ),
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
    ),
    );
  }
}
