import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/floating_home_button.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/home_screen_widget.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      screen: Scaffold(
      backgroundColor: greenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
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
                    text: "Search",
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
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
                    Obx(
                          () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.4.h,
                        ),
                        child: Row(
                          children: List.generate(controller.searchScreenTabs.length, (index) {
                            bool isSelected = controller.selectedIndexTab.value == index;
                            bool isLastIndex = index == controller.searchScreenTabs.length - 1;

                            return Padding(
                              padding: EdgeInsets.only(right: 2.w),
                              child: GestureDetector(
                                onTap: () => controller.selectTabSearch(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 0.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? greenColor
                                        : greenColor.withAlpha(40),
                                    borderRadius: BorderRadius.circular(30.sp),
                                  ),
                                  child: Row(
                                    children: [
                                      if (isLastIndex) ...[
                                        Image.asset(
                                          'assets/png/icons/filter_icon.png',
                                          height: 16.sp,
                                          width: 16.sp,
                                          color: isSelected ? whiteColor : greenColor,
                                        ),
                                        SizedBox(width: 2.w),
                                      ],
                                      customText(
                                        text: controller.searchScreenTabs[index],
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? whiteColor : greenColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.25.h,),
                    Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                      text: "Recipes to suit your taste",
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                      fontFamily: "CormorantGaramond",
                                    ),
                                    customText(
                                      text: "View All",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: blueColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Row(
                                    children: List.generate(4, (index) {
                                      return buildPostCard(
                                        profileImage: "assets/png/chat_images/user5.png",
                                        userName: "Sarah Scarnio",
                                        postTime: "2hrs ago",
                                        postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                        postImage: "assets/png/chat_images/group_profile_pic.png",
                                        color: whiteColor,
                                        userNameFontSize: 15.sp,
                                        postTextFontSize: 12.5.sp,
                                        postTimeFontSize: 12.5.sp,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText(
                                      text: "Your Events",
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                      fontFamily: "CormorantGaramond",
                                    ),
                                    customText(
                                      text: "View All",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: blueColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: 38.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 3.w),
                                      child: yourEventWidget(width: 55.w),
                                    );
                                  },
                                ),
                              ),
                            ],
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
    ),
    );
  }
}


Widget buildPostCard({
  required String profileImage,
  required String userName,
  required String postTime,
  required String postText,
  double? userNameFontSize,
  double? postTimeFontSize,
  double? postTextFontSize,
  Color? color,
  String? postImage, // Optional image
  String repliesCount = "8 replies",
  String likesCount = "12k Likes",
  bool showReadMore = true,
  bool showRepliesAndAvatar = true,
}) {
  bool isExpanded = false;
  bool isLiked = false; // logic for heart state

  return Padding(
    padding: EdgeInsets.only(right: 2.w),
    child: Container(
      width: 65.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          children: [
            // Post Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 3.5.h,
                      width: 3.5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: 4.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -0.5.h,
                      right: -0.5.h,
                      child: Container(
                        height: 1.8.h,
                        width: 1.8.h,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 1.2.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 2.w),

                // Username, Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: userName,
                            fontSize: userNameFontSize ?? 16.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                            fontFamily: "CormorantGaramond",
                          ),
                          // WORKING 3-DOT DROPDOWN
                          StatefulBuilder(
                            builder: (localContext, setMenuState) {
                              return GestureDetector(
                                onTapDown: (details) {
                                  showMenu(
                                    context: localContext,
                                    color: Colors.white, // Background color
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
                                    position: RelativeRect.fromLTRB(
                                      details.globalPosition.dx,
                                      details.globalPosition.dy,
                                      details.globalPosition.dx,
                                      details.globalPosition.dy,
                                    ),
                                    items: [
                                      const PopupMenuItem(value: 'edit', child: Text("Edit")),
                                      const PopupMenuItem(value: 'delete', child: Text("Delete", style: TextStyle(color: Colors.red))),
                                    ],
                                  );
                                },
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 16.sp,
                                  color: blackColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      customText(
                        text: postTime,
                        fontSize: postTimeFontSize ?? 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h),

            // Post Text with Read More
            StatefulBuilder(
              builder: (context, setState) {
                final int maxChars = 200;
                final bool needTruncate = postText.length > maxChars;
                String displayText;

                if (isExpanded || !needTruncate) {
                  displayText = postText;
                } else {
                  displayText = postText.substring(0, maxChars) + "...";
                }

                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: displayText,
                        style: TextStyle(
                          fontSize: postTextFontSize ?? 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                          fontFamily: "WorkSans",
                        ),
                      ),
                      if (!isExpanded && needTruncate)
                        TextSpan(
                          text: ' Read more',
                          style: TextStyle(
                            fontSize: postTextFontSize ?? 14.sp,
                            fontWeight: FontWeight.w400,
                            color: blueColor,
                            fontFamily: "WorkSans",
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isExpanded = true;
                              });
                            },
                        ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 0.5.h),

            // Post Image
            if (postImage != null && postImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15.sp),
                child: Image.asset(
                  postImage,
                  width: double.infinity,
                  height: 15.h,
                  fit: BoxFit.cover,
                ),
              ),

            SizedBox(height: 0.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Replies + Likes
                Row(
                  children: [
                    if (showRepliesAndAvatar) ...[
                      CircleAvatar(
                        radius: 12.sp,
                        backgroundImage:
                        AssetImage('assets/png/chat_images/user5.png'),
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: repliesCount,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: darkGreyColor,
                        txtDecoration: TextDecoration.underline,
                      ),
                      SizedBox(width: 4.w),
                    ],
                    customText(
                      text: likesCount,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                      txtDecoration: TextDecoration.underline,
                    ),
                  ],
                ),

                // Action Icons
                Row(
                  children: [
                    // WORKING LIKE HEART
                    StatefulBuilder(
                      builder: (context, setLikeState) {
                        return GestureDetector(
                          onTap: () {
                            setLikeState(() {
                              isLiked = !isLiked;
                            });
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            size: 18.sp,
                            color: isLiked ? Colors.red : blackColor,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 2.5.w),
                    Image.asset("assets/png/icons/comment_icon.png", height: 16.sp),
                    SizedBox(width: 3.w),
                    Image.asset("assets/png/icons/repost_icon.png", height: 16.sp),
                  ],
                ),
              ],
            ),
            if (postImage != null && postImage.isNotEmpty)
              SizedBox(height: 1.5.h),
          ],
        ),
      ),
    ),
  );
}

Widget yourEventWidget({double? width,double? height}) {
  return Container(
    height: height!=null ? height : 41.h,
    width: width!=null ? width : 65.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.sp),
      color: whiteColor.withOpacity(0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
            bottomLeft: Radius.circular(18.sp), // More rounded bottom
            bottomRight: Radius.circular(18.sp), // More rounded bottom
          ),
          child: Container(
            width: double.infinity,
            height: 14.h,
            child: Image.asset(
              "assets/png/upcoming_event_banner.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: "Sophia Dinner Event",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
                color: blackColor,
              ),
              customText(
                text: "132 My Street, Kingston, New York124",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
              Divider(),
              buildEventRow("Name:", "April 30, 2025",textSize: 12.sp),
              Divider(),
              buildEventRow("Time:", "7:30pm",textSize: 12.sp),
              Divider(),
              buildEventRow("Host Name:", "Sophia Andreas",textSize: 12.sp),
              Divider(),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Dietary Compatibility Score",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                  customText(
                    text: "95%",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: greenColor,
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: LinearProgressIndicator(
                  minHeight: 0.7.h,
                  value: 0.95,
                  valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

