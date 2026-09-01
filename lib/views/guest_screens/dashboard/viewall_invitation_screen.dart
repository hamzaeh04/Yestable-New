import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/home_screen_widget.dart';
import 'package:yestable/widget/floating_home_button.dart';
import 'user_home_screen.dart';

class ViewallInvitationScreen extends StatefulWidget {
  const ViewallInvitationScreen({super.key});

  @override
  State<ViewallInvitationScreen> createState() => _ViewallInvitationScreenState();
}

class _ViewallInvitationScreenState extends State<ViewallInvitationScreen> {
  final NavigationController controller = Get.find<NavigationController>();
  final EventController eventController = Get.find<EventController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventController.getPendingInvitations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return floatingHomeButton(
      screen: Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SizedBox(height: 6.h,),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    iconsize: 16.sp,
                    onTap: () => Get.back()
                  ),
                  SizedBox(width: 4.w),
                  customText(
                    text: "Invitations",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
          SizedBox(height: 3.h),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp),
              ),
              child: Container(
                width: double.infinity,
                color: backgroundColor,
                child: Obx(() {
                  final invitations = eventController.pendingInvitationModel.value?.data ?? [];

                  if (eventController.isLoadingPendingInvitations.value && invitations.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: greenColor));
                  }

                  if (invitations.isEmpty) {
                    return Center(
                      child: customText(
                        text: "No pending invitations",
                        fontSize: 15.sp,
                        color: darkGreyColor,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: invitations.map((invitation) {
                        final event = invitation.event;
                        final invite = invitation;

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: invitationWidget(
                            event?.eventName ?? "Event",
                            event?.eventTime != null ? controller.formatTime(event!.eventTime!) : "",
                            event?.address,
                            event?.eventTime != null ? controller.formatDate(event!.eventTime!) : "",
                            event?.image,
                            event?.dietaryCompatibilityScore as int?,
                            invite?.invitedBy?.profilePic,
                            invitedByName: invitation.invitedBy?.name,
                            onAccept: () {
                              if (invitation.id == null) return;
                              eventController.respondToInvitation(invitation.id!, "accepted");
                            },
                            onReject: () {
                              if (invitation.id == null) return;
                              eventController.respondToInvitation(invitation.id!, "rejected");
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

}
