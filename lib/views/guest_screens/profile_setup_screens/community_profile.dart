import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/floating_home_button.dart';
import 'package:yestable/widget/showShareDialogBox_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/event_accesibility_widget.dart';
import '../../../widget/foodpreference_yesno_widget.dart';
import '../../../widget/home_screen_widget.dart';
import '../dashboard/my_profile_screen.dart';
import '../profile_setup_screens/host_profile_reviews.dart';

class CommunityProfile extends StatelessWidget {
  CommunityProfile({super.key});

  final NavigationController controller = Get.find<NavigationController>();
  final List<Map<String, String>> allergies = [
    {"name": "Peanuts", "imgPath": "assets/png/profile_food_images/peanut.png"},
    {
      "name": "Shellfish",
      "imgPath": "assets/png/profile_food_images/shellfish.png",
    },
    {"name": "Dairy", "imgPath": "assets/png/profile_food_images/food.png"},
    {"name": "Gluten", "imgPath": "assets/png/profile_food_images/gluten.png"},
    {"name": "Soy", "imgPath": "assets/png/profile_food_images/soy.png"},
  ];

  final List<Map<String, String>> diet = [
    {"name": "Vegan", "imgPath": "assets/png/profile_food_images/vegan.png"},
    {
      "name": "Vegetarian",
      "imgPath": "assets/png/profile_food_images/vegetarian.png",
    },
    {"name": "Kosher", "imgPath": "assets/png/profile_food_images/kosher.png"},
    {"name": "Halal", "imgPath": "assets/png/profile_food_images/halal.png"},
  ];

  final List<Map<String, String>> dislikedIngredient = [
    {
      "name": "Cilantro",
      "imgPath": "assets/png/profile_food_images/cilantro.png",
    },
    {
      "name": "Mushrooms",
      "imgPath": "assets/png/profile_food_images/mushroom.png",
    },
    {
      "name": "Spicy Foods",
      "imgPath": "assets/png/profile_food_images/spicyfood.png",
    },
    {"name": "Halal", "imgPath": "assets/png/profile_food_images/halal.png"},
  ];

