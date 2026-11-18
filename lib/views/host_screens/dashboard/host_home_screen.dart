import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/views/guest_screens/dashboard/event_screen.dart';
import 'package:yestable/widget/custom_image_widget.dart';
import 'package:yestable/widget/guest_update_received.dart';
import '../../../controllers/event_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/common_allergens_chart.dart';
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
  final GlobalKey _rsvpKey = GlobalKey();
  // How many RSVP (hosted) events are currently shown; starts at 5, +10 per "View More".
  final RxInt _rsvpVisible = 5.obs;
  // Past Events dropdown list: collapsed (4 items) or expanded (all).
  final RxBool _pastExpanded = false.obs;


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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // SIRF EK LOCK: Kya humne check kar liya hai?
    //   if (controller.hasCheckedProfile.value == false) {
    //     // 1. Foran lock lagao taake ye block dobara execute na ho
    //     controller.hasCheckedProfile.value = true;
    //
    //     // 2. Ab priority wise check karo konsa dialog dikhana hai
    //     if (controller.isInvited.value == false) {
    //       if (!controller.isProfileComplete.value) {
    //         // Agar profile incomplete hai to ye dikhao
    //         completeGuestProfileDialog(context);
    //       } else if (controller.isGuestUpdateReceived.value) {
    //         // Agar profile complete hai lekin koi update aayi hai to ye dikhao
    //         controller.isGuestUpdateReceived.value = false;
    //         guestUpdateReceived(context);
    //       }
    //     }
    //   }
    // });
    final showDialog = Get.arguments;

    // profileCompleted comes from the fetched profile (fetchMyProfile(),
    // kicked off unawaited at app boot), not the dead isProfileComplete flag
    // which was never assigned anywhere and always read as false. Since the
    // fetch may still be in flight when this runs, only act once we know
    // for sure it's false — re-checking via `ever` when the model arrives —
    // rather than showing the dialog on an unloaded/unknown state.
    //
    // hasCheckedProfile locks as soon as we get a definitive (non-null)
    // answer, whether or not the dialog gets shown — otherwise, when the
    // profile IS complete, the lock never engages and every later re-run of
    // this callback (e.g. a rebuild triggered by switching tabs) re-checks
    // from scratch, which is what made the dialog reappear on every tab
    // switch instead of at most once per app open.
    void maybeShowCompleteProfileDialog() {
      if (controller.hasCheckedProfile.value) return;
      final profileCompleted =
          controller.controller.getMyProfileModel.value?.data?.profileCompleted;
      if (profileCompleted == null) return; // not loaded yet, wait for `ever`
      controller.hasCheckedProfile.value = true;
      if (profileCompleted == false && context.mounted) {
        completeGuestProfileDialog(context);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      maybeShowCompleteProfileDialog();
      if (!controller.completeProfileWorkerRegistered) {
        controller.completeProfileWorkerRegistered = true;
        ever(controller.controller.getMyProfileModel, (_) => maybeShowCompleteProfileDialog());
      }
      if (showDialog == true && context.mounted) {
        completeGuestProfileDialog(context);
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
                      Get.toNamed("viewallinvitation");
                    },
                    child: homeIconWidget(
                      imagePath: "assets/png/icons/envelope.png",
                      iconsize: 17.5.sp
                    ),
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed("mynotificationscreen");
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
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           customText(
                          //             text: "Quick Report",
                          //             fontSize: 20.sp,
                          //             fontFamily: "CormorantGaramond",
                          //             fontWeight: FontWeight.w600,
                          //             color: blackColor,
                          //           ),
                          //           customText(
                          //             text:
                          //                 "Good vibes, great company, and a fantastic host.",
                          //             fontSize: 14.sp,
                          //             fontWeight: FontWeight.w400,
                          //             color: darkGreyColor,
                          //           ),
                          //           SizedBox(height: 1.5.h),
                          //
                          //           // Inside your Column > children, replace the Container block with this:
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                                        Obx(() {
                                          final selected = eventController.selectedDashboardCategory.value;
                                          final categories = eventController.dashboardCategories;
                                          return Container(
                                            width: 88.w,
                                            height: 4.5.h,
                                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30.sp),
                                              border: Border.all(color: const Color(0xFF5A7C79)),
                                              color: const Color(0xFFF6EEEB),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<String>(
                                                isExpanded: true,
                                                value: selected,
                                                iconStyleData: const IconStyleData(
                                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                                  iconSize: 24,
                                                ),
                                                dropdownStyleData: DropdownStyleData(
                                                  offset: const Offset(0, -7),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.sp),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                selectedItemBuilder: (context) => categories
                                                    .map((value) => Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: customText(
                                                            text: value,
                                                            fontSize: 15.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    eventController.selectedDashboardCategory.value = newValue;
                                                  }
                                                },
                                                items: categories.mapIndexed((index, value) {
                                                  final isLast = index == categories.length - 1;
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              customText(
                                                                text: value,
                                                                fontSize: 15.sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                              if (selected == value)
                                                                Icon(Icons.check, size: 18.sp),
                                                            ],
                                                          ),
                                                        ),
                                                        if (!isLast) Container(height: 1, color: Colors.grey[300]),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
                                        }),
                                        SizedBox(height: 2.h),
                                        // Selected category list (RSVP-style cards)
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                                          child: Obx(() {
                                            final category = eventController.selectedDashboardCategory.value;
                                            final isPast = category == EventController.dashHosted;
                                            // Past Events: every event hosted by the user whose date has
                                            // passed (full list from my-events, newest first).
                                            final List<Map<String, dynamic>> items;
                                            if (isPast) {
                                              final now = DateTime.now();
                                              final past = (eventController.myEventsModel.value?.data?.data ?? [])
                                                  .where((e) => e.eventTime.isBefore(now))
                                                  .toList()
                                                ..sort((a, b) => b.eventTime.compareTo(a.eventTime));
                                              items = past
                                                  .map((e) => <String, dynamic>{
                                                        '_id': e.id,
                                                        'image': e.image,
                                                        'eventName': e.eventName,
                                                        'numGuests': e.numGuests,
                                                        'estimatedGuests': e.estimatedGuests,
                                                        'dietaryCompatibilityScore': e.dietaryCompatibilityScore,
                                                      })
                                                  .toList();
                                            } else {
                                              items = eventController.dashboardItems[category] ?? const <Map<String, dynamic>>[];
                                            }
                                            final expanded = _pastExpanded.value;

                                            if (!isPast && eventController.isLoadingDashboard.value && items.isEmpty ||
                                                isPast && eventController.isLoadingMyEvents.value && items.isEmpty) {
                                              return Padding(
                                                padding: EdgeInsets.only(top: 4.h),
                                                child: Center(child: CircularProgressIndicator(color: greenColor)),
                                              );
                                            }
                                            if (items.isEmpty) {
                                              return Padding(
                                                padding: EdgeInsets.only(top: 4.h),
                                                child: Center(
                                                  child: customText(text: 'No ${category.toLowerCase()} found!', fontSize: 14.5.sp),
                                                ),
                                              );
                                            }
                                            final shown = (isPast && expanded) || items.length <= 4 ? items.length : 4;
                                            return Column(children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              itemCount: shown,
                                              itemBuilder: (context, index) {
                                                // Pending invitations may wrap the event under an "event" key.
                                                final raw = items[index];
                                                final e = raw['event'] is Map
                                                    ? Map<String, dynamic>.from(raw['event'])
                                                    : raw;
                                                final guests = (e['numGuests'] as num?)?.toInt() ?? 0;
                                                final estimated = (e['estimatedGuests'] as num?)?.toInt() ?? 0;
                                                final score = (e['dietaryCompatibilityScore'] as num?)?.toDouble() ?? 0;
                                                final eventId = (e['_id'] ?? e['id'] ?? '').toString();
                                                return adminHomeWidget(
                                                  imagePath: e['image']?.toString(),
                                                  eventname: e['eventName']?.toString(),
                                                  confirmedamount: "$guests Guest Confirmed",
                                                  value: score / 100,
                                                  estimatedGuest: estimated.toString(),
                                                  joinedGuest: guests.toString(),
                                                  ontap: eventId.isEmpty
                                                      ? null
                                                      : () => Get.toNamed("eventdetailsscreen", arguments: eventId),
                                                );
                                              },
                                            ),
                                            SizedBox(height: 1.h),
                                            if (!isPast || items.length > 4)
                                            InkWell(
                                              onTap: () {
                                                if (category == EventController.dashPending) {
                                                  Get.toNamed("viewallinvitation");
                                                } else if (isPast) {
                                                  // Past -> expand/collapse in place
                                                  _pastExpanded.value = !_pastExpanded.value;
                                                } else {
                                                  // Upcoming -> Events tab
                                                  controller.changePage(1);
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  customText(
                                                    text: isPast && expanded ? "View Less" : "View All",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: blackColor,
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  Icon(
                                                    isPast
                                                        ? (expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
                                                        : Icons.arrow_forward,
                                                    color: blackColor,
                                                    size: 16.sp,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ]);
                                          }),
                                        ),

                                        SizedBox(height: 3.h),

                                        // Invitations
                                        Padding(
                                          key: _rsvpKey,
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
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                          child: Obx(() {
                                            // Only upcoming events: drop anything whose date has passed.
                                            final now = DateTime.now();
                                            final eventData = eventController.myEventsModel.value?.data?.data
                                                .where((e) => e.eventTime.isAfter(now))
                                                .toList();

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
                                                  itemCount: _rsvpVisible.value < eventData.length ? _rsvpVisible.value : eventData.length,
                                                  itemBuilder: (context, index) {
                                                    final data = eventData[index];
                                                    return adminHomeWidget(
                                                      imagePath: data?.image,
                                                      eventname: data?.eventName,
                                                      confirmedamount: "${data.numGuests} Guest Confirmed",
                                                      value: (data.dietaryCompatibilityScore.toDouble()/100),
                                                      estimatedGuest: data.estimatedGuests.toString(),
                                                      joinedGuest: data.numGuests.toString(),
                                                      ontap: () {
                                                        Get.toNamed("eventdetailsscreen", arguments: data?.id);
                                                      },
                                                    );
                                                  },
                                                ),

                                                SizedBox(height: 2.h),

                                                // View More Button: reveals 10 more at a time
                                                if (_rsvpVisible.value < eventData.length ||
                                                    eventController.myEventsCurrentPage.value < eventController.myEventsTotalPages.value)
                                                  ElevatedButton(
                                                    onPressed: eventController.isLoadingMoreMyEvents.value
                                                        ? null
                                                        : () async {
                                                            _rsvpVisible.value += 10;
                                                            // Fetch another page only if we've run out of loaded events.
                                                            if (_rsvpVisible.value > eventData.length &&
                                                                eventController.myEventsCurrentPage.value < eventController.myEventsTotalPages.value) {
                                                              await eventController.getMyEvents(loadMore: true);
                                                            }
                                                          },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: greenColor,
                                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                                                    ),
                                                    child: eventController.isLoadingMoreMyEvents.value
                                                        ? SizedBox(
                                                      height: 2.h,
                                                      width: 2.h,
                                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                                    )
                                                        : customText(text: "View More", color: Colors.white, fontSize: 14.sp),
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
    String? imagePath,
    String? eventname,
    String? confirmedamount,
    String? progress,
    double? value,
    String? estimatedGuest,
    String? joinedGuest,
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
                  child: imagePath == null || imagePath!.isEmpty
                      ? Image.asset(
                    "assets/png/admin_home_foodpic.png",
                    height: 7.h,
                    width: 15.w,
                    fit: BoxFit.cover,
                  )
                      : CachedNetworkImage(
                    imageUrl: "${baseService.baseURL}$imagePath",
                    height: 7.h,
                    width: 15.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 7.h,
                        width: 15.w,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        "assets/png/admin_home_foodpic.png",
                        height: 7.h,
                        width: 15.w,
                        fit: BoxFit.cover,
                      );
                    },
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
                          // customText(
                          //   text: "(Confirmed Guests: ${joinedGuest ?? 0})",
                          //   fontSize: 14.sp,
                          //   fontWeight: FontWeight.w400,
                          //   color: blackColor,
                          // ),
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
