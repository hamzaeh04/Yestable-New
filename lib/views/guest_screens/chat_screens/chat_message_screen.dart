import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/home_screen_widget.dart';

class ChatMessageScreen extends StatelessWidget {
  const ChatMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      resizeToAvoidBottomInset: true, // Important for keyboard handling
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
                    onTap: (){
                      Get.toNamed("chatgroupsetting");

                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/png/chat_images/chat_msg_image.png",
                          height: 6.h,
                          width: 15.w,
                        ),
                        SizedBox(width: 2.w),
                        customText(
                          text: "Gizelle Dinner Event",
                          fontSize: 20.sp,
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
                      // Messages scroll area with bottom padding for input bar
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 4.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                          decoration: BoxDecoration(
                                            color: blueColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: customText(
                                            text:
                                            "The dessert menu shows tiramisu\n(has dairy). Could we add a nut-free\nsorbet? I’ll bring some if it’s easier!",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 1.w),
                                          child: customText(
                                            text: "08:15 AM",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/png/chat_images/chat_profile_img.png",
                                      height: 6.h,
                                      width: 12.w,
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                            text: "Gizelle Jekronia ( Host )",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                            decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: customText(
                                              text:
                                              "Vote for the main:\n(A) Lemon-herb chicken\n(B) Eggplant parm\nReact with 🍗 or 🍆!",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Container(
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(30.sp),
                                                    ),
                                                  ),
                                                  child: customText(
                                                    text: "🍗 10",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 0.5.w),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(20.sp),
                                                    ),
                                                  ),
                                                  child: customText(
                                                    text: "🍆 3",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 18.w),
                                                customText(
                                                  text: "08:15 AM",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Image.asset("assets/png/chat_images/msg_typing_img.png",height: 12.h,width: 24.w,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
