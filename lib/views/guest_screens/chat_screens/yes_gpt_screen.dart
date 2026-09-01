import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/yes_gpt_controller.dart';
import 'package:yestable/widget/floating_home_button.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/home_screen_widget.dart';

class YesGptScreen extends StatelessWidget {
  YesGptScreen({super.key});
  final YesGptController controller = Get.find<YesGptController>();

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
                  SizedBox(width: 20.w),
                  Row(
                    children: [
                      Image.asset("assets/png/chat_images/yesGPT.png",width: 10.w),
                      SizedBox(width: 2.w),
                      customText(
                        text:
                        "Yes GPT",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "CormorantGaramond"
                      ),

                    ],
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
                                padding: EdgeInsets.symmetric(vertical: controller.isMsgSend.value == false ? 4.h: 2.h),
                                child: Obx(() {
                                  if (!controller.isMsgSend.value) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customText(
                                          text: "What Can I Help with hosting?",
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "CormorantGaramond",
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/png/chat_images/chat_profile_img.png",
                                            height: 5.h,
                                            width: 10.w,
                                          ),
                                          SizedBox(width: 3.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                customText(
                                                  text: "Sarah Scarnio",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(height: 0.5.h),
                                                Container(
                                                  width: 60.w,
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Obx(() =>
                                                    customText(
                                                      text: controller.hostMsg.value,
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: yesGptMsgTextColor
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 0.5.h),
                                                Container(
                                                  width: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 45.w),
                                                      customText(
                                                        text: "08:15 AM",
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "WorkSans",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 2.h),
                                              Obx(() =>
                                              controller.showFirst.value ?
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 70.w, // 👈 ensure wrapping
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                                  decoration: BoxDecoration(
                                                    color: blueColor,
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: AnimatedTextKit(
                                                    animatedTexts: [
                                                      TypewriterAnimatedText(
                                                        controller.aiResponseOne.value,
                                                        textAlign: TextAlign.start, // 👈 paragraph style
                                                        textStyle: TextStyle(
                                                          fontSize: 15.sp,         // ✅ no const here
                                                          fontWeight: FontWeight.w400,
                                                          color: whiteColor,
                                                          fontFamily: "WorkSans", // 👈 optional
                                                        ),
                                                        speed: Duration(milliseconds: 40), // ✅ realistic typing
                                                      ),
                                                    ],
                                                    totalRepeatCount: 1, // 👈 show only once
                                                    pause: Duration(milliseconds: 100),
                                                    displayFullTextOnTap: true,
                                                    stopPauseOnTap: true,
                                                    onFinished: (){
                                                      controller.showSecond.value = true;
                                                    },
                                                  ),
                                                ):
                                                  SizedBox.shrink(),
                                              ),
                                              SizedBox(height: 0.5.h),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 1.w),
                                                          child: customText(
                                                            text: "08:15 AM",
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "WorkSans",
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 2.h),
                                                        Obx(() =>
                                                        controller.showSecond.value ?
                                                        Container(
                                                          constraints: BoxConstraints(
                                                            maxWidth: 70.w, // 👈 ensure wrapping
                                                          ),
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                                          decoration: BoxDecoration(
                                                            color: blueColor,
                                                            borderRadius: const BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: AnimatedTextKit(
                                                            animatedTexts: [
                                                              TypewriterAnimatedText(
                                                                controller.aiResponseTwo.value,
                                                                textAlign: TextAlign.start, // 👈 paragraph style
                                                                textStyle: TextStyle(
                                                                  fontSize: 15.sp,         // ✅ no const here
                                                                  fontWeight: FontWeight.w400,
                                                                  color: whiteColor,
                                                                  fontFamily: "WorkSans", // 👈 optional
                                                                ),
                                                                speed: Duration(milliseconds: 40), // ✅ realistic typing
                                                              ),
                                                            ],
                                                            totalRepeatCount: 1, // 👈 show only once
                                                            pause: Duration(milliseconds: 100),
                                                            displayFullTextOnTap: true,
                                                            stopPauseOnTap: true,
                                                            onFinished: (){
                                                              controller.showSecond.value = true;
                                                            },
                                                          ),
                                                        ):
                                                        SizedBox.shrink(),
                                                        ),
                                                        SizedBox(height: 0.5.h),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 1.w),
                                                          child: customText(
                                                            text: "08:15 AM",
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "WorkSans",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(() =>
                        controller.isMsgSend.value == false ?
                        Positioned(
                          bottom: 12.h,
                          left: 5.w,
                          right: 0,
                          child: Wrap(// 👈 vertical center if multi-line
                            spacing: 6,
                            runSpacing: 6,
                            children: controller.yesGptOptions.map(yesGptSuggestions).toList(),
                          ),
                        ): Positioned(
                          bottom: 11.5.h,
                          left: 27.w,
                          child: Container(
                            width: 45.w, // 👈 Fixed width
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(25.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: floatingActionTextColor, size: 20.sp),
                                SizedBox(width: 2.w),
                                Flexible( // 👈 ensures text shrink kare if needed
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: customText(
                                      text: "Add to menu",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "CormorantGaramond",
                                      color: floatingActionTextColor
                                    ),
                                  ),
                                ),
                              ],
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
                                      controller: controller.msgController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 1.h).copyWith(left: 1.w),
                                        hintText: "Ask anything",
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
                                InkWell(
                                  onTap: (){
                                    controller.toggleMsgSend();
                                    controller.msgController.clear();
                                    print(controller.isMsgSend);
                                  },
                                  child: Image.asset(
                                    "assets/png/icons/send_message_icon.png",
                                    height: 6.h,
                                    width: 6.w,
                                  ),
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
Widget yesGptSuggestions(String title){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.sp),
      color: backgroundColor,
      border: Border.all(
        color: yesGptBorderColor,
        width: 0.2.w
      )
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.7.h),
      child: customText(
        text: title,
        fontWeight: FontWeight.w600,
        fontFamily: "WorkSans",
        fontSize: 14.sp,
      ),
    ),
  );
}
