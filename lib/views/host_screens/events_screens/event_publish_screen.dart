import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/views/guest_screens/profile_setup_screens/host_profile_reviews.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/event_posted_dialog.dart';
import 'package:yestable/widget/home_screen_widget.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/event_accesibility_widget.dart';
import '../../guest_screens/dashboard/event_details_screen.dart';

class EventPublishScreen extends StatelessWidget {
  EventPublishScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();
  BaseService baseService = BaseService();


  final List<String> eventMenuList = ["Vegetarian", "Contain Dairy","Gluten-Free","Shelfish","Vegan","Nut-Free"];

  @override
  Widget build(BuildContext context) {
    final eventId = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((_){
      eventController.eventReview(eventId);


    });

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx((){
              final data = eventController.eventReviewModel.value?.data;
              eventController.mapEventComfortAccessibility(
                data?.eventComfort,
                data?.guestAware,
              );
              
              final notAllowedItem = data?.guestAware?.itemContaining?.split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList() ?? [];
                  
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/png/event_screen_banner.png',
                    height: 35.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: data?.eventName ?? "Gizelle Dinner Event",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                          color: blackColor,
                        ),

                        SizedBox(height: 0.5.h),
                        customText(
                          text: data?.addNote ??
                              "Lorem ipsum dolor sit amet consectetur. Viverra tellus\neget magna sapien. Faucibus nibh mauris mattis aliquam\nproin pellentesque sed done.",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Invitation Message",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                          color: blackColor,
                        ),

                        SizedBox(height: 0.5.h),
                        customText(
                          text: data?.invitationMessage ??
                              "With hearts full of joy, we invite you to join us in celebrating the first birthday of our beloved [Baby’s Name]. This special milestone means so much to us, and your presence will make the day even more memorable.",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),

                  Divider(),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.only(bottom: 1.h),
                        dense: true,
                        title: Row(
                          children: [
                            Expanded(
                              child: customText(
                                text: "Event Comfort & Accessibility",
                                fontSize: 18.5.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: "CormorantGaramond",
                                color: blackColor,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          // Event Accessibility List
                          Wrap(
                            spacing: 5,
                            runSpacing: 1,
                            children: List.generate(
                              eventController.eventComfortAccessibility.length,
                                  (index) => eventAccesibillityWidget(
                                eventController.eventComfortAccessibility[index],
                              ),
                            ),
                          ),

                          if (notAllowedItem.isNotEmpty) ...[
                            Divider(),

                            // Items Are Not Allowed Section
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                        text: "Items Are Not Allowed",
                                        fontSize: 18.5.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "CormorantGaramond",
                                        color: blackColor,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 1.h),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 1,
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                          notAllowedItem.length,
                                              (index) => eventAccesibillityWidget(
                                            notAllowedItem[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed("hostprofilepcreen");
                      },
                      child: Row(
                        children: [
                          // (data?.host?.profilePic == null || data!.host!.profilePic!.isEmpty)
                          //     ? Image.asset(
                          //   "assets/png/chat_images/user1.png",
                          //   height: 9.h,
                          //   width: 14.w,
                          // )
                          //     : Image.network(
                          //   "${baseService.baseURL}${data.host?.profilePic}",
                          //   height: 9.h,
                          //   width: 14.w,
                          //   fit: BoxFit.cover,
                          // ),
                          Image.asset(
                            "assets/png/chat_images/user1.png",
                            height: 9.h,
                            width: 14.w,
                          ),
                          SizedBox(width: 3.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: data?.host?.name ?? "Gizelle Jekronia",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: blackColor,
                              ),
                              SizedBox(height: 0.1.h),
                              customText(
                                text: "Event Host",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: blackColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.9.h),
                          child: Image.asset(
                            "assets/png/icons/round_watch.png",
                            height: 2.h,
                            width: 4.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: controller.formatDate2(data?.eventTime) ?? "May 02, 2025",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                                height: 0.1.h,
                              ),
                              SizedBox(height: 0.5.h),
                              customText(
                                text: controller.formatTime2(data?.eventTime) ?? "7:30 PM - 9:00 PM",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: darkGreyColor,
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/png/icons/map_location_icon.png",
                          height: 2.h,
                          width: 4.w,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              customText(
                                text: "IN HOUSES",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                                height: 0.1.h,
                              ),
                              SizedBox(height: 0.5.h),
                              customText(
                                text: "New York, USA",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: darkGreyColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // Container(
                  //
                  //   width: double.infinity,
                  //   color: eventDinnerBrownColor,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.w),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         customText(
                  //           text: "25 People Are Coming",
                  //           fontSize: 14.sp,
                  //           fontWeight: FontWeight.w500,
                  //           fontFamily: "CormorantGaramond",
                  //           color: blackColor,
                  //         ),
                  //         SizedBox(height: 1.h),
                  //         SizedBox(
                  //           height: 4.h,
                  //           child: ListView.separated(
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: 9,
                  //             separatorBuilder: (_, __) => SizedBox(width: 2.w),
                  //             itemBuilder: (_, index) {
                  //               final image = Image.asset(
                  //                 'assets/png/chat_images/user${(index%5) + 1}.png',
                  //                 width: 3.8.h,
                  //                 height: 4.h,
                  //                 fit: BoxFit.cover,
                  //               );
                  //
                  //               return ClipRRect(
                  //                 borderRadius: BorderRadius.circular(10.sp),
                  //                 child: Stack(
                  //                   children: [
                  //                     image,
                  //                     if (index == 8)
                  //                       Positioned.fill(
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.black.withOpacity(0.4),
                  //                           ),
                  //                           child: Center(
                  //                             child: customText(
                  //                               text: "10+",
                  //                               fontSize: 14.sp,
                  //                               fontWeight: FontWeight.w500,
                  //                               color: whiteColor,
                  //                               fontFamily: "WorkSans2"
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                   ],
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Where You’ll Be",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                          color: blackColor,
                        ),
                        customText(
                          text: "132 My Street, Kingston, New York 12486.",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          child: Image.asset("assets/png/event_detail_img/event_detial_map.png"),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Divider(),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Event Menu",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                          color: blackColor,
                        ),
                        customText(
                          text: "See dishes made for you - no stress, just great food",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text: "Your Dietry Compactibility Score",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: greenColor,
                            ),
                            customText(
                              text: "95%",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: greenColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        LinearProgressIndicator(
                          backgroundColor: whiteColor, // Track color
                          color: greenColor,            // Progress color
                          value: 0.95,
                          minHeight: 0.7.h,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        SizedBox(height: 1.5.h),
                        controller.isUser.value ?
                        Wrap(
                          spacing: 4,
                          runSpacing: 0,
                          children: List.generate(
                            eventMenuList.length,
                                (index) => eventAccesibillityWidget(
                              eventMenuList[index],
                            ),
                          ),
                        )
                            :
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.black,
                                indicatorWeight: 2,
                                tabs: const [
                                  Tab(text: "Appetizers"),
                                  Tab(text: "Main Course"),
                                  Tab(text: "Drinks"),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Builder(builder: (context) {
                                final tabController = DefaultTabController.of(context);
                                return AnimatedBuilder(
                                  animation: tabController,
                                  builder: (context, _) {
                                    final currentTabName = ["Appetizers", "Main Course", "Drinks"][tabController.index];
                                    final filteredMenus = data?.menus?.where((m) => m.type == currentTabName).toList() ?? [];

                                    if (filteredMenus.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.h),
                                        child: Center(
                                          child: customText(
                                              text: "No $currentTabName added yet",
                                              fontSize: 14.sp),
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: filteredMenus.map((menu) {
                                        String cat1 = "";
                                        String cat2 = "";
                                        if (menu.mealCategory != null && menu.mealCategory!.isNotEmpty) {
                                          cat1 = menu.mealCategory![0];
                                        }
                                        if (menu.mealCategory != null && menu.mealCategory!.length > 1) {
                                          cat2 = menu.mealCategory![1];
                                        }

                                        return Column(
                                          children: [
                                            menuItem(
                                                title: menu.title ?? "",
                                                subtitle: menu.description ?? "",
                                                imagePath: menu.menuImage != null && menu.menuImage!.isNotEmpty
                                                    ? "${baseService.baseURL}${menu.menuImage}"
                                                    : "",
                                                text1: cat1,
                                                text2: cat2,
                                                boximg1: eventController.mealCategoryIcon(cat1) ?? "",
                                                boximg2: eventController.mealCategoryIcon(cat2) ?? "",
                                                containerColor: backgroundColor),
                                            Divider(),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // Divider(),
                  // SizedBox(height: 1.h),
                  Obx(() {
                    // Add this debug print to verify the value
                    debugPrint('isUser value: ${controller.isUser.value}');

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // customText(
                          //   text: "Gizelle Jekronia Host Reviews",
                          //   fontSize: 20.sp,
                          //   fontWeight: FontWeight.w600,
                          //   fontFamily: "CormorantGaramond",
                          //   color: blackColor,
                          // ),
                          // SizedBox(height: 2.h),
                          // reveiwWidget(context),
                          // SizedBox(height: 2.h),
                          // buttonWidget(
                          //   "See All 26 Reviews",
                          //   greenColor,
                          //   borderColor: greenColor,
                          //   onTap: () {
                          //     hostReviewsBottomSheet(context);
                          //   },
                          // ),
                          if (controller.isUser.value == false) ...[
                            SizedBox(height: 2.h),
                            buttonWidget("Publish Now", whiteColor, colors: greenColor,onTap: (){
                              eventController.publishEvent(eventId, context);
                              // eventPostedDialog(context);
                            }),
                            SizedBox(height: 1.h),
                            buttonWidget("Back", blackColor, colors: backgroundColor, borderColor: backgroundColor,onTap: (){
                              Get.back();
                            }),
                          ],
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 5.h),
                ],
              );
            }
            ),
          ),

          Positioned(
            top: 7.h,
            left: 5.w,
            child: homeIconWidget(
              icon: Icons.arrow_back_ios_new,
              iconsize: 16.sp,
              color: lightgreenColor.withAlpha(250),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
Widget reveiwWidget(BuildContext context) {
  return GestureDetector(
    onTap: (){
    },
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: Colors.grey.shade300, // Slight grey border
          width: 1,                     // Thin border
        ),
        borderRadius: BorderRadius.circular(15.sp), // Optional: rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RatingBarIndicator(
                  rating: 4.7,
                  itemCount: 5,
                  itemSize: 18.sp,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: 2.w),
                customText(
                  text: "2 week ago",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: darkGreyColor,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            customText(
              text: "The host swapped nut for seeds in desserts.\nloved it!",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: darkGreyColor,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 18.sp, // Adjust size as needed
                  backgroundImage: AssetImage('assets/png/chat_images/user1.png'), // Replace with your image path
                  backgroundColor: Colors.grey[200], // Optional: fallback color
                ),
                SizedBox(width: 2.w),
                customText(
                  text: "Sarah Jhonson",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "CormorantGaramond",
                  color: blackColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

