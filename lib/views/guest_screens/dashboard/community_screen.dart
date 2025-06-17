import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/new_post_bottomsheet.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/home_screen_widget.dart';
import 'my_profile_screen.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
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
                    text: "Community Profile",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: "Explore Community",
                                  fontSize: 19.sp,
                                  fontFamily: "CormorantGaramond",
                                  fontWeight: FontWeight.w600,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    controller.addtoCommunityProfile();
                                  },
                                  child: buildPostCard(
                                    profileImage: "assets/png/chat_images/user5.png",
                                    userName: "Sarah Scarnio",
                                    postTime: "2hrs ago",
                                    postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                    postImage: "assets/png/chat_images/group_profile_pic.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    controller.addtoCommunityProfile();
                                  },
                                  child: buildPostCard(
                                    profileImage: 'assets/png/chat_images/user5.png',
                                    userName: 'Sarah Scarnio',
                                    postTime: '3h ago',
                                    postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                    likesCount: '1.4k Likes',
                                    showRepliesAndAvatar: false, // 👈 Only likes shown
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: (){
                                controller.addtoCommunityProfile();
                              },
                              child: buildPostCard(
                                profileImage: 'assets/png/chat_images/user5.png',
                                userName: 'Sarah Scarnio',
                                postTime: '3h ago',
                                postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                likesCount: '1.4k Likes',
                                showRepliesAndAvatar: false, // 👈 Only likes shown
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        foregroundColor: whiteColor,
        shape: const CircleBorder(),
        onPressed: () {
          showNewPostBottomSheet(context);
        },
        child: Icon(Icons.add,size: 20.sp,color: whiteColor,)
      ),
    );
    
  }
}
