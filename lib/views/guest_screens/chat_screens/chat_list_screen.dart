import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/chat_list_widget.dart';
import '../../../widget/home_screen_widget.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final prefs = SharedPreferencesMethod.storage;

  @override
  Widget build(BuildContext context) {
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
                        text: "Hi, ${prefs.getString(LocalDBKeys.USERFULLNAME) ?? ""}!",
                        fontSize: 20.sp,
                        fontFamily: "CormorantGaramond",
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                        height: 0.1.h,
                      ),
                      customText(
                        text: controller.formatDate2(DateTime.now()) ?? "May 01, 2025",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: (){
                        controller.addtoFriendScreen();
                      },
                      child: homeIconWidget(imagePath: "assets/png/icons/search_icon.png", )
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                      onTap: (){
                        controller.goToNotificationPage();
                      },
                      child: homeIconWidget(icon: Icons.notifications)),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// 👇 This is the scrollable bottom half with rounded corners
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h),
                            // Search bar on top
                            TextField(
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
                            SizedBox(height: 1.5.h),

                            // Expanded ListView for chat messages

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: chatListWidget(
                          "assets/png/chat_images/chat_list_msg_one.png",
                          "Gizelle Dinner Event",
                          "Sophia: Thank You For Your Suggestions",
                          "2hrs Ago",
                          true, // just alternate unseen for example
                          4,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: chatListWidget(
                          "assets/png/chat_images/chat_list_msg_one.png",
                          "Sophia Dinner Event",
                          "Sophia: Thank You For Your Suggestions",
                          "2hrs Ago",
                          false, // just alternate unseen for example
                          4,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: chatListWidget(
                          "assets/png/chat_images/chat_list_msg_one.png",
                          "Sophia Dinner Event",
                          "Sophia: Thank You For Your Suggestions",
                          "2hrs Ago",
                          false, // just alternate unseen for example
                          4,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: chatListWidget(
                          "assets/png/chat_images/chat_list_msg_one.png",
                          "Sophia Dinner Event",
                          "Sophia: Thank You For Your Suggestions",
                          "2hrs Ago",
                          false, // just alternate unseen for example
                          4,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: chatListWidget(
                          "assets/png/chat_images/chat_list_msg_one.png",
                          "Sophia Dinner Event",
                          "Sophia: Thank You For Your Suggestions",
                          "2hrs Ago",
                          false, // just alternate unseen for example
                          4,
                        ),
                      ),
                      Divider(),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: blueColor,
      //     foregroundColor: whiteColor,
      //     shape: const CircleBorder(),
      //     onPressed: () {
      //     Get.toNamed("newmessagescreen");
      //     },
      //     child: Icon(Icons.add,size: 20.sp,color: whiteColor,)
      // ),
    );
  }
}