  final List<Map<String, String>> likedCuisine = [
    {"name": "Italian", "imgPath": "assets/png/profile_food_images/pizza.png"},
    {
      "name": "Japanese",
      "imgPath": "assets/png/profile_food_images/japnese.png",
    },
    {
      "name": "Mediterranean",
      "imgPath": "assets/png/profile_food_images/mediterranean.png",
    },
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
    "Family Restroom",
    "Pets Allowed",
    "Childrens Area",
    "Smoke Present",
    "There Are Steps To Climb",
    "Non Swimming Event",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Peanuts Free",
    "Event Ends At A Time",
  ];

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      isProfileSetup: true,
      screen: Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      homeIconWidget(
                        icon: Icons.arrow_back_ios_new,
                        color: lightgreenColor,
                        iconsize: 16.sp,
                        onTap: () {
                          controller.changePage(2);
                          // Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: "Community Profile",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                        fontFamily: "CormorantGaramond",
                      ),
                    ],
                  ),
                  homeIconWidget(
                    icon: Icons.notifications,
                    onTap: () => controller.goToNotificationPage(),
                  ),
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
                    length: 2,
                    child: Column(
                      children: [
                        // Profile Info
                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder:
                                (context, innerBoxIsScrolled) => [
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      21.sp,
                                                    ),
                                                child: Container(
                                                  height: 11.h,
                                                  width: 11.h,
                                                  color: Colors.grey.shade200,
                                                  child: Image.asset(
                                                    "assets/png/girl_profile.png",
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Icon(
                                                          Icons.person,
                                                          size: 8.h,
                                                          color: Colors.grey,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    customText(
                                                      text: "Sarah Scarnio",
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          "CormorantGaramond",
                                                    ),
                                                    // customText(
                                                    //   text: "256 Friends",
                                                    //   fontSize: 14.sp,
                                                    //   fontWeight: FontWeight.w400,
                                                    //   color: darkGreyColor,
                                                    // ),
                                                    SizedBox(height: 0.8.h),
                                                    Row(
                                                      children: [
                                                        buttonWidget(
                                                          "Add Friend",
                                                          whiteColor,
                                                          colors: greenColor
                                                              .withAlpha(140),
                                                          height: 3.5.h,
                                                          width: 27.w,
                                                          fontsize: 14.sp,
                                                          onTap: () {},
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
                                                            showShareProfileDialog(
                                                              context,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2.h),
                                          customText(
                                            text:
                                                "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nu lla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
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
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.location_on,
                                                      size: 2.h,
                                                      color: Colors.grey,
                                                    ),
                                              ),
                                              SizedBox(width: 1.w),
                                              customText(
                                                text: "New York",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: blackColor,
                                                txtDecoration:
                                                    TextDecoration.underline,
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
                                            width: 1.0,
                                          ),
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
                                        tabs: const [
                                          Tab(text: "Preference"),
                                          Tab(text: "Posts"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "Dietary Priorities",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                        fontFamily: 'CormorantGaramond'
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Allergies:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 2.0,
                                        children: List.generate(
                                          allergies.length,
                                          (index) {
                                            return foodPreferencesOne(
                                              index + 15,
                                              allergies[index]['name']!,
                                              imgpath:
                                                  allergies[index]['imgPath'],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.2.h),
                                      customText(
                                        text: "Diet:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),

                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 2.0,
                                        children: List.generate(diet.length, (
                                          index,
                                        ) {
                                          return foodPreferencesOne(
                                            index + 24,
                                            diet[index]['name']!,
                                            imgpath: diet[index]['imgPath'],
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 1.5.h),
                                      customText(
                                        text: "Food Preferences",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                        fontFamily: 'CormorantGaramond'
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Liked Cuisines:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 2.0,
                                        children: List.generate(
                                          likedCuisine.length,
                                          (index) => foodPreferencesOne(
                                            index + 28,
                                            likedCuisine[index]['name']!,
                                            imgpath:
                                                likedCuisine[index]['imgPath'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.2.h),
                                      customText(
                                        text: "Disliked Ingredients",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 1,
                                        children: List.generate(
                                          dislikedIngredient.length,
                                          (index) => foodPreferencesOne(
                                            index + 35,
                                            dislikedIngredient[index]["name"]!,
                                            imgpath:
                                                dislikedIngredient[index]["imgPath"],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 2.h),
                                      customText(
                                          text: "Dietary Priorities",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                          fontFamily: 'CormorantGaramond'
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                          text: "Allergies:",
                                          fontSize: 14.sp,
                                          color: blackColor,
                                          fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 2.0,
                                        children: List.generate(
                                          allergies.length,
                                              (index) {
                                            return foodPreferencesOne(
                                              index + 15,
                                              allergies[index]['name']!,
                                              imgpath:
                                              allergies[index]['imgPath'],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 1.2.h),
                                      customText(
                                          text: "Diet:",
                                          fontSize: 14.sp,
                                          color: blackColor,
                                          fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(height: 0.7.h,),

                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 2.0,
                                        children: List.generate(diet.length, (
                                            index,
                                            ) {
                                          return foodPreferencesOne(
                                            index + 24,
                                            diet[index]['name']!,
                                            imgpath: diet[index]['imgPath'],
                                          );
                                        }),
                                      ),
                                      //SizedBox(height: 1.5.h),
                                      SizedBox(height: 2.h),
                                      customText(
                                          text: "Yuck Or Yum?",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                          fontFamily: 'CormorantGaramond'
                                      ),
                                      SizedBox(height: 0.7.h),
                                      Column(
                                        spacing: 2.h,
                                        children: [
                                          yuckOrYumList(title: '🥜 Peanuts', color: greenColor, isSelected: true),
                                          yuckOrYumList(title: '🦐 Shellfish', color: redColor, isSelected: false),
                                          yuckOrYumList(title: '🥛 Dairy', color: redColor, isSelected: false),
                                          yuckOrYumList(title: '🌾 Gluten', color: greenColor, isSelected: true),
                                          yuckOrYumList(title: '🥚 Eggs', color: redColor, isSelected: false),
                                          yuckOrYumList(title: '🫛 Soy', color: redColor, isSelected: false),
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      customText(
                                        text: "Accessibility Needs",
                                        fontSize: 15.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w600
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
                                  ),
                                ),
                                Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: buildPostCard(
                                            profileImage:
                                                "assets/png/chat_images/user5.png",
                                            userName: "Sarah Scarnio",
                                            postTime: "2hrs ago",
                                            postText:
                                                "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                            postImage:
                                                "assets/png/chat_images/group_profile_pic.png",
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: buildPostCard(
                                            profileImage:
                                                'assets/png/chat_images/user5.png',
                                            userName: 'Sarah Scarnio',
                                            postTime: '3h ago',
                                            postText:
                                                "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                            likesCount: '1.4k Likes',
                                            showRepliesAndAvatar:
                                                false, // 👈 Only likes shown
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: buildPostCard(
                                            profileImage:
                                                'assets/png/chat_images/user5.png',
                                            userName: 'Sarah Scarnio',
                                            postTime: '3h ago',
                                            postText:
                                                "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                            likesCount: '1.4k Likes',
                                            showRepliesAndAvatar:
                                                false, // 👈 Only likes shown
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: buildPostCard(
                                            profileImage:
                                                'assets/png/chat_images/user5.png',
                                            userName: 'Sarah Scarnio',
                                            postTime: '3h ago',
                                            postText:
                                                "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                            likesCount: '1.4k Likes',
                                            showRepliesAndAvatar:
                                                false, // 👈 Only likes shown
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    ),
    );
  }
}
Widget _buildYuckYumButton({
  required String label,
  required bool isSelected,
  required Color color,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 3.2.h,
      width: 24.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: isSelected ? color : backgroundColor,
        border: Border.all(
          color: isSelected ? color : greyBorderColor,
        ),
      ),
      child: Center(
        child: customText(
          text: label,
          fontSize: 14.sp,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}

Widget yuckOrYumList({
  required String title,
  required Color color,
  required bool isSelected, // true = Yum, false = Yuck
  VoidCallback? onYumTap,
  VoidCallback? onYuckTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          text: title,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.5.sp
        ),
        SizedBox(height: 0.6.h),
        Row(
          children: [
            // ✅ Yum button
            _buildYuckYumButton(
              label: '😋 Yum',
              isSelected: isSelected,      // true → green
              color: color,
              onTap: onYumTap,
            ),
            SizedBox(width: 2.w),

            // ✅ Yuck button
            _buildYuckYumButton(
              label: '😝 Yuck',
              isSelected: !isSelected,     // false → green
              color: color,
              onTap: onYuckTap,
            ),
          ],
        ),
      ],
    ),
  );
}

