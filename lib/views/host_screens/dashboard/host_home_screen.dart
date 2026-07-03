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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isProfileComplete.value && !controller.hasCheckedProfile.value) {
        controller.hasCheckedProfile.value = true;
        completeGuestProfileDialog(context);
      }
      if(showDialog == true){
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
                  // InkWell(
                  //   onTap: () {
                  //     // controller.goTSearchScreen();
                  //   },
                  //   child: homeIconWidget(
                  //     imagePath: "assets/png/icons/search_icon.png",
                  //   ),
                  // ),
                  // SizedBox(width: 2.w),
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
                                          "Good vibes, great company, and a fantastic host.",
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
                                          () {
                                            final eventData = eventController.myEventsModel.value?.data?.data ?? [];
                                            final dropdownItems = eventData.map((e) => e.eventName ?? '').where((name) => name.isNotEmpty).toList();
                                            final selectedValue = controller.selectedEvent.value;
                                            final hasSelectedValue = dropdownItems.contains(selectedValue);

                                            return Container(
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
                                                  value: (selectedValue.isEmpty || !hasSelectedValue)
                                                      ? null
                                                      : selectedValue,

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
                                                    return dropdownItems.map((
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

                                                      // Find the selected event ID from eventData matching the selected eventName
                                                      final selectedEventObj = eventData.firstWhereOrNull(
                                                        (e) => e?.eventName == newValue,
                                                      );

                                                      if (selectedEventObj != null && selectedEventObj.id != null) {
                                                        final String eventId = selectedEventObj.id!;
                                                        debugPrint("Selected Event ID: $eventId");

                                                         // TODO: Hit your API here using the eventId
                                                         eventController.getAllAllergenList(eventId: eventId);
                                                         eventController.getEventAllergens(eventId: eventId);
                                                        // e.g., eventController.fetchEventDetails(eventId);
                                                      }
                                                    }
                                                  },

                                                  // ✅ Dropdown list with check and dividers
                                                  items:
                                                      dropdownItems.mapIndexed((
                                                        index,
                                                        value,
                                                      ) {
                                                        final isLast =
                                                            index ==
                                                            dropdownItems
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
                                            );
                                          }
                                        ),
                                        SizedBox(height: 2.h),
                                        // Calendar Image
                                        Obx(
                                          () {
                                            final eventData = eventController.myEventsModel.value?.data?.data ?? [];
                                            final dropdownItems = eventData.map((e) => e.eventName ?? '').where((name) => name.isNotEmpty).toList();
                                            final isEventSelected = controller.selectedEvent.value.isNotEmpty && dropdownItems.contains(controller.selectedEvent.value);

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
                                              child: isEventSelected
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
                                                                  final allergenData = eventController.getAllergenList.value?.data?.allergens ?? [];
                                                                  
                                                                  final Map<String, Color> allergenColors = {
                                                                    "tree nuts": const Color(0xFF7E00F5),
                                                                    "peanuts": const Color(0xFFFF5B00),
                                                                    "sesame": const Color(0xFF8A959E),
                                                                    "dairy": const Color(0xFFE1C500),
                                                                    "gluten": const Color(0xFF39D300),
                                                                    "shellfish": const Color(0xFFE19B00),
                                                                    "eggs": const Color(0xFF00B58D),
                                                                  };

                                                                  final targetLabels = [
                                                                    "Tree Nuts",
                                                                    "Peanuts",
                                                                    "Sesame",
                                                                    "Dairy",
                                                                    "Gluten",
                                                                    "Shellfish",
                                                                    "Eggs"
                                                                  ];

                                                                  final Map<String, int> apiCounts = {};
                                                                  for (var e in allergenData) {
                                                                    if (e.label != null) {
                                                                      apiCounts[e.label!.toLowerCase().trim()] = e.count ?? 0;
                                                                    }
                                                                  }

                                                                  int highestCount = 0;
                                                                  for (final label in targetLabels) {
                                                                    final count = apiCounts[label.toLowerCase()] ?? 0;
                                                                    if (count > highestCount) {
                                                                      highestCount = count;
                                                                    }
                                                                  }

                                                                  final dynamicList = targetLabels.map((label) {
                                                                    final count = apiCounts[label.toLowerCase()] ?? 0;
                                                                    final color = allergenColors[label.toLowerCase()] ?? const Color(0xFF8A959E);
                                                                    final double chartValue = count == 0 ? 1.2 : count.toDouble();
                                                                    return {
                                                                      "label": label,
                                                                      "value": chartValue,
                                                                      "color": color,
                                                                      "valueText": count.toString().padLeft(2, '0'),
                                                                      "showAlert": highestCount > 0 && count == highestCount,
                                                                    };
                                                                  }).toList();

                                                                  if (eventController.isLoadingAllerganList.value) {
                                                                    return SizedBox(
                                                                      height: 15.h,
                                                                      child: Center(
                                                                        child: CircularProgressIndicator(color: greenColor),
                                                                      ),
                                                                    );
                                                                  }

                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 1.h,
                                                                      ),
                                                                      // SizedBox(
                                                                      //   height: 1.h,
                                                                      // ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          controller.toggleShowAllergicGuest();
                                                                        },
                                                                        child: CommonAllergensChart(
                                                                          allergensList: dynamicList,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                case 1:
                                                                  final allergenData1 = eventController.getAllergenList.value?.data?.allergens ?? [];
                                                                  final totalAllergens = eventController.getAllergenList.value?.data?.totalAllergens ?? 0;
                                                                  
                                                                  final Map<String, Color> allergenColors1 = {
                                                                    "soya": const Color(0xFFADF802),
                                                                    "soy": const Color(0xFFADF802),
                                                                    "peanuts": const Color(0xFFFF5B00),
                                                                    "dairy": const Color(0xFF8A959E),
                                                                    "gluten": const Color(0xFF39D300),
                                                                    "shellfish": const Color(0xFFE19B00),
                                                                    "eggs": const Color(0xFF00B58D),
                                                                  };

                                                                  final targetLabels1 = [
                                                                    "Soya",
                                                                    "Peanuts",
                                                                    "Dairy",
                                                                    "Gluten",
                                                                    "Shellfish",
                                                                    "Eggs"
                                                                  ];

                                                                  final Map<String, int> apiCounts1 = {};
                                                                  for (var e in allergenData1) {
                                                                    if (e.label != null) {
                                                                      apiCounts1[e.label!.toLowerCase().trim()] = e.count ?? 0;
                                                                    }
                                                                  }

                                                                  int highestCount1 = 0;
                                                                  for (final label in targetLabels1) {
                                                                    final count = label.toLowerCase() == "soya"
                                                                        ? (apiCounts1["soy"] ?? apiCounts1["soya"] ?? 0)
                                                                        : (apiCounts1[label.toLowerCase()] ?? 0);
                                                                    if (count > highestCount1) {
                                                                      highestCount1 = count;
                                                                    }
                                                                  }

                                                                  final dynamicList1 = targetLabels1.map((label) {
                                                                    final count = label.toLowerCase() == "soya"
                                                                        ? (apiCounts1["soy"] ?? apiCounts1["soya"] ?? 0)
                                                                        : (apiCounts1[label.toLowerCase()] ?? 0);
                                                                    final color = allergenColors1[label.toLowerCase()] ?? const Color(0xFF8A959E);
                                                                    final double chartValue = count == 0 ? 1.2 : count.toDouble();
                                                                    return {
                                                                      "label": label,
                                                                      "value": chartValue,
                                                                      "color": color,
                                                                      "valueText": count.toString().padLeft(2, '0'),
                                                                      "showAlert": highestCount1 > 0 && count == highestCount1,
                                                                    };
                                                                  }).toList();

                                                                  if (eventController.isLoadingAllerganList.value) {
                                                                    return SizedBox(
                                                                      height: 15.h,
                                                                      child: Center(
                                                                        child: CircularProgressIndicator(color: greenColor),
                                                                      ),
                                                                    );
                                                                  }

                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 1.h,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Get.toNamed(
                                                                            "newguestlistscreen",
                                                                          );
                                                                        },
                                                                        child: CommonAllergensChart(
                                                                          allergensList: dynamicList1,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                case 2:
                                                                  final allergenData2 = eventController.getEventAllergenData.value?.data?.allergens ?? [];
                                                                  
                                                                  final targetLabels2 = [
                                                                    "Tree Nuts",
                                                                    "Peanuts",
                                                                    "Sesame",
                                                                    "Dairy",
                                                                    "Gluten",
                                                                    "Shellfish",
                                                                    "Eggs"
                                                                  ];

                                                                  final dynamicList2 = targetLabels2.map((label) {
                                                                    final allergen = allergenData2.firstWhereOrNull(
                                                                      (e) => e.label?.toLowerCase().trim() == label.toLowerCase().trim(),
                                                                    );
                                                                    
                                                                    final int mild = allergen?.mild ?? 0;
                                                                    final int avoid = allergen?.avoid ?? 0;
                                                                    final int severe = allergen?.severe ?? 0;

                                                                    final double mildVal = mild == 0 ? 1.2 : mild.toDouble();
                                                                    final double avoidVal = avoid == 0 ? 1.2 : avoid.toDouble();
                                                                    final double severeVal = severe == 0 ? 1.2 : severe.toDouble();

                                                                    return {
                                                                      "label": label,
                                                                      "rods": [
                                                                        {
                                                                          "value": mildVal,
                                                                          "color": const Color(0xFF39D300), // green
                                                                          "valueText": mild.toString().padLeft(2, '0'),
                                                                          "showAlert": false,
                                                                        },
                                                                        {
                                                                          "value": severeVal,
                                                                          "color": const Color(0xFFFFD600), // yellow
                                                                          "valueText": severe.toString().padLeft(2, '0'),
                                                                          "showAlert": false,
                                                                        },
                                                                        {
                                                                          "value": avoidVal,
                                                                          "color": const Color(0xFFDE5959), // red
                                                                          "valueText": avoid.toString().padLeft(2, '0'),
                                                                          "showAlert": false,
                                                                        },
                                                                      ],
                                                                    };
                                                                  }).toList();

                                                                  if (eventController.isLoadingEventAllergens.value) {
                                                                    return SizedBox(
                                                                      height: 15.h,
                                                                      child: Center(
                                                                        child: CircularProgressIndicator(color: greenColor),
                                                                      ),
                                                                    );
                                                                  }

                                                                  return Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 1.h,
                                                                      ),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          controller.toggleShowAllergicGuest();
                                                                        },
                                                                        child: CommonAllergensChart(
                                                                          allergensList: dynamicList2,
                                                                          isGrouped: true,
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 2.h),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 2.5.w,
                                                                                height: 2.5.w,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0xFFDE5959), // Red
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 1.5.w),
                                                                              customText(
                                                                                text: "Avoid",
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: blackColor,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(width: 4.w),
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 2.5.w,
                                                                                height: 2.5.w,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0xFFFFD600), // Yellow
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 1.5.w),
                                                                              customText(
                                                                                text: "Severe",
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: blackColor,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(width: 4.w),
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 2.5.w,
                                                                                height: 2.5.w,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0xFF39D300), // Green
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 1.5.w),
                                                                              customText(
                                                                                text: "Mild",
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: blackColor,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
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
                                            );
                                          }
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
                                                    print(data.dietaryCompatibilityScore);
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
                          customText(
                            text: "(${joinedGuest ?? 0}/${estimatedGuest ?? 0})",
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
