import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/outh_file/local_db_key.dart';
import 'package:yestable/utils/shared_prefrences_methods.dart';
import 'package:yestable/widget/bar_chart.dart';
import 'package:yestable/widget/guest_update_received.dart';
import 'package:yestable/widget/showShareDialogBox_widget.dart';
import 'package:yestable/widget/you_are_invited_dialog.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/custom_image_widget.dart';
import '../../../widget/event_accesibility_widget.dart';
import '../../../widget/foodpreference_yesno_widget.dart';
import '../../../widget/home_screen_widget.dart';
import '../profile_setup_screens/community_profile.dart';
import '../profile_setup_screens/host_profile_reviews.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final yumList =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.yumYuck
            ?.yum
            ?.map((e) => e.toLowerCase().trim())
            .toList() ??
            [];
    final yuckList =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.yumYuck
            ?.yuck
            ?.map((e) => e.toLowerCase().trim())
            .toList() ??
            [];

    // Filter the emoji list to only items present in API
    final filteredItems =
    controller.controller.yumYuckItems.where((item) {
      String name =
      item.replaceAll(RegExp(r'[^\w\s]'), '').trim().toLowerCase();
      return yumList.contains(name) || yuckList.contains(name);
    }).toList();
    final List<String> favMoodFromApi =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.favMood
            ?.map((e) => e.mood?.trim() ?? '')
            .toList() ??
            [];
    final List<Map<String, String>> selectedCuisine =
    controller.controller.foodOptions.where((item) {
      String name = item['name']!.trim();
      return favMoodFromApi.contains(name);
    }).toList();
    final seatingOptions =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.seatingRequirement
            ?.options ??
            [];
    final assistanceOptions =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.extraAssistance
            ?.options ??
            [];
    final quietArea =
        controller
            .controller
            .getMyProfileModel
            .value
            ?.data
            ?.preferences
            ?.quietArea ??
            false;
    final List<String> eventAccesibilityList = [];

    // Seating
    for (var seat in seatingOptions) {
      if (controller.controller.seatingMap.containsKey(seat)) {
        eventAccesibilityList.add(controller.controller.seatingMap[seat]!);
      }
    }

    // Extra Assistance
    for (var assist in assistanceOptions) {
      if (controller.controller.assistanceMap.containsKey(assist)) {
        eventAccesibilityList.add(controller.controller.assistanceMap[assist]!);
      }
    }

    // Quiet Area
    if (quietArea) {
      eventAccesibilityList.add("Quiet Area");
    }

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
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // hostReviewsBottomSheet(context);
                            AllergenBarChart();
                          },
                          child: customText(
                            text:
                            controller.isUser.value
                                ? "My Profile"
                                : "Host Profile",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: whiteColor,
                            fontFamily: "CormorantGaramond",
                            height: 0.1.h,
                          ),
                        ),
                        controller.isUser.value
                            ? customText(
                          text: controller.formatDate2(DateTime.now()) ?? "May 01, 2025",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: whiteColor,
                        ): SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Spacer(),
                  homeIconWidget(
                    icon: Icons.logout,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      // 1. Pehle flag ko true kar dein taake dialog block ho jaye
                      controller.hasCheckedProfile.value = true;

                      // 2. Index ko reset karein
                      controller.currentIndex.value = 0;
                      // 3. User status set karein
                      controller.isUser.value = true;
                      // controller.isLoggedIn.value = false; // Isko bhi false karna zaroori hai
                      await prefs.clear();
                      // 4. offAllNamed use karein taake stack saaf ho jaye aur black screen ya dialog issue na aaye
                      Get.offAllNamed("getstarted");
                    },
                  ),
                  SizedBox(width: 2.w),
                  homeIconWidget(
                    icon: Icons.notifications,
                    onTap: () => controller.goToNotificationPage(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Main Scrollable Area
            Obx((){
              final data = controller.controller.getMyProfileModel.value?.data;
              return Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                  child: Container(
                    color: backgroundColor,
                    child: DefaultTabController(
                      length: 1,
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
                                              child: InkWell(
                                                onTap: () {
                                                  guestUpdateReceived(
                                                    context,
                                                  );
                                                },
                                                child: Container(
                                                  height: 11.h,
                                                  width: 11.h,
                                                  color: Colors.grey.shade200,
                                                  child:
                                                  data?.profilePic != null
                                                      ? CustomProfileWidget(
                                                    imageUrl:
                                                    "${controller.controller.baseService.baseURL}${data?.profilePic ?? ""}",
                                                    width: 80,
                                                    height: 80,
                                                    radius: 40,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Image.asset(
                                                    "assets/png/girl_profile.png",
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                        ) => Icon(
                                                      Icons
                                                          .person,
                                                      size: 8.h,
                                                      color:
                                                      Colors
                                                          .grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  AllergenBarChart();
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    customText(
                                                      text:
                                                      data?.name ??
                                                          "Sarah Scarnio",
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontFamily:
                                                      "CormorantGaramond",
                                                    ),
                                                    // customText(
                                                    //   text: "256 Friends",
                                                    //   fontSize: 14.sp,
                                                    //   fontWeight:
                                                    //       FontWeight.w400,
                                                    //   color: darkGreyColor,
                                                    // ),
                                                    SizedBox(height: 0.8.h),
                                                    Row(
                                                      children: [
                                                        buttonWidget(
                                                          "Edit Profile",
                                                          whiteColor,
                                                          colors: greenColor
                                                              .withAlpha(140),
                                                          height: 3.25.h,
                                                          width: 27.w,
                                                          fontsize: 14.sp,
                                                          onTap: () {
                                                            Get.toNamed("profileeditscreen",);
                                                            controller.controller.isEdit.value = true;
                                                            controller.hasCheckedProfile.value = false;
                                                            print("IsEdit: ${controller.controller.isEdit.value}");
                                                            // print("faaaahhhh: ${data}");
                                                          },
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        Builder(
                                                            builder: (buttonContext) {
                                                              return buttonWidget(
                                                                "Share Profile",
                                                                whiteColor,
                                                                colors: blueColor.withAlpha(140),
                                                                height: 3.25.h,
                                                                width: 27.w,
                                                                fontsize: 14.sp,
                                                                onTap: () async {
                                                                  final prefs = await SharedPreferencesMethod.storage;
                                                                  final userId = prefs.getString(LocalDBKeys.USERID);

                                                                  final String url =
                                                                      "https://yes-table-web.vercel.app/?userId=$userId";

                                                                  final box = buttonContext.findRenderObject() as RenderBox?;
                                                                  Share.share(
                                                                    url,
                                                                    subject: "Check out my profile",
                                                                    sharePositionOrigin: box != null
                                                                        ? box.localToGlobal(Offset.zero) & box.size
                                                                        : null,
                                                                  );
                                                                },
                                                              );
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.h),
                                        customText(
                                          text:
                                          data?.bio ??
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
                                              text:
                                              data?.location ??
                                                  "New York",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
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
                                      isScrollable: true,
                                      padding: EdgeInsets.zero,
                                      indicatorColor: blackColor,
                                      labelColor: blackColor,
                                      unselectedLabelColor: Colors.grey,
                                      labelStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      labelPadding: EdgeInsets.zero,
                                      tabs: [
                                        Tab(text: "Preference"),
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
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                        ),
                                        SizedBox(height: 1.h),
                                        customText(
                                          text: "Allergies:",
                                          fontSize: 14.sp,
                                          color: blackColor,
                                        ),
                                        SizedBox(height: 0.5.h),

                                        Wrap(
                                          spacing: 5,
                                          runSpacing: 1,
                                          children: List.generate(
                                            controller
                                                .controller
                                                .allergens
                                                .length,
                                                (index) {
                                              const keys = ["peanut", "treeNuts", "sesame", "gluten", "eggs", "soy", "fish", "shellFish", "dairy"];
                                              final key = keys.length > index ? keys[index] : '';
                                              final rawValue = controller.controller.allergensMap.isNotEmpty ? (controller.controller.allergensMap[key] ?? '') : '';

                                              // Use the new function to get simplified severity
                                              final severity = controller
                                                  .controller
                                                  .getAllergySeverity(
                                                rawValue,
                                              );

                                              return foodPreferencesOne(
                                                index + 15,
                                                "${controller.controller.allergens[index]['title']} - $severity",
                                                imgpath:
                                                controller
                                                    .controller
                                                    .allergens[index]['path'],
                                              );
                                            },
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
                                            controller
                                                .controller
                                                .selectedDiet
                                                .length,
                                                (index) {
                                              return foodPreferencesOne(
                                                index + 24,
                                                controller
                                                    .controller
                                                    .selectedDiet[index]['name']!,
                                                imgpath:
                                                controller
                                                    .controller
                                                    .selectedDiet[index]['imgPath'],
                                              );
                                            },
                                          ),
                                        ),

                                        SizedBox(height: 2.h),
                                        customText(
                                          text: "Yuck Or Yum?",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                          fontFamily: 'CormorantGaramond',
                                        ),
                                        SizedBox(height: 0.7.h),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemCount: filteredItems.length,
                                          itemBuilder: (context, index) {
                                            String item =
                                            filteredItems[index];
                                            String name =
                                            item
                                                .replaceAll(
                                              RegExp(r'[^\w\s]'),
                                              '',
                                            )
                                                .trim()
                                                .toLowerCase();
                                            bool isSelected;
                                            Color color;

                                            if (yumList.contains(name)) {
                                              isSelected = true;
                                              color = greenColor;
                                            } else if (yuckList.contains(
                                              name,
                                            )) {
                                              isSelected = false;
                                              color = redColor;
                                            } else {
                                              // This should not happen because we filtered already
                                              return SizedBox.shrink();
                                            }

                                            return yuckOrYumList(
                                              title: item,
                                              color: color,
                                              isSelected: isSelected,
                                            );
                                          },
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
                                            selectedCuisine.length,
                                                (index) => foodPreferencesOne(
                                              index + 28,
                                              selectedCuisine[index]['name']!,
                                              imgpath:
                                              selectedCuisine[index]['imgPath'],
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 1.h),
                                        // customText(
                                        //   text: "Disliked Ingredients",
                                        //   fontSize: 14.sp,
                                        //   color: blackColor,
                                        //   fontWeight: FontWeight.w500,
                                        // ),
                                        // SizedBox(height: 0.5.h),
                                        // Wrap(
                                        //   spacing: 5,
                                        //   runSpacing: 1,
                                        //   children: List.generate(
                                        //     dislikedIngredient.length,
                                        //     (index) => foodPreferencesOne(
                                        //       index + 35,
                                        //       dislikedIngredient[index]["name"]!,
                                        //       imgpath:
                                        //           dislikedIngredient[index]["imgPath"],
                                        //     ),
                                        //   ),
                                        // ),
                                        controller.isUser.value
                                            ? Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(height: 2.h),
                                            customText(
                                              text:
                                              "Accessibility Needs",
                                              fontSize: 15.sp,
                                              color: blackColor,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                            Wrap(
                                              spacing: 5,
                                              runSpacing: 1,
                                              children: List.generate(
                                                eventAccesibilityList
                                                    .length,
                                                    (
                                                    index,
                                                    ) => eventAccesibillityWidget(
                                                  eventAccesibilityList[index],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  // Center(
                                  //   child: SingleChildScrollView(
                                  //     child:
                                  //         controller.isUser.value
                                  //             ? Column(
                                  //               children: [
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsets.symmetric(
                                  //                         horizontal: 5.w,
                                  //                         vertical: 1.h,
                                  //                       ),
                                  //                   child: buildPostCard(
                                  //                     profileImage:
                                  //                         "assets/png/chat_images/user5.png",
                                  //                     userName:
                                  //                         "Sarah Scarnio",
                                  //                     postTime:
                                  //                         "2hrs ago",
                                  //                     postText:
                                  //                         "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                  //                     postImage:
                                  //                         "assets/png/chat_images/group_profile_pic.png",
                                  //                   ),
                                  //                 ),
                                  //                 Divider(),
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsets.symmetric(
                                  //                         horizontal: 5.w,
                                  //                       ),
                                  //                   child: buildPostCard(
                                  //                     profileImage:
                                  //                         'assets/png/chat_images/user5.png',
                                  //                     userName:
                                  //                         'Sarah Scarnio',
                                  //                     postTime: '3h ago',
                                  //                     postText:
                                  //                         "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                  //                     likesCount:
                                  //                         '1.4k Likes',
                                  //                     showRepliesAndAvatar:
                                  //                         false, // 👈 Only likes shown
                                  //                   ),
                                  //                 ),
                                  //                 Divider(),
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsets.symmetric(
                                  //                         horizontal: 5.w,
                                  //                       ),
                                  //                   child: buildPostCard(
                                  //                     profileImage:
                                  //                         'assets/png/chat_images/user5.png',
                                  //                     userName:
                                  //                         'Sarah Scarnio',
                                  //                     postTime: '3h ago',
                                  //                     postText:
                                  //                         "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                  //                     likesCount:
                                  //                         '1.4k Likes',
                                  //                     showRepliesAndAvatar:
                                  //                         false, // 👈 Only likes shown
                                  //                   ),
                                  //                 ),
                                  //                 Divider(),
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsets.symmetric(
                                  //                         horizontal: 5.w,
                                  //                       ),
                                  //                   child: buildPostCard(
                                  //                     profileImage:
                                  //                         'assets/png/chat_images/user5.png',
                                  //                     userName:
                                  //                         'Sarah Scarnio',
                                  //                     postTime: '3h ago',
                                  //                     postText:
                                  //                         "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien.",
                                  //                     likesCount:
                                  //                         '1.4k Likes',
                                  //                     showRepliesAndAvatar:
                                  //                         false, // 👈 Only likes shown
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //             : Column(
                                  //               children: [
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsets.symmetric(
                                  //                         horizontal: 5.w,
                                  //                         vertical: 1.h,
                                  //                       ),
                                  //                   child: buildPostCard(
                                  //                     profileImage:
                                  //                         "assets/png/chat_images/user5.png",
                                  //                     userName:
                                  //                         "Sarah Scarnio",
                                  //                     postTime:
                                  //                         "2hrs ago",
                                  //                     postText:
                                  //                         "Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nulla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget Faucibusequat scelerisque.",
                                  //                     postImage:
                                  //                         "assets/png/chat_images/group_profile_pic.png",
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

            })
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
  bool isExpanded = false,
}) {
  bool isLiked = false;

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
              onTap: () {},
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
                      clipBehavior:
                      Clip.antiAlias, // Optional: this clips the image only
                      child: Image.asset(
                        profileImage,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
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
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ), // Optional border
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
                        fontSize:
                        userNameFontSize != null ? userNameFontSize : 16.sp,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                        // fontFamily: "CormorantGaramond",
                      ),
                      // Dropdown using local StatefulBuilder context to avoid breaking existing calls
                      StatefulBuilder(
                        builder: (localContext, setMenuState) {
                          return GestureDetector(
                            onTapDown: (details) {
                              showMenu(
                                color: backgroundColor,
                                context: localContext,
                                position: RelativeRect.fromLTRB(
                                  details.globalPosition.dx,
                                  details.globalPosition.dy,
                                  details.globalPosition.dx,
                                  details.globalPosition.dy,
                                ),
                                items: [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text("Delete"),
                                  ),
                                ],
                              );
                            },
                            child: Icon(
                              Icons.more_horiz,
                              size: 20.sp,
                              color: blackColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  customText(
                    text: postTime,
                    fontSize:
                    postTimeFontSize != null ? postTimeFontSize : 14.sp,
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor,
                  ),
                  SizedBox(height: 0.5.h),
                  //
                  // // Post Text
                  // customText(
                  //   text: postText,
                  //   fontSize: postTextFontSize!= null ? postTextFontSize : 14.sp,
                  //   fontWeight: FontWeight.w400,
                  //   color: darkGreyColor,
                  //   maxLines: showReadMore ? 4 : null,
                  // ),
                  SizedBox(height: 0.5.h),
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
                                recognizer:
                                TapGestureRecognizer()
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
                              backgroundImage: AssetImage(
                                'assets/png/chat_images/user5.png',
                              ),
                            ),
                            SizedBox(width: 2.w),
                            customText(
                              text: repliesCount,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              txtDecoration: TextDecoration.underline,
                            ),
                            SizedBox(width: 4.w),
                          ],
                          // Likes (always shown)
                          customText(
                            text: likesCount,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: darkGreyColor,
                          ),
                        ],
                      ),

                      // Action Icons
                      Row(
                        children: [
                          StatefulBuilder(
                            builder: (context, setLikeState) {
                              return GestureDetector(
                                onTap: () {
                                  setLikeState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                                child: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 18.sp,
                                  color: isLiked ? Colors.red : null,
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 2.5.w),
                          Image.asset(
                            "assets/png/icons/comment_icon.png",
                            height: 16.sp,
                          ),
                          SizedBox(width: 3.w),
                          Image.asset(
                            "assets/png/icons/repost_icon.png",
                            height: 16.sp,
                          ),
                        ],
                      ),
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
