import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/home_screen_widget.dart';

class GuestListScreen extends StatelessWidget {
  GuestListScreen({super.key});

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
                      Get.back();
                    },
                  ),
                  SizedBox(width: 2.w),
                  customText(
                    text: "Guest List",
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
                    padding: EdgeInsets.symmetric(vertical: 3.h),
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
                        SizedBox(height: 0.7.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 0.7.h),
                          child: Row(
                            children: [
                              Image.asset("assets/png/icons/group_list_icon.png",height: 18.sp,),
                              SizedBox(width: 3.w),
                              customText(
                                text: "Create A group List (Eg: family, Friends)",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 0.7.h),
                          child: Row(
                            children: [
                              Image.asset("assets/png/icons/invite_icon.png",height: 18.sp,),
                              SizedBox(width: 3.w),
                              customText(
                                text: "Invite People",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 2.h),
                        InkWell(
                          onTap: (){
                            Get.toNamed("eventcomfortone");
                          },
                          child: addFriendWidget(
                              index: 0,
                              url: "assets/png/chat_images/guest4.png",
                              msgtitle: "Samuel Kendrio",
                              msgText: "20+ Mutual Friends",
                              place: "Live In New York",
                              controller: controller
                          ),
                        ),

                        SizedBox(height: 1.h),
                        addFriendWidget(
                            index: 1,
                            url: "assets/png/chat_images/guest2.png",
                            msgtitle: "Family ❤️",
                            msgText: "23 Members",
                            controller: controller
                        ),

                        SizedBox(height: 1.h),
                        addFriendWidget(
                            index: 2,
                            url: "assets/png/chat_images/guest3.png",
                            msgtitle: "Samuel Kenleo",
                            msgText: "20+ Mutual Friends",
                            place: "Live In New York",
                            controller: controller
                        ),

                        SizedBox(height: 1.h),
                        addFriendWidget(
                            index: 3,
                            url: "assets/png/chat_images/guest1.png",
                            msgtitle: "Samuel Kendrale",
                            msgText: "20+ Mutual Friends",
                            place: "Live In New York",
                            controller: controller
                        ),


                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: buttonWidget(
                            "Continue",
                            whiteColor,
                            colors: greenColor,
                            onTap: () {
                              Get.toNamed("foodmenuscreen");
                            },
                          ),
                        ),
                        SizedBox(height: 3.h),
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
    required int index,
    required String url,
    String? msgtitle,
    String? msgText,
    String? place,
    NavigationController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(url, width: 18.w, height: 18.w, fit: BoxFit.cover),
          SizedBox(width: 3.w),
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

                          /// Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                text: msgtitle ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: "CormorantGaramond",
                              ),
                            ],
                          ),

                          /// Conditionally Show Place
                          if (place != null && place.isNotEmpty)
                            customText(
                              text: place,
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
                          if (place == null || place.isEmpty)
                            SizedBox(height: 1.8.h),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),

                /// Obx Button With Toggle State
                Positioned(
                  top: 18.sp,
                  right: 10.w,
                  child: Obx(() {
                    bool isAdded = controller!.isAdded(index);
                    return buttonWidget(
                      isAdded ? "Added" : "Add",
                      isAdded ? greenColor : backgroundColor,
                      colors: isAdded ? backgroundColor : greenColor,
                      fontsize: 14.sp,
                      height: 4.h,
                      width: 20.w,
                      icon: isAdded ? Icons.check : null,
                      onTap: () => controller.toggleAdd(index),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
