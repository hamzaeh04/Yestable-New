import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/utils/shared_prefrences_methods.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/event_controller.dart';
import '../core/services/firebase_messaging/messaging_service.dart';
import '../outh_file/local_db_key.dart';

void guestUpdateReceived(BuildContext context, {required bool success, required String eventId, required ProfileController controller}) {
  final prefs = SharedPreferencesMethod.storage;
  final MessagingService messagingService = MessagingService();
  final EventController eventController = Get.find<EventController>();
  final NavigationController navigationController = Get.find<NavigationController>();
  final data = eventController.getEventByIdModel.value?.data;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Centered icon
            Center(
              child: Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  color: containerBlueColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "assets/png/you_are_invited_bellicon.png",
                    width: 11.w,
                    height: 11.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// Centered heading
            Center(
              child: customText(
                text: "Event Invitation Received",
                fontWeight: FontWeight.w600,
                fontSize: 19.25.sp,
                fontFamily: "CormorantGaramond",
              ),
            ),

            SizedBox(height: 2.h), // 👈 extra padding after heading

            /// Left-aligned content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: data?.host?.name ?? "Someone",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        fontFamily: "WorkSans",
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: "has invited you to join their event.",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: "WorkSans",
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "Event Details:",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                    color: greenColor
                  ),
                  customText(
                    text: "Event Name: ${data?.eventName}",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  customText(
                    text: "Time: ${navigationController.formatTime2(data?.eventTime)} - ${navigationController.formatDate2(data?.eventTime)}",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  SizedBox(height: 2.h),
                  customText(
                    text: "These updates may include dietary preferences, allergies, or contact info.",
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(child: buttonWidget("Join", whiteColor,colors: greenColor,fontsize: 15.sp,height: 4.5.h, onTap: () async {
                        if (!success) return;

                        final response = await eventController.eventJoin(eventId);
                        if (response == null || response["success"] != true) return;

                        final userName = prefs.getString(LocalDBKeys.USERFULLNAME);
                        final userId = prefs.getString(LocalDBKeys.USERID);
                        await messagingService.joinGroup(groupId: eventId, userName: userName.toString(), userId: userId.toString(),memberProfile: controller.getMyProfileModel.value?.data?.profilePic ?? '');

                        final String message = response["message"] ?? "Joined event successfully";

                        Get.back();

                        showDialog(
                          context: Get.context!,
                          builder: (_) {
                            return Dialog(
                              backgroundColor: backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 50,
                                      color: Colors.green,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Success",
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    SizedBox(height: 10),
                                    Text(message, textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      })),
                      SizedBox(width: 4.w),
                      Expanded(child: buttonWidget("Dismiss", greenColor,colors: backgroundColor,borderColor: greenColor,fontsize: 15.sp,height: 4.5.h,onTap: () async {
                        await eventController.ignoreEventLink(eventId);
                        Get.back();
                      }))

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


