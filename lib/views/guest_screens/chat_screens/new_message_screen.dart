import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({super.key});

  // Inline widget function for user info row
  Widget userInfoRow({
    required String imageUrl,
    required String username,
    required String address,
  }) {
    return InkWell(
      onTap: (){
        Get.toNamed("profilechatmessage");
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Image.asset(
                    imageUrl,
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: username,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: "CormorantGaramond"
                    ),
                    customText(
                      text: address,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: darkGreyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

        ],
      ),
    );
  }

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
            // Top App Bar Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
      },
                    child: customText(
                      text: "Cancel",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(width: 19.w),
                  customText(
                    text: "New Messages",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Bottom half scrollable content
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Name Here',
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "WorkSans",
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: backgroundColor,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                    horizontal: 2.w,
                                  ),
                                  prefix: Padding(
                                    padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                    child: customText(
                                      text: 'To:',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    borderSide: BorderSide(color: lightgreenColor, width: 0.5.w),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    borderSide: BorderSide(color: lightgreenColor, width: 0.5.w),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: "WorkSans",
                                ),
                              ),
                            ),

                            // Example user info rows

                            // Add more userInfoRow widgets as needed
                          ],
                        ),
                        userInfoRow(
                          imageUrl: 'assets/png/chat_images/user1.png',
                          username: 'Sidney Swaniawski',
                          address: 'Live In New York',
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                        userInfoRow(
                          imageUrl: 'assets/png/chat_images/user2.png',
                          username: 'Eloise Brakus',
                          address: 'Live In New York',
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                        userInfoRow(
                          imageUrl: 'assets/png/chat_images/user3.png',
                          username: 'Gustavo Bode',
                          address: 'Live In New York',
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                        userInfoRow(
                          imageUrl: 'assets/png/chat_images/user4.png',
                          username: 'Darla Mohr',
                          address: 'Live In New York',
                        ),
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
