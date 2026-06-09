import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/core/services/firebase_messaging/messaging_service.dart';
import 'package:yestable/outh_file/local_db_key.dart';
import 'package:yestable/widget/custom_image_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/home_screen_widget.dart';

class ChatMessageScreen extends StatefulWidget {
  ChatMessageScreen({super.key});

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final NavigationController controller = Get.find<NavigationController>();
  final MessagingService messagingService = MessagingService();
  final prefs = SharedPreferencesMethod.storage;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final membersCount = args["membersCount"];
    final groupName = args["groupName"];
    final imagePath = args["imagePath"];
    final groupId = args["groupId"];
    final invitationMsg = args["invitationMsg"];
    final adminId = args["adminId"];
    final isGroupEnabled = args["isGroupEnable"];
    return Scaffold(
      backgroundColor: greenColor,
      resizeToAvoidBottomInset: true, // Important for keyboard handling
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  SizedBox(width: 3.w),
                  InkWell(
                    onTap: (){
                      Get.toNamed("chatgroupsetting",arguments: {
                        "membersCount": membersCount,
                        "groupName": groupName,
                        "imagePath": imagePath,
                        "groupId": groupId,
                        "invitationMsg" : invitationMsg,
                        "adminId":adminId,
                        "isGroupEnable": isGroupEnabled
                      });

                    },
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp), // adjust as needed
                              child: imagePath != null && imagePath.isNotEmpty
                                  ? Image.network(
                                "${baseService.baseURL}$imagePath",
                                height: 6.h,
                                width: 14.w,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                "assets/png/chat_images/chat_msg_image.png",
                                height: 6.h,
                                width: 15.w,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              right: 0.w,
                              bottom: 0.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: SizedBox(
                                  height: 2.h,
                                  width: 5.w,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        "assets/png/girl_profile.png",
                                        fit: BoxFit.cover,
                                      ),
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 3,
                                          sigmaY: 3,
                                        ),
                                        child: Container(
                                          color: Colors.black26.withOpacity(0.25),
                                          child: Center(
                                            child: customText(
                                              text: membersCount,
                                              color: whiteColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.4.w,
                                            color: greenColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 3.w),

                        /// FIX OVERFLOW
                        SizedBox(
                          width: 60.w,
                          child: customText(
                            text: groupName ?? "Gizelle Dinner Event",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                            fontFamily: "CormorantGaramond",
                            overFlow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Scrollable bottom half with pinned input bar
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
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/png/chat_images/chat_background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Messages scroll area with bottom padding for input bar
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           SizedBox(height: 4.h),
                              //           Container(
                              //             padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                              //             decoration: BoxDecoration(
                              //               color: blueColor,
                              //               borderRadius: BorderRadius.only(
                              //                 topLeft: Radius.circular(10),
                              //                 bottomLeft: Radius.circular(10),
                              //                 bottomRight: Radius.circular(10),
                              //               ),
                              //             ),
                              //             child: customText(
                              //               text:
                              //               "The dessert menu shows tiramisu\n(has dairy). Could we add a nut-free\nsorbet? I’ll bring some if it’s easier!",
                              //               fontSize: 15.5.sp,
                              //               fontWeight: FontWeight.w400,
                              //               color: Colors.white,
                              //             ),
                              //           ),
                              //           SizedBox(height: 0.5.h),
                              //           Padding(
                              //             padding: EdgeInsets.only(left: 1.w),
                              //             child: customText(
                              //               text: "08:15 AM",
                              //               fontSize: 14.sp,
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                //               Padding(
                //                 padding: EdgeInsets.symmetric(
                //                   horizontal: 5.w,
                //                   vertical: 2.h,
                //                 ),
                //                 child: Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //
                //                     /// PROFILE IMAGE
                //                     Image.asset(
                //                       "assets/png/chat_images/chat_profile_img.png",
                //                       height: 6.h,
                //                       width: 12.w,
                //                     ),
                //
                //                     SizedBox(width: 3.w),
                //
                //                     /// MESSAGE SECTION
                //                     Expanded(
                //                       child: Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //
                //                           /// NAME
                //                           customText(
                //                             text: "Gizelle Jekronia ( Host )",
                //                             fontSize: 15.sp,
                //                             fontWeight: FontWeight.w600,
                //                             fontFamily: 'CormorrantGaramond',
                //                           ),
                //
                //                           SizedBox(height: 0.5.h),
                //
                //                           /// MESSAGE BOX
                //                           Container(
                //                             padding: EdgeInsets.symmetric(
                //                               horizontal: 4.w,
                //                               vertical: 1.5.h,
                //                             ),
                //                             decoration: BoxDecoration(
                //                               color: whiteColor,
                //                               borderRadius: BorderRadius.only(
                //                                 topRight: Radius.circular(10),
                //                                 bottomLeft: Radius.circular(10),
                //                                 bottomRight: Radius.circular(10),
                //                               ),
                //                             ),
                //                             child: customText(
                //                               text:
                //                               "Vote for the main:\n(A) Lemon-herb chicken\n(B) Eggplant parm\nReact with 🍗 or 🍆!",
                //                               fontSize: 15.5.sp,
                //                               fontWeight: FontWeight.w400,
                //                             ),
                //                           ),
                //
                //                           SizedBox(height: 0.7.h),
                //
                //                           /// TIME + REACTIONS
                //                           Row(
                //                             children: [
                //
                //                               // 🔥 Uncomment if needed
                //                               /*
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 2.w,
                //     vertical: 0.25.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: whiteColor,
                //     borderRadius: BorderRadius.circular(30.sp),
                //   ),
                //   child: customText(
                //     text: "🍗 10",
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                //
                // SizedBox(width: 1.w),
                //
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 2.w,
                //     vertical: 0.25.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: whiteColor,
                //     borderRadius: BorderRadius.circular(20.sp),
                //   ),
                //   child: customText(
                //     text: "🍆 3",
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                //
                // SizedBox(width: 2.w),
                // */
                //
                //                               customText(
                //                                 text: "08:15 AM",
                //                                 fontSize: 14.sp,
                //                                 fontWeight: FontWeight.w400,
                //                               ),
                //                             ],
                //                           ),
                //
                //                           SizedBox(height: 1.h),
                //
                //                           /// TYPING IMAGE
                //                           Align(
                //                             alignment: Alignment.centerRight,
                //                             child: Image.asset(
                //                               "assets/png/chat_images/msg_typing_img.png",
                //                               height: 12.h,
                //                               width: 24.w,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),

SizedBox(height: 2.h,),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('group')
                                    .doc(groupId)
                                    .collection('messages')
                                    .orderBy('createdAt', descending: false)
                                    .snapshots(),
                                builder: (context, snapshot) {

                                  /// LOADING
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  /// NO DATA
                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: customText(
                                          text: "No Messages Found",
                                        ),
                                      ),
                                    );
                                  }

                                  /// MESSAGES LIST
                                  final messages = snapshot.data!.docs;

                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (_scrollController.hasClients) {
                                      _scrollController.animateTo(
                                        _scrollController.position.maxScrollExtent,
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeOut,
                                      );
                                    }
                                  });

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {

                                      final message =
                                      messages[index].data() as Map<String, dynamic>;
                                      final Me = controller.returnUserId() == message["senderId"];
                                      Timestamp? sendTime = message["createdAt"];
                                      DateTime date = sendTime?.toDate() ?? DateTime.now();

                                      String period = date.hour >= 12 ? "PM" : "AM";
                                      int hour = date.hour % 12;
                                      hour = hour == 0 ? 12 : hour;
                                      String minute = date.minute.toString().padLeft(2, '0');
                                      String time = "$hour:$minute $period";
                                      return Column(
                                        children: [

                                          if (Me)
                                          /// ---------------- USER MESSAGE (BLUE - RIGHT SIDE)
                                            Padding(
                                              padding: EdgeInsets.only(right: 5.w,top: 1.5.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                            maxWidth: 60.w,
                                                        ),
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                                                          decoration: BoxDecoration(
                                                            color: blueColor,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: customText(
                                                            text: message["message"] ?? "",
                                                            fontSize: 15.5.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(height: 0.2.h),

                                                      Padding(
                                                        padding: EdgeInsets.only(left: 1.w),
                                                        child: customText(
                                                          text: "${time}",
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          else
                                          /// ---------------- OTHER USER MESSAGE (WHITE - LEFT SIDE)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 5.w,
                                                top: 2.h,
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  /// PROFILE IMAGE
                                                  Image.asset(
                                                    "assets/png/chat_images/chat_profile_img.png",
                                                    height: 6.h,
                                                    width: 12.w,
                                                  ),

                                                  SizedBox(width: 3.w),

                                                  /// MESSAGE SECTION
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        /// NAME
                                                        customText(
                                                          text: message["senderName"] ?? "",
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'CormorrantGaramond',
                                                        ),

                                                        SizedBox(height: 0.5.h),

                                                        /// MESSAGE BOX
                                                        Container(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: 4.w,
                                                            vertical: 1.5.h,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: whiteColor,
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: customText(
                                                            text: message["message"] ?? "",
                                                            fontSize: 15.5.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),

                                                        SizedBox(height: 0.7.h),

                                                        Row(
                                                          children: [
                                                            customText(
                                                              text: "${time}",
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      // /// TYPING IMAGE
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Image.asset(
                      //     "assets/png/chat_images/msg_typing_img.png",
                      //     height: 12.h,
                      //     width: 24.w,
                      //   ),
                      // ),
                      // Input bar pinned to bottom
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                // Icon(Icons.add),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(25.sp),
                                    ),
                                    child: TextField(
                                      controller: controller.chatController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 1.h).copyWith(left: 1.w),
                                        hintText: "Write Something Here!",
                                        border: InputBorder.none,
                                        suffixIconConstraints: BoxConstraints(
                                          maxHeight: 6.h,
                                          maxWidth: 6.w,
                                        ),
                                        // suffixIcon: SizedBox(
                                        //   height: 5.h,
                                        //   width: 5.w,
                                        //   child: Image.asset(
                                        //     "assets/png/icons/office_pin_icon.png",
                                        //     fit: BoxFit.contain,
                                        //   ),
                                        // ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "WorkSans",
                                      ),
                                    ),
                                  ),
                                ),



                                SizedBox(width: 2.w),
                                InkWell(
                                  onTap: (){
                                    final userName = prefs.getString(LocalDBKeys.USERFULLNAME);
                                    try{
                                      messagingService.sendMessage(groupId: groupId, userId: controller.returnUserId(), userName: userName.toString(), message: controller.chatController.text);
                                      /// ✅ clear ONLY after success
                                      controller.chatController.clear();
                                    }
                                    catch(e){
                                      /// ❌ do NOT clear if failed
                                      print("Message failed: $e");
                                      Get.snackbar(
                                        "Error",
                                        "Message not sent. Try again.",
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/png/icons/send_message_icon.png",
                                    height: 6.h,
                                    width: 6.w,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
}
