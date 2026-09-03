import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/floating_home_button.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';

class EventComfortThree extends StatelessWidget {
  EventComfortThree({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final eventId = Get.arguments;

    // Pre-fill mayGuestsContact (index 14) and displayMenu in edit mode.
    // Only pre-fill from the fetched data if the user hasn't already made a
    // choice on this screen this session — otherwise re-visiting this route
    // (e.g. tap Yes -> go back -> come forward again) re-runs this callback
    // and stomps the user's tap back to the value that was on the server
    // *before* this edit session started, since getEventByIdModel is fetched
    // once at the start of the edit flow and isn't refreshed mid-flow.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = eventController.getEventByIdModel?.value?.data;
      if (eventId != null) {
        if (data?.guestAware?.guestContact != null) {
          eventController.profileController.selectedOptions[14] =
              data!.guestAware!.guestContact == true ? "yes": "no";
        }
        controller.isSelected.value = data?.displayMenu ?? false;
      }
    });

    return floatingHomeButton(
      screen: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              child: Image.asset(
                "assets/png/new_guest_illustrations/event_comfort_three.png",
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
                  loadingStepIndicator("3/3", 0.90),
                  backButton(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: customText(
                    text:
                        "3. May guests contact you about dietary or access concerns",
                    fontFamily: "CormorantGaramond",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                yesNoWidget(14),
                SizedBox(height: 1.h),
                Divider(thickness: 1, color: Colors.grey.shade400, height: 3.h),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customText(
                          text:
                              "Display Menu Items on the Event\nScreen for Guest Preview.",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => CupertinoSwitch(
                              value: controller.isSelected.value,
                              activeTrackColor: Colors.black,
                              onChanged: (value) {
                                controller.isSelected.value = value;
                              },
                            ),
                          ),
                        ],
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

                      eventController.updateGuestAwareMethod(eventId, context: context);
                      print(eventId);
                      // Get.toNamed("eventpublishscreen");
                    },
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
Future<void> publishDialog(BuildContext context, String eventId) async {
  final EventController eventController = Get.find<EventController>();

  final targetContext = context.mounted ? context : Get.context;
  if (targetContext == null) return;

  await showDialog(
    context: targetContext,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 3.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customText(
                text: "Publish Event",
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(height: 1.h),

              customText(
                text: "Are you sure you want to publish this event?",
                fontSize: 15.5.sp,
                textAlign: TextAlign.center,
                color: darkGreyColor,
                height: 1
              ),

              SizedBox(height: 3.h),

              buttonWidget(
                "Publish Event",
                whiteColor,
                colors: greenColor,
                onTap: () {
                  Get.back();

                  // Call publish API here
                  final publishContext = context.mounted ? context : Get.context;
                  eventController.publishEvent(eventId, publishContext);
                },
              ),

              SizedBox(height: 0.75.h),

              buttonWidget(
                "Not Now",
                greenColor,
                borderColor: greenColor,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}