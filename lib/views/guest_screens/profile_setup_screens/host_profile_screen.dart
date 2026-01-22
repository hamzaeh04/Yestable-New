import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/showShareDialogBox_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/foodpreference_yesno_widget.dart';
import '../../../widget/home_screen_widget.dart';
import '../dashboard/my_profile_screen.dart';
import 'community_profile.dart';

class HostProfileScreen extends StatelessWidget {
  HostProfileScreen({super.key});
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
    {"name": "Vegetarian", "imgPath": "assets/png/profile_food_images/vegetarian.png"},
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
    "Quiet Space", "Larger Seating", "Wheelchair Accessible",
    "ASL Interpreter",
    "Family Restroom", "Pets Allowed", "Childrens Area", "Smoke Present",
    "There Are Steps To Climb", "Non Swimming Event", "Firearms Are Present",
    "Event Ends At A Time"
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
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    color: lightgreenColor,
                    iconsize: 16.sp,
                    onTap: () {
                      if(controller.isUser.value == true){
                        Get.back();
                      }
                      else{
                        controller.goToHome();
                      }

                    },
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: customText(
                      text: "Host Profile",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                      fontFamily: "CormorantGaramond",
                    ),
                  ),
                  controller.isUser.value == false
                      ? homeIconWidget(
                    icon: Icons.logout,
                    onTap: () {
                      // 1. Pehle lock lagao taake HomeScreen ka dialog trigger na ho
                      controller.hasCheckedProfile.value = true;

                      // 2. Index reset karo
                      controller.currentIndex.value = 0;

                      // 3. Status change karo
                      controller.isUser.value = true;

                      // 4. IMPORTANT: offAllNamed use karo taake pichli saari screens khatam ho jayein
                      // Isse black screen ya background rebuild wala masla nahi aayega
                      Get.offAllNamed("getstarted");
                    },
                  )
                      : const SizedBox.shrink(),
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
                    length: 3,
                    child: Column(
                      children: [
                        // Profile Info and Tabs
                        Expanded(
                          child: NestedScrollView(
                            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(21.sp),
                                            child: Container(
                                              height: 11.h,
                                              width: 11.h,
                                              color: Colors.grey.shade200,
                                              child: Image.asset(
                                                "assets/png/girl_profile.png",
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Icon(Icons.person, size: 8.h, color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                customText(
                                                  text: "Sarah Scarnio",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "CormorantGaramond",
                                                ),
                                                customText(
                                                  text: "1500+ Friends",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: darkGreyColor,
                                                ),
                                                SizedBox(height: 0.8.h),
                                                Row(
                                                  children: [
                                                    Obx(() =>
                                                      controller.isUser.value == true ?
                                                      buttonWidget(
                                                        "Message",
                                                        whiteColor,
                                                        colors: greenColor.withAlpha(140),
                                                        height: 3.5.h,
                                                        width: 27.w,
                                                        fontsize: 14.sp,
                                                        onTap: () {
                                                        },
                                                      ):SizedBox.shrink(),
                                                    ),
                                                    Obx(() =>
                                                      controller.isUser.value == true?
                                                      SizedBox(width: 2.w):SizedBox.shrink(),
                                                    ),
                                                    buttonWidget(
                                                      "Share Profile",
                                                      whiteColor,
                                                      colors: blueColor.withAlpha(140),
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
                                            errorBuilder: (context, error, stackTrace) =>
                                                Icon(Icons.location_on, size: 2.h, color: Colors.grey),
                                          ),
                                          SizedBox(width: 1.w),
                                          customText(
                                            text: "New York",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: blackColor,
                                            txtDecoration: TextDecoration.underline,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),
                                      child: TabBar(
                                        indicatorColor: blackColor,
                                        labelColor: blackColor,
                                        unselectedLabelColor: Colors.grey,
                                        labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                                        tabs: const [
                                          Tab(text: "Preference"),
                                          Tab(text: "Posts"),
                                          Tab(text: "Highlights"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            body: TabBarView(
                              children: [
                                // Preference Tab
                                SingleChildScrollView(
                                  padding: EdgeInsets.all(5.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "Dietary Priorities",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: blackColor,
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Allergies:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          allergies.length,
                                              (index) => foodPreferencesOne(
                                            index + 40,
                                            allergies[index]['name']!,
                                            imgpath: allergies[index]['imgPath'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Diets:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          diet.length,
                                              (index) => foodPreferencesOne(
                                            index + 50,
                                            diet[index]['name']!,
                                            imgpath: diet[index]['imgPath'],
                                          ),
                                        ),
                                      ),
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
                                        text: "Food Preferences",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: blackColor,
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Liked Cuisines:",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          likedCuisine.length,
                                              (index) => foodPreferencesOne(
                                            index + 60,
                                            likedCuisine[index]['name']!,
                                            imgpath: likedCuisine[index]['imgPath'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      customText(
                                        text: "Disliked Ingredients",
                                        fontSize: 14.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        children: List.generate(
                                          dislikedIngredient.length,
                                              (index) => foodPreferencesOne(
                                            index + 70,
                                            dislikedIngredient[index]["name"]!,
                                            imgpath: dislikedIngredient[index]["imgPath"],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      // customText(
                                      //   text: "Accessibility Needs",
                                      //   fontSize: 15.sp,
                                      //   color: blackColor,
                                      // ),
                                      // Wrap(
                                      //   spacing: 5,
                                      //   runSpacing: 1,
                                      //   children: List.generate(
                                      //     eventAccesibilityList.length,
                                      //         (index) => eventAccesibillityWidget(
                                      //       eventAccesibilityList[index],
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(height: 5.h),
                                    ],
                                  ),
                                ),

                                // Posts Tab
                                SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildPostCard(
                                        profileImage: "assets/png/chat_images/user5.png",
                                        userName: "Sarah Scarnio",
                                        postTime: "2hrs ago",
                                        postText: "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                        postImage: "assets/png/chat_images/group_profile_pic.png",
                                      ),
                                      SizedBox(height: 5.h),
                                    ],
                                  ),
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
    );
  }

}
