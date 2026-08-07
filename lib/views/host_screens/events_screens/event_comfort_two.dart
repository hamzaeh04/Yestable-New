import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/event_controller.dart';

class EventComfortTwo extends StatelessWidget {
  EventComfortTwo({super.key});

  final EventController controller = Get.find<EventController>();

  final List<String> checkList = [
    "Pets Will Present",
    "Children Will Be Present",
    "Event Is Adults-Only",
    "Event May Have Smoke Present",
    "Event Is Smoke-Free",
    "Alcohol Will Be Present",
    "This Is An Alcohol-Free Event",
    "There Are Steps To Climb",
    "Swimming Pool Is Present",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Peanuts Will Be Served",
    "The Event Ends At A Firm time",
  ];

  @override
  Widget build(BuildContext context) {
    final eventId = Get.arguments;

    // Pre-fill Yes/No selections for guestAware when entering in edit mode.
    // Runs every time build is called so back-navigation also restores values.
    // NOTE: selectedOptions indices 1-13 are reused for guestAware (after
    // EventComfortOne clears them on submit). Index 9 is the pool widget.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (eventId != null) {
        final data = controller.getEventByIdModel.value?.data;
        final guestAware = data?.guestAware;
        void setOpt(bool? value, int index) {
          if (value == null) return;
          controller.profileController.selectedOptions[index] = value ? 'yes' : 'no';
        }
        setOpt(guestAware?.petsPresent,     1);
        setOpt(guestAware?.childrenPresent, 2);
        setOpt(guestAware?.forAdultOnly,    3);
        setOpt(guestAware?.smokePresent,    4);
        setOpt(guestAware?.smokeFree,       5);
        setOpt(guestAware?.alcohol,         6);
        setOpt(guestAware?.alcoholFree,     7);
        setOpt(guestAware?.stepsToClimb,    8);
        // index 9 is swimming pool — handled via controller.poolSelection
        setOpt(guestAware?.fireArms,        10);
        setOpt(guestAware?.shellFish,       11);
        setOpt(guestAware?.peanuts,         12);
        setOpt(guestAware?.endsInFirmTime,  13);
        
        controller.itemContainingController.text = guestAware?.itemContaining ?? "";
        controller.guestAwareOthersController.text = guestAware?.others ?? "";
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              child: Image.asset(
                "assets/png/new_guest_illustrations/event_comfort_two.png",
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  loadingStepIndicator("2/3", 0.70),
                  backButton(),
                  SizedBox(height: 1.h),
                  customText(
                    text:
                        "2. Make your guests aware of (check all that apply).",
                    fontFamily: "CormorantGaramond",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            SizedBox(height: 1.5.h),

            /// ✅ Checklist
            ListView.builder(
              itemCount: checkList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // ✅ Agar index 8 hai to yesNoWidget nahi, sirf container
                    if (index == 8)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 0.h,
                        ),
                        // padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4ECE6),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Swimming Pool",
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                            SizedBox(height: 1.5.h),
                            Obx(
                              () => selectablePill(
                                text: "Pool Or Body Of Water Is Present",
                                isSelected:
                                    controller.poolSelection.value ==
                                    'pool_present',
                                onTap:
                                    () =>
                                        controller.poolSelection.value =
                                            'pool_present',
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Obx(
                              () => selectablePill(
                                text: "Non-Swimming Event",
                                isSelected:
                                    controller.poolSelection.value ==
                                    'non_swimming',
                                onTap: () {
                                  controller.poolSelection.value =
                                      'non_swimming';
                                  controller.guestsWelcomeToSwim.value =
                                      false; // Reset sub-option
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            customText(
                              text: "Optional",
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                            SizedBox(height: 1.h),
                            Obx(
                                  () => selectableOption(
                                text: "Guests Are Welcome To Swim",
                                isSelected: controller.guestsWelcomeToSwim.value,
                                onTap: () {
                                  controller.guestsWelcomeToSwim.value =
                                  !controller.guestsWelcomeToSwim.value;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      yesNoWidget(
                        title: checkList[index],
                        index + 1,
                      ), // baki sab normal

                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade400,
                      height: 3.h,
                    ),
                  ],
                );
              },
            ),

            /// Others
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Please Dont Bring Item Containing",
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextField(
                        controller: controller.itemContainingController,
                        decoration: InputDecoration(
                          hintText: "Type Here",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: "WorkSans",
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Divider(),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Others",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      TextField(
                        controller: controller.guestAwareOthersController,
                        decoration: InputDecoration(
                          hintText: "Type Here",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: "WorkSans",
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: buttonWidget(
                    "Continue",
                    whiteColor,
                    colors: greenColor,
                    onTap: () async {
                      // await controller.updateGuestAwareMethod(eventId);
                      Get.toNamed("eventcomfortthree", arguments: eventId);
                      print(eventId);
                    },
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectablePill({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2F4F4F) : Colors.transparent,
        borderRadius: BorderRadius.circular(30.sp),
        border: isSelected ? null : Border.all(color: greyBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 20.sp,
            width: 20.sp,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected ? null : Border.all(color: greyBorderColor),
            ),
            child: Icon(
              Icons.check,
              size: 16.sp,
              color: isSelected ? greenColor : Colors.transparent,
            ),
          ),
          SizedBox(width: 2.w),
          customText(
            text: text,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ],
      ),
    ),
  );
}

Widget selectableOption({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 22.sp,
          width: 22.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? greenColor : Colors.transparent,
            border: Border.all(color: greyBorderColor),
          ),
          child: Icon(
            Icons.check,
            size: 16.sp,
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ),
      ),
      SizedBox(width: 3.w),
      customText(text: text, fontSize: 14.sp, fontWeight: FontWeight.w400),
    ],
  );
}
