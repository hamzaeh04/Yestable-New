import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/core/services/firebase_messaging/messaging_service.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/custom_image_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart'; // customText
import '../../../widget/home_screen_widget.dart'; // homeIconWidget

class ChatGroupSetting extends StatelessWidget {
  ChatGroupSetting({super.key});
  final ProfileController controller = ProfileController();
  final EventController eventController = Get.find<EventController>();
  final NavigationController navigationController = Get.find<NavigationController>();
  final MessagingService messagingService = MessagingService();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final membersCount = args["membersCount"];
    final groupName = args["groupName"];
    final imagePath = args["imagePath"];
    final groupId = args["groupId"];
    final invitationMsg = args["invitationMsg"];
    final adminId = args["adminId"];
    final isGroupEnable = args["isGroupEnable"];
    navigationController.isHost.value = (navigationController.returnUserId() == adminId);

    WidgetsBinding.instance.addPostFrameCallback((_){
      eventController.listenGroupStatus(groupId);
    });
    return Scaffold(
      backgroundColor: greenColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // Top App Bar Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                children: [
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    color: lightgreenColor,
                    iconsize: 16.sp,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 2.w),
                  customText(
                    text: "Group Info",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Bottom half scrollable content
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 3.h),

                      // Group Profile Picture
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.sp),
                          child: Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              "${baseService.baseURL}$imagePath",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.group,
                                    size: 8.h,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      // Group Name
                      Center(
                        child: customText(
                            text: groupName,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "CormorantGaramond"
                        ),
                      ),
                      Center(
                        child: customText(
                          text: "${membersCount} Group Members",
                          fontSize: 15.sp,
                          color: darkGreyColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: customText(
                          text: "${invitationMsg}",
                          fontSize: 15.sp,
                          color: darkGreyColor,
                        ),
                      ),
                      SizedBox(height: 3.h),

                      // Members Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text: "${membersCount} Members",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "CormorantGaramond"
                            ),
                            // Image.asset("assets/png/icons/group_info_search_icon.png",height: 2.h,
                            //   width: 2.5.h,)
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('group')
                                .doc(groupId)
                                .collection('members')
                                .orderBy('joinedAt')
                                .snapshots(),
                            builder: (context, snapshot) {

                              /// LOADING
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              /// NO MEMBERS
                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2.h),
                                    child: customText(
                                      text: "No Members Found",
                                    ),
                                  ),
                                );
                              }

                              final members = snapshot.data!.docs;

                              return Column(
                                children: List.generate(
                                  members.length,
                                      (index) {

                                    final member =
                                    members[index].data() as Map<String, dynamic>;
                                    return Column(
                                      children: [

                                        _buildInfoRow(
                                          member["userName"] ?? "",
                                          imagePath: "assets/png/chat_images/user1.png",
                                          isHost: member["userId"] == adminId,
                                        ),

                                        if (index != members.length - 1)
                                          const Divider(height: 1),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          )

                        ),
                      ),


                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Obx(()=>
                            navigationController.isUser.value == false && navigationController.isHost.value == true ?
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 4.w, top: 0.5.h, bottom: 0.5.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            customText(
                                              text: "Enable Group Conversation",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: blueColor,
                                            ),
                                            Transform.scale(
                                              scale: 8.w / 50,
                                              child: Obx(
                                                    () => CupertinoSwitch(
                                                  activeTrackColor: blackColor,
                                                  value: eventController.switchValue3.value,
                                                  onChanged: (val) async {
                                                    // Optimistic update
                                                    eventController.switchValue3.value = val;
                                                    try {
                                                      await messagingService.updateEnableChat(
                                                        enableChat: val,
                                                        groupId: groupId,
                                                      );
                                                    } catch (e) {
                                                      // Revert on error
                                                      eventController.switchValue3.value = !val;
                                                      Get.snackbar(
                                                        "Error",
                                                        "Failed to update group setting: ${e.toString()}",
                                                        snackPosition: SnackPosition.BOTTOM,
                                                      );
                                                    }
                                                  },
                                                ),
                                              )
                                            ),
                                          ],
                                        )
                                    ),
                                    const Divider(height: 1),
                                  ],
                                ):SizedBox.shrink(),
                          ),
                               // Keeps it tight
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
                                child: customText(
                                  text: "Mute Group",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: blueColor,
                                ),
                              ),
                              const Divider(height: 1), // Keeps it tight
                              InkWell(
                                onTap: () async {
                                  if(navigationController.isHost.value == true){
                                    await messagingService.exitGroup(groupId: groupId, userId: navigationController.returnUserId());
                                    await messagingService.deledeGroup(groupId: groupId);
                                    Get.back();
                                    Get.back();
                                  }

                                  else{
                                    await messagingService.exitGroup(groupId: groupId, userId: navigationController.returnUserId());
                                    Get.back();
                                    Get.back();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
                                  child: customText(
                                    text: "Exit Group",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: redColor,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info cards like "Media, Mute, Exit"
  Widget _buildInfoCard(BuildContext context, {
    required String imgPath,// You can ignore if not using IconData anymore
    required String text,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h, // You can adjust the height here
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              height: 2.5.h,
              width: 2.5.h,
            ),
            SizedBox(width: 3.w),
            customText(
              text: text,
              fontSize: 15.sp,
              color: textColor ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(String text, {
    String? imagePath,
    Color? textColor,
    bool isHost = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath,
                  height: 3.h,
                  width: 3.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 3.w),
              ],
              customText(
                text: text,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.black87,
              ),
            ],
          ),
          if (isHost)
            customText(
              text: "Host",
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: darkGreyColor,
            ),
        ],
      ),
    );
  }

}
