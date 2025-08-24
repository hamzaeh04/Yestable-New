import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/bar_chart.dart';
import 'package:yestable/widget/guest_update_received.dart';
import 'package:yestable/widget/showShareDialogBox_widget.dart';
import 'package:yestable/widget/you_are_invited_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/event_accesibility_widget.dart';
import '../../../widget/foodpreference_yesno_widget.dart';
import '../../../widget/home_screen_widget.dart';
import '../profile_setup_screens/host_profile_reviews.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final List<Map<String, String>> allergies = [
    {"name": "Peanuts", "imgPath": "assets/png/profile_food_images/peanut.png"},
    {"name": "Shellfish", "imgPath": "assets/png/profile_food_images/shellfish.png"},
    {"name": "Dairy", "imgPath": "assets/png/profile_food_images/food.png"},
    {"name": "Gluten", "imgPath": "assets/png/profile_food_images/gluten.png"},
    {"name": "Soy", "imgPath": "assets/png/profile_food_images/soy.png"},
  ];

  final List<Map<String, String>> diet = [
    {"name": "Vegan", "imgPath": "assets/png/profile_food_images/vegan.png"},
    {"name": " Vegetarian", "imgPath": "assets/png/profile_food_images/vegetarian.png"},
    {"name": "Kosher", "imgPath": "assets/png/profile_food_images/kosher.png"},
    {"name": "Halal", "imgPath": "assets/png/profile_food_images/halal.png"},
  ];

  final List<Map<String, String>> dislikedIngredient = [
    {"name": "Cilantro", "imgPath": "assets/png/profile_food_images/cilantro.png"},
    {"name": "Mushrooms", "imgPath": "assets/png/profile_food_images/mushroom.png"},
    {"name": "Spicy Foods", "imgPath": "assets/png/profile_food_images/spicyfood.png"},
  ];

  final List<Map<String, String>> likedCuisine = [
    {"name": "Italian", "imgPath": "assets/png/profile_food_images/pizza.png"},
    {"name": "Japanese", "imgPath": "assets/png/profile_food_images/japnese.png"},
    {"name": "Mediterranean", "imgPath": "assets/png/profile_food_images/mediterranean.png"},
  ];

  final List<String> eventAccesibilityList = [
    "Quiet Space",
    "Larger Seating",
    "Gluten-Free",
    "Wheelchair Accessible",
    "ASL Interpreter",
    "Vegan Option",
    "Halal",
    "Kosher",
    "Keto",
    "Accompanied By A Caregiver",
    "Family Restroom",
    "Childrens Area",
    "Smoke Present",
    "Pets Allowed",
    "Peanuts Free",
    "There Are Steps To Climb",
    "Accompanied By Service Animal",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Need A Chair Without Arms",
    "Event Ends At A Time",
  ];


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
            // Top Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            // hostReviewsBottomSheet(context);
                            AllergenBarChart();
                          },
                          child: customText(
                            text: "My Profile",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                            fontFamily: "CormorantGaramond",
                          ),
                        ),
                        customText(
                          text: "May 01, 2025",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  homeIconWidget(icon: Icons.logout,onTap: () {
                    Get.toNamed("getstarted");
                    controller.isUser.value = true;
                  }),
                  SizedBox(width: 2.w),
                  homeIconWidget(icon: Icons.notifications,onTap: () => controller.goToNotificationPage()),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Main Scrollable Area
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  color: backgroundColor,
                  child: DefaultTabController(
                    length: controller.isUser.value ? 2 : 3,
                    child: Column(
                      children: [
                        // Profile Info
                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder: (context,
                                innerBoxIsScrolled) =>
                            [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                21.sp),
                                            child: InkWell(
                                              onTap: (){
                                                guestUpdateReceived(context);
                                              },
                                              child: Container(
                                                height: 11.h,
                                                width: 11.h,
                                                color: Colors.grey.shade200,
                                                child: Image.asset(
                                                  "assets/png/girl_profile.png",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) =>
                                                      Icon(
                                                          Icons.person, size: 8.h,
                                                          color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: InkWell(
                                              onTap: (){
                                                AllergenBarChart();
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  customText(
                                                    text: "Sarah Scarnio",
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "CormorantGaramond",
                                                  ),
                                                  customText(
                                                    text: "256 Friends",
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: darkGreyColor,
                                                  ),
                                                  SizedBox(height: 0.8.h),
                                                  Row(

                                                    children: [
                                                      buttonWidget(
                                                        "Edit Profile",
                                                        whiteColor,
                                                        colors: greenColor
                                                            .withAlpha(140),
                                                        height: 3.5.h,
                                                        width: 27.w,
                                                        fontsize: 14.sp,
                                                        onTap: (){
                                                          Get.toNamed("profileeditscreen");
                                                        }
                                                      ),
                                                      SizedBox(width: 2.w),
                                                      buttonWidget(
                                                        "Share Profile",
                                                        whiteColor,
                                                        colors: blueColor
                                                            .withAlpha(140),
                                                        height: 3.5.h,
                                                        width: 27.w,
                                                        fontsize: 14.sp,
                                                        onTap: () {
                                                          showShareProfileDialog(context);
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      customText(
                                        text:
                                        "Lorem ipsum dolor sit amet consectetur. Viverra tellus\n"
                                            "eget magna sapien. Faucibus nibh mauris mattis aliquam\n"
                                            "proin pellentesque sed done Nu lla sed cons memagnat\n"
                                            "consectetur. Viv emauris rra tellus eget magna sapieneget\n"
                                            "Faucibusequat scelerisque.",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: darkGreyColor,
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/png/icons/map_location_icon.png",
                                            height: 2.h,
                                            width: 2.h,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error,
                                                stackTrace) =>
                                                Icon(Icons.location_on,
                                                    size: 2.h,
                                                    color: Colors.grey),
                                          ),
                                          SizedBox(width: 1.w),
                                          customText(
                                            text: "New York",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: blackColor,
                                            txtDecoration: TextDecoration
                                                .underline,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                    ),
                                  ),
                                  child: TabBar(
                                    indicatorColor: blackColor,
                                    labelColor: blackColor,
                                    unselectedLabelColor: Colors.grey,
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    tabs: controller.isUser.value
                                        ? [
                                      Tab(text: "Preference"),
                                      Tab(text: "Posts"),
                                    ]
                                        : [
                                      Tab(text: "Preference"),
                                      Tab(text: "Posts"),
                                      Tab(text: "Highlights"),
                                    ],
                                  ),

                                ),
                              ),
                            ],
                            body: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  padding: EdgeInsets.all(5.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      customText(
                                        text: "Dietary Priorities",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Allergies:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          allergies.length,
                                              (index) {
                                            return foodPreferencesOne(
                                              index+15,
                                              allergies[index]['name']!,
                                              imgpath: allergies[index]['imgPath'],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Diet:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          diet.length,
                                              (index) {
                                            return foodPreferencesOne(index + 24, diet[index]['name']!,imgpath: diet[index]['imgPath']);
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.5.h),
                                      customText(
                                        text: "Food Preferences",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Liked Cuisines:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          likedCuisine.length,
                                              (index) => foodPreferencesOne(index + 28, likedCuisine[index]['name']!,imgpath: likedCuisine[index]['imgPath']),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Disliked Ingredients",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          dislikedIngredient.length,
                                              (index) => foodPreferencesOne(index + 35, dislikedIngredient[index]["name"]!,imgpath: dislikedIngredient[index]["imgPath"]),
                                        ),
                                      ),
                                      controller.isUser.value ?
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2.h),
                                          customText(
                                            text: "Accessibility Needs",
                                            fontSize: 15.sp,
                                            color: blackColor,
                                          ),
                                          Wrap(
                                            spacing: 5,
                                            runSpacing: 1,
                                            children: List.generate(
                                              eventAccesibilityList.length,
                                                  (index) => eventAccesibillityWidget(
                                                eventAccesibilityList[index],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ):
                                      SizedBox.shrink(),

                                    ],
                                  ),
                                ),
                                Center(
                                    child: SingleChildScrollView(
                                      child: controller.isUser.value ? Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 1.h),
                                            child: buildPostCard(
                                              profileImage: "assets/png/chat_images/user5.png",
                                              userName: "Sarah Scarnio",
                                              postTime: "2hrs ago",
                                              postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                              postImage: "assets/png/chat_images/group_profile_pic.png",
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: buildPostCard(
                                              profileImage: 'assets/png/chat_images/user5.png',
                                              userName: 'Sarah Scarnio',
                                              postTime: '3h ago',
                                              postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                              likesCount: '1.4k Likes',
                                              showRepliesAndAvatar: false, // 👈 Only likes shown
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: buildPostCard(
                                              profileImage: 'assets/png/chat_images/user5.png',
                                              userName: 'Sarah Scarnio',
                                              postTime: '3h ago',
                                              postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                              likesCount: '1.4k Likes',
                                              showRepliesAndAvatar: false, // 👈 Only likes shown
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
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
                                      ):Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 1.h),
                                            child: buildPostCard(
                                              profileImage: "assets/png/chat_images/user5.png",
                                              userName: "Sarah Scarnio",
                                              postTime: "2hrs ago",
                                              postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                              postImage: "assets/png/chat_images/group_profile_pic.png",
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                ),
                                SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(right: index != 2 ? 2.w : 0.w),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                                              child: Image.asset(
                                                'assets/png/reveiw_images/reveiw${index + 1}.png',
                                                width: 28.w,
                                                height: 12.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(right: index != 2 ? 2.w : 0.w),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                                              child: Image.asset(
                                                'assets/png/reveiw_images/reveiw${index + 1}.png',
                                                width: 28.w,
                                                height: 12.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: List.generate(3, (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(right: index != 2 ? 2.w : 0.w),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                                              child: Image.asset(
                                                'assets/png/reveiw_images/reveiw${index + 1}.png',
                                                width: 28.w,
                                                height: 12.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
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
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.sp),
    ),
    child: Column(
      children: [
        // Post Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            GestureDetector(
              onTap: (){
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.5.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      clipBehavior: Clip.antiAlias, // Optional: this clips the image only
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
                          border: Border.all(color: Colors.white, width: 1), // Optional border
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
              ),
            ),
            SizedBox(width: 2.w),

            // Username, Time, Text, Image, Footer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: userName,
                        fontSize: userNameFontSize != null ? userNameFontSize : 16.sp,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                        fontFamily: "CormorantGaramond",
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 20.sp,
                        color: blackColor,
                      ),
                    ],
                  ),
                  customText(
                    text: postTime,
                    fontSize: postTimeFontSize != null ? postTimeFontSize : 14.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                  ),
                  SizedBox(height: 0.5.h),

                  // Post Text
                  customText(
                    text: postText,
                    fontSize: postTextFontSize!= null ? postTextFontSize : 14.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                    maxLines: showReadMore ? 4 : null,
                  ),
                  SizedBox(height: 0.5.h),

                  // Post Image
                  if (postImage != null && postImage.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Image.asset(
                        postImage,
                        width: double.infinity,
                        height: 20.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                  SizedBox(height: 0.5.h),

                  // Footer Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Replies + Likes
                      Row(
                        children: [
                          if (showRepliesAndAvatar) ...[
                            CircleAvatar(
                              radius: 14.sp,
                              backgroundImage:
                              AssetImage('assets/png/chat_images/user5.png'),
                            ),
                            SizedBox(width: 2.w),
                            customText(
                              text: repliesCount,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: darkGreyColor,
                              txtDecoration: TextDecoration.underline,
                            ),
                            SizedBox(width: 4.w),
                          ],
                          // Likes (always shown)
                          customText(
                            text: likesCount,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: darkGreyColor,
                          ),
                        ],
                      ),

                      // Action Icons
                      Row(
                        children: [
                          Icon(Icons.favorite_border,size: 18.sp,),
                          SizedBox(width: 2.5.w),
                          Image.asset("assets/png/icons/comment_icon.png", height: 16.sp),
                          SizedBox(width: 3.w),
                          Image.asset("assets/png/icons/repost_icon.png", height: 16.sp),
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (postImage != null && postImage.isNotEmpty) SizedBox(height: 1.5.h),
      ],
    ),
  );
}
