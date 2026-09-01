import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/widget/custom_image_widget.dart';
import 'package:yestable/widget/showShareDialogBox_widget.dart';
import 'package:yestable/widget/floating_home_button.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/foodpreference_yesno_widget.dart';
import '../../../widget/home_screen_widget.dart';
import '../../guest_screens/profile_setup_screens/community_profile.dart';

class GuestProfileScreen extends StatelessWidget {
  GuestProfileScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final BaseService baseService = BaseService();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final id = Get.arguments;
      profileController.GetProfileById(userId: id);
    });
    return floatingHomeButton(
      isProfileSetup: false,
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
                    Expanded(
                      child: customText(
                        text: "Guest Profile",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                        fontFamily: "CormorantGaramond",
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Main Scrollable Area
              Obx(() {
                final data = profileController.getProfileByIdModel.value?.data;

                if (profileController.isLoading.value) {
                  return Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp),
                      ),
                      child: Container(
                        color: backgroundColor,
                        child: Center(
                          child: CircularProgressIndicator(color: greenColor),
                        ),
                      ),
                    ),
                  );
                }

                if (data == null) {
                  return Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp),
                      ),
                      child: Container(
                        color: backgroundColor,
                        child: Center(
                          child: customText(text: "Profile not found"),
                        ),
                      ),
                    ),
                  );
                }

                final preferences = data.preferences;
                final yumList = preferences?.yumYuck?.yum
                    ?.map((e) => e.toLowerCase().trim())
                    .toList() ??
                    [];
                final yuckList = preferences?.yumYuck?.yuck
                    ?.map((e) => e.toLowerCase().trim())
                    .toList() ??
                    [];
                final filteredYumYuckItems =
                profileController.yumYuckItems.where((item) {
                  final name =
                  item.replaceAll(RegExp(r'[^\w\s]'), '').trim().toLowerCase();
                  return yumList.contains(name) || yuckList.contains(name);
                }).toList();
                final favMoodFromApi = preferences?.favMood
                    ?.map((e) => e.mood?.trim() ?? '')
                    .toList() ??
                    [];
                final selectedCuisine =
                profileController.foodOptions.where((item) {
                  return favMoodFromApi.contains(item['name']!.trim());
                }).toList();
                final allergensMap = preferences?.commonAllergens
                    ?.toJson()
                    .map((key, value) => MapEntry(key, value ?? '')) ??
                    {};
                final plate = preferences?.plate;
                final selectedDiets = profileController.diet.where((item) {
                  switch (item['name']) {
                    case 'Vegan':
                      return plate?.vegan == true;
                    case 'Vegetarian':
                      return plate?.vegetarian == true;
                    case 'Halal':
                      return plate?.halal == true;
                    case 'Kosher':
                      return plate?.kosher == true;
                    case 'Keto':
                      return plate?.keto == true;
                    default:
                      return false;
                  }
                }).toList();
                final selectedDisliked =
                profileController.yuckList.where((item) {
                  return yuckList.contains(item['name']!.toLowerCase().trim());
                }).toList();
                final membersCount = data.members?.length ?? 0;
                final profilePicUrl = data.profilePic != null &&
                    data.profilePic!.isNotEmpty
                    ? (data.profilePic!.startsWith('http')
                    ? data.profilePic!
                    : "${baseService.baseURL}${data.profilePic}")
                    : null;

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
                                                  child: profilePicUrl != null
                                                      ? CustomProfileWidget(
                                                    imageUrl: profilePicUrl,
                                                    width: 80,
                                                    height: 80,
                                                    radius: 40,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Image.asset(
                                                    "assets/png/profile_image_large.png",
                                                    fit: BoxFit.contain,
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
                                                      text: data.name ?? "Host",
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "CormorantGaramond",
                                                    ),
                                                    if (membersCount > 0)
                                                      customText(
                                                        text: "$membersCount Friends",
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color: darkGreyColor,
                                                      ),
                                                    SizedBox(height: 0.8.h),
                                                    Row(
                                                      children: [
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
                                                                  final userId = data?.id;
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2.h),
                                          customText(
                                            text: data.bio ??
                                                "No bio available.",
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
                                                text: data.location ?? "Location not set",
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
                                              profileController.allergens.length,
                                                  (index) {
                                                const keys = [
                                                  "peanut",
                                                  "treeNuts",
                                                  "sesame",
                                                  "gluten",
                                                  "eggs",
                                                  "soy",
                                                  "fish",
                                                  "shellFish",
                                                  "dairy",
                                                ];
                                                final key =
                                                keys.length > index ? keys[index] : '';
                                                final rawValue =
                                                    allergensMap[key] ?? '';
                                                final severity = profileController
                                                    .getAllergySeverity(rawValue);

                                                return foodPreferencesOne(
                                                  index + 40,
                                                  "${profileController.allergens[index]['title']} - $severity",
                                                  imgpath: profileController
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
                                            children: selectedDiets.isEmpty
                                                ? [
                                              customText(
                                                text: "No diets selected",
                                                fontSize: 14.sp,
                                                color: darkGreyColor,
                                              ),
                                            ]
                                                : List.generate(
                                              selectedDiets.length,
                                                  (index) => foodPreferencesOne(
                                                index + 50,
                                                selectedDiets[index]['name']!,
                                                imgpath:
                                                selectedDiets[index]['imgPath'],
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
                                            children: filteredYumYuckItems.isEmpty
                                                ? [
                                              customText(
                                                text: "No preferences set",
                                                fontSize: 14.sp,
                                                color: darkGreyColor,
                                              ),
                                            ]
                                                : filteredYumYuckItems.map((item) {
                                              final name = item
                                                  .replaceAll(RegExp(r'[^\w\s]'), '')
                                                  .trim()
                                                  .toLowerCase();
                                              final isYum = yumList.contains(name);
                                              return yuckOrYumList(
                                                title: item,
                                                color: isYum ? greenColor : redColor,
                                                isSelected: isYum,
                                              );
                                            }).toList(),
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
                                            children: selectedCuisine.isEmpty
                                                ? [
                                              customText(
                                                text: "No cuisines selected",
                                                fontSize: 14.sp,
                                                color: darkGreyColor,
                                              ),
                                            ]
                                                : List.generate(
                                              selectedCuisine.length,
                                                  (index) => foodPreferencesOne(
                                                index + 60,
                                                selectedCuisine[index]['name']!,
                                                imgpath:
                                                selectedCuisine[index]['imgPath'],
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
                                            children: selectedDisliked.isEmpty
                                                ? [
                                              customText(
                                                text: "No disliked ingredients",
                                                fontSize: 14.sp,
                                                color: darkGreyColor,
                                              ),
                                            ]
                                                : List.generate(
                                              selectedDisliked.length,
                                                  (index) => foodPreferencesOne(
                                                index + 70,
                                                selectedDisliked[index]["name"]!,
                                                imgpath:
                                                selectedDisliked[index]["imgPath"],
                                              ),
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
                );
              })
            ],
          ),
        ),
      ),
    );
  }

}
