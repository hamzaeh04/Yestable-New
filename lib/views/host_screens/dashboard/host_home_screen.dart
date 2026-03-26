import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/views/guest_screens/dashboard/event_screen.dart';
import 'package:yestable/widget/guest_update_received.dart';
import '../../../controllers/event_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/complete_guest_dialog.dart';
import '../../../widget/event_floating_button.dart';
import '../../../widget/home_screen_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:collection/collection.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();
  List<Map<String, String>> guestAllergyData = [
    {
      "path": "assets/png/guest_list_images/allergies1.png",
      "name": "Sidney Swaniawski",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies2.png",
      "name": "Eloise Brakus",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies3.png",
      "name": "Gustavo Bode",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies4.png",
      "name": "Darla Mohr",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies2.png",
      "name": "Eloise Brakus",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies3.png",
      "name": "Gustavo Bode",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies4.png",
      "name": "Darla Mohr",
      "allergen": "Dairy",
    },
    {
      "path": "assets/png/guest_list_images/allergies1.png",
      "name": "Sidney Swaniawski",
      "allergen": "Dairy",
    },
  ];
  final prefs = SharedPreferencesMethod.storage;


  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (controller.isGuestUpdateReceived.value) {
    //     // Show dialog for guest update
    //     controller.isGuestUpdateReceived.value = false;
    //     guestUpdateReceived(context);
    //   } else if (!controller.isProfileComplete.value &&
    //       !controller.hasCheckedProfile.value) {
    //     controller.hasCheckedProfile.value = true;
    //     completeGuestProfileDialog(context);
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // SIRF EK LOCK: Kya humne check kar liya hai?
      if (controller.hasCheckedProfile.value == false) {
        // 1. Foran lock lagao taake ye block dobara execute na ho
        controller.hasCheckedProfile.value = true;

        // 2. Ab priority wise check karo konsa dialog dikhana hai
        if (controller.isInvited.value == false) {
          if (!controller.isProfileComplete.value) {
            // Agar profile incomplete hai to ye dikhao
            completeGuestProfileDialog(context);
          } else if (controller.isGuestUpdateReceived.value) {
            // Agar profile complete hai lekin koi update aayi hai to ye dikhao
            controller.isGuestUpdateReceived.value = false;
            guestUpdateReceived(context);
          }
        }
      }
    });

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
                          height: 0.1.h
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
                    onTap: () {
                      // controller.goTSearchScreen();
                    },
                    child: homeIconWidget(
                      imagePath: "assets/png/icons/search_icon.png",
                    ),
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {
                      controller.goToNotificationPage();
                    },
                    child: homeIconWidget(icon: Icons.notifications),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Main Scrollable Body with Rounded Corners
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
                          // Dinner Calendar Header
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      text: "Quick Report",
                                      fontSize: 20.sp,
                                      fontFamily: "CormorantGaramond",
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                    customText(
                                      text:
                                          "Lorem ipsum dolor sit amet consectetur.",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                    SizedBox(height: 1.5.h),

                                    // Inside your Column > children, replace the Container block with this:
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () =>
                                controller.showAllergicGuest.value == true
                                    ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20.sp,
                                          ),
                                          color: whiteColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 1.h),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  customText(
                                                    text:
                                                        "Guests are allergic to dairy products.",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: blackColor,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 4.h,
                                                        width: 4.w,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  yellowColor,
                                                            ),
                                                      ),
                                                      SizedBox(width: 2.w),
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .showAllergicGuest
                                                              .value = false;
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 20.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: customText(
                                                text: "09 Allergens Found",
                                                fontSize: 13.sp,
                                                fontFamily: "WorkSans2",
                                                fontWeight: FontWeight.w400,
                                                height: 0.1.h,
                                              ),
                                            ),
                                            SizedBox(height: 3.h),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              // Optional: If you want to embed it in a column
                                              itemCount:
                                                  guestAllergyData.length,
                                              itemBuilder: (context, index) {
                                                final guest =
                                                    guestAllergyData[index];
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 5.w,
                                                            vertical: 0.7.h,
                                                          ),
                                                      child: guestListAllergiesWidget(
                                                        path: guest['path']!,
                                                        name: guest['name']!,
                                                        allergen:
                                                            guest['allergen']!,
                                                      ),
                                                    ),
                                                    Divider(),
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(height: 3.h),
                                          ],
                                        ),
                                      ),
                                    )
                                    : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Container(
                                            width: 88.w,
                                            height: 4.5.h,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 1.w,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.sp),
                                              border: Border.all(
                                                color: const Color(0xFF5A7C79),
                                              ),
                                              color: const Color(0xFFF6EEEB),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                value:
                                                    controller
                                                            .selectedEvent
                                                            .value
                                                            .isEmpty
                                                        ? null
                                                        : controller
                                                            .selectedEvent
                                                            .value,

                                                iconStyleData:
                                                    const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.black,
                                                      ),
                                                      iconSize: 24,
                                                    ),

                                                hint: customText(
                                                  text: "Select The Event",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                ),

                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                      offset: const Offset(
                                                        0,
                                                        -7,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              15.sp,
                                                            ),
                                                        color: Colors.white,
                                                      ),
                                                    ),

                                                // ✅ Fix: Show selected value without tick
                                                selectedItemBuilder: (context) {
                                                  return controller.events.map((
                                                    value,
                                                  ) {
                                                    return Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: customText(
                                                        text: value,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    );
                                                  }).toList();
                                                },

                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    controller.selectEvent(
                                                      newValue,
                                                    );
                                                  }
                                                },

                                                // ✅ Dropdown list with check and dividers
                                                items:
                                                    controller.events.mapIndexed((
                                                      index,
                                                      value,
                                                    ) {
                                                      final isLast =
                                                          index ==
                                                          controller
                                                                  .events
                                                                  .length -
                                                              1;

                                                      return DropdownMenuItem<
                                                        String
                                                      >(
                                                        value: value,
                                                        enabled: true,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    vertical:
                                                                        1.h,
                                                                  ),
                                                              // consistent spacing for all items
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  customText(
                                                                    text: value,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  if (controller
                                                                          .selectedEvent
                                                                          .value ==
                                                                      value)
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      size:
                                                                          18.sp,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (!isLast)
                                                              Container(
                                                                height: 1,
                                                                color:
                                                                    Colors
                                                                        .grey[300],
                                                              ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        // Calendar Image
                                        Obx(
                                          () => Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                            ),
                                            child:
                                                controller
                                                            .selectedEvent
                                                            .value ==
                                                        "Gizelle Dinner Event"
                                                    ? Container(
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20.sp,
                                                            ),
                                                        color: whiteColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 3.w,
                                                              vertical: 1.h,
                                                            ),
                                                        child: Column(
                                                          children: [
                                                            // Custom TabBar with underline effect
                                                            Obx(() {
                                                              return Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .bottomCenter,
                                                                children: [
                                                                  // Full underline (grey background line)
                                                                  Container(
                                                                    height:
                                                                        0.2.h,
                                                                    color:
                                                                        Colors
                                                                            .grey
                                                                            .shade300,
                                                                    margin: EdgeInsets.only(
                                                                      top: 4.h,
                                                                    ), // adjust height from text
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: List.generate(
                                                                      controller
                                                                          .allergenList
                                                                          .length,
                                                                      (index) {
                                                                        final bool
                                                                        isSelected =
                                                                            controller.allergenSelectedIndex.value ==
                                                                            index;
                                                                        return GestureDetector(
                                                                          onTap: () {
                                                                            controller.allergenSelectedIndex.value =
                                                                                index;
                                                                            controller.selectedIndex.value =
                                                                                index;
                                                                          },
                                                                          child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              customText(
                                                                                text:
                                                                                    controller.allergenList[index],
                                                                                fontSize:
                                                                                    14.sp,
                                                                                fontFamily:
                                                                                    "CormorantGaramond",
                                                                                fontWeight:
                                                                                    FontWeight.w600,
                                                                                color:
                                                                                    Colors.black,
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    1.h,
                                                                              ),
                                                                              // Black highlight only for selected tab
                                                                              Container(
                                                                                height:
                                                                                    0.2.h,
                                                                                width:
                                                                                    26.5.w,
                                                                                color:
                                                                                    isSelected
                                                                                        ? Colors.black
                                                                                        : Colors.transparent,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                            SizedBox(
                                                              height: 12,
                                                            ),

                                                            // Display content based on selected tab
                                                            Obx(() {
                                                              switch (controller
                                                                  .selectedIndex
                                                                  .value) {
                                                                case 0:
                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      customText(
                                                                        text:
                                                                            "32 Allergens found",
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontFamily:
                                                                            "WorkSans",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          controller
                                                                              .toggleShowAllergicGuest();
                                                                        },
                                                                        child: Image.asset(
                                                                          "assets/png/new_guest_illustrations/allergen_graph_one.png",
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                case 1:
                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      customText(
                                                                        text:
                                                                            "32 Allergens found",
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontFamily:
                                                                            "WorkSans",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Get.toNamed(
                                                                            "newguestlistscreen",
                                                                          );
                                                                        },
                                                                        child: Image.asset(
                                                                          "assets/png/new_guest_illustrations/allergen_graph_two.png",
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                case 2:
                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      customText(
                                                                        text:
                                                                            "32 Allergens found",
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontFamily:
                                                                            "WorkSans",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            1.h,
                                                                      ),
                                                                      Image.asset(
                                                                        "assets/png/new_guest_illustrations/allergen_graph_three.png",
                                                                      ),
                                                                    ],
                                                                  );
                                                                default:
                                                                  return SizedBox.shrink();
                                                              }
                                                            }),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.sp,
                                                          ),
                                                      child: Image.asset(
                                                        "assets/png/select_event_banner.png",
                                                        width: double.infinity,
                                                        fit:
                                                            BoxFit
                                                                .fill, // or use BoxFit.cover if you prefer
                                                      ),
                                                    ),
                                          ),
                                        ),

                                        SizedBox(height: 3.h),

                                        // Invitations
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                text: "RSVP",
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "CormorantGaramond",
                                                color: blackColor,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.changePage(1);
                                                },
                                                child: Row(
                                                  children: [
                                                    customText(
                                                      text: "View All",
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                    ),
                                                    SizedBox(width: 1.w),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: blackColor,
                                                      size: 16.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                          child: Obx(() {
                                            final eventData = eventController.myEventsModel.value?.data?.data;

                                            // Show loader while fetching first page
                                            if (eventController.isLoadingMyEvents.value)
                                              return Padding(
                                                padding: EdgeInsets.only(top: 6.h),
                                                child: Center(child: CircularProgressIndicator(color: greenColor)),
                                              );

                                            // No data found
                                            if (eventData == null || eventData.isEmpty)
                                              return Padding(
                                                padding: EdgeInsets.only(top: 7.h),
                                                child: Center(
                                                  child: customText(text: 'No RSVP found!', fontSize: 14.5.sp),
                                                ),
                                              );

                                            return Column(
                                              children: [
                                                // Event list
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: eventData.length,
                                                  itemBuilder: (context, index) {
                                                    final data = eventData[index];
                                                    return adminHomeWidget(
                                                      eventname: data?.eventName,
                                                      confirmedamount: "08 Guest Confirmed",
                                                      value: 0.65,
                                                      ontap: () {
                                                        Get.toNamed("eventdetailsscreen", arguments: data?.id);
                                                      },
                                                    );
                                                  },
                                                ),

                                                SizedBox(height: 2.h),

                                                // Load More Button
                                                if (eventController.currentPage < eventController.totalPages)
                                                  ElevatedButton(
                                                    onPressed: eventController.isLoadingMore.value
                                                        ? null
                                                        : () => eventController.getMyEvents(loadMore: true),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: greenColor,
                                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                                                    ),
                                                    child: eventController.isLoadingMore.value
                                                        ? SizedBox(
                                                      height: 2.h,
                                                      width: 2.h,
                                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                                    )
                                                        : customText(text: "Load More", color: Colors.white, fontSize: 14.sp),
                                                  ),
                                              ],
                                            );
                                          })
                                        ),
                                        SizedBox(height: 5.h),
                                      ],
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
      floatingActionButton: buildCreateNewEventButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget adminHomeWidget({
    String? eventname,
    String? confirmedamount,
    String? progress,
    double? value,
    VoidCallback? ontap
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with image and content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: Image.asset(
                    "assets/png/admin_home_foodpic.png",
                    height: 7.h,
                    width: 15.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 3.w),

                // Text content beside image
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row with Event name and (30/25)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: customText(
                              text: eventname ?? "",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                            ),
                          ),
                          customText(
                            text: progress ?? "(30/25)",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ],
                      ),
                      customText(
                        text: confirmedamount ?? "",
                        // e.g. "25 Guest Confirmed"
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                      SizedBox(height: 0.8.h),
                      // Progress bar (inside content column)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.sp),
                        child: LinearProgressIndicator(
                          minHeight: 0.7.h,
                          value: value,
                          valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                          backgroundColor: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


Widget guestListAllergiesWidget({
  required String path,
  required String name,
  required String allergen,
}) {
  return Row(
    children: [
      Image.asset("$path", width: 14.w),
      SizedBox(width: 3.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: name,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            // fontFamily: "CormorantGaramond",
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(color: greyBorderColor, width: 0.2.w),
            ),
            child: customText(
              text: allergen,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "WorkSans2",
              color: greyTextColor,
            ),
          ),
        ],
      ),
    ],
  );
}
