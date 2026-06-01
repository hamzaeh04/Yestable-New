import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/core/services/firebase_messaging/messaging_service.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../widget/chat_list_widget.dart';
import '../../../widget/home_screen_widget.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();
  final MessagingService messagingService = MessagingService();
  final prefs = SharedPreferencesMethod.storage;

  @override
  Widget build(BuildContext context) {
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
                        height: 0.1.h,
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
                      onTap: (){
                        controller.addtoFriendScreen();
                      },
                      child: homeIconWidget(imagePath: "assets/png/icons/search_icon.png", )
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                      onTap: (){
                        controller.goToNotificationPage();
                      },
                      child: homeIconWidget(icon: Icons.notifications)),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// 👇 This is the scrollable bottom half with rounded corners
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                child: Container(
                  width: double.infinity,
                  color: backgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            SizedBox(height: 3.h),
                            // Search bar on top
                            TextField(
                              style: TextStyle(
                                  fontSize: 13.sp, fontFamily: "WorkSans"),
                              // Optional: shrink text size
                              decoration: InputDecoration(
                                isDense: true,
                                // Shrinks the vertical height
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.2.h, horizontal: 4.w),
                                // Reduce vertical padding
                                hintText: 'Search Here',
                                hintStyle: TextStyle(
                                    fontSize: 15.sp, fontFamily: "WorkSans"),
                                filled: true,
                                fillColor: backgroundColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  borderSide: BorderSide(
                                      color: lightgreenColor, width: 0.2.w),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  borderSide: BorderSide(
                                      color: lightgreenColor, width: 0.2.w),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 4.w),
                                  child: Image.asset(
                                    "assets/png/icons/search_icon.png",
                                    height: 2.h,
                                    width: 2.h,
                                  ),
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minHeight: 2.h,
                                  minWidth: 2.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),


                          ],
                        ),
                      ),
                      controller.isUser.value ?
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('group').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator(color: greenColor,));
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: customText(text: "No Groups Found"),
                              );
                            }

                            final allGroups = snapshot.data!.docs;

                            // filter groups where user exists in members
                            final userGroups = allGroups.where((groupDoc) {
                              final groupId = groupDoc.id;

                              // We cannot check subcollection directly here,
                              // so we move check into UI per group
                              return true;
                            }).toList();

                            return ListView.builder(
                              itemCount: userGroups.length,
                              itemBuilder: (context, index) {

                                final groupDoc = userGroups[index];

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('group')
                                      .doc(groupDoc.id)
                                      .collection('members')
                                      .doc(controller.returnUserId())
                                      .snapshots(),

                                  builder: (context, memberSnap) {

                                    final group = groupDoc.data() as Map<String, dynamic>;

                                    Timestamp? lastMessageTime = group["lastMessageTime"];
                                    DateTime date =
                                        lastMessageTime?.toDate() ?? DateTime.now();

                                    String getTimeAgo(DateTime date) {
                                      final diff = DateTime.now().difference(date);

                                      if (diff.inSeconds < 60) return "just now";
                                      if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
                                      if (diff.inHours < 24) return "${diff.inHours} hr ago";
                                      return "${diff.inDays} days ago";
                                    }

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 0.h,
                                      ),
                                      child: StreamBuilder<int>(
                                        stream: messagingService.getUnreadCount(
                                          groupId: groupDoc.id,
                                          userId: controller.returnUserId(),
                                        ),
                                        builder: (context, snap) {

                                          final msgCount = snap.data ?? 0;

                                            return chatListWidget(
                                              // "assets/png/admin_home_foodpic.png",
                                              group["imagePath"] ?? "assets/png/admin_home_foodpic.png",
                                              group["GroupName"] ?? "",
                                              group["lastMessage"] ?? "No messages yet",
                                              getTimeAgo(date),
                                              msgCount != 0,
                                              msgCount,
                                              group["membersCount"].toString(),
                                              groupId: groupDoc.id,
                                              senderName: group["lastMessageSenderName"],
                                              invitationMsg: group["groupDescription"] ?? "",
                                              adminId: group["adminId"],
                                              isGroupEnabled: group["disableGroup"],
                                              isAdmin: false,
                                            );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ):Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('group')
                              .where('adminId', isEqualTo: controller.returnUserId())
                              .orderBy('lastMessageTime', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            print(controller.returnUserId());

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(color: greenColor,),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: customText(text: "No Groups Found"),
                              );
                            }

                            final groups = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: groups.length,
                              itemBuilder: (context, index) {

                                final group =
                                groups[index].data() as Map<String, dynamic>;

                                Timestamp? lastMessageTime = group["lastMessageTime"];

                                DateTime date = lastMessageTime?.toDate() ?? DateTime.now();
                                String memberCount() {
                                  if (group["membersCount"] < 10) {
                                    return group["membersCount"].toString();
                                  } else {
                                    return "${group["membersCount"].toString()}+";
                                  }
                                }

                                String getTimeAgo(DateTime date) {
                                  final diff = DateTime.now().difference(date);

                                  if (diff.inSeconds < 60) {
                                    return "just now";
                                  } else if (diff.inMinutes < 60) {
                                    return "${diff.inMinutes} min ago";
                                  } else if (diff.inHours < 24) {
                                    return "${diff.inHours} hr ago";
                                  } else {
                                    return "${diff.inDays} days ago";
                                  }
                                }


                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 0.h,
                                  ),
                                  child: StreamBuilder<int>(
                                    stream: messagingService.getUnreadCount(
                                      groupId: groups[index].id,
                                      userId: controller.returnUserId(),
                                    ),
                                    builder: (context, snap) {

                                      final msgCount = snap.data ?? 0;
                                      bool msgCountBool (){
                                        if(msgCount == 0){
                                          return false;
                                        }
                                        else{
                                          return true;
                                        }
                                      }

                                      return chatListWidget(
                                          // "assets/png/admin_home_foodpic.png",
                                          group["imagePath"] ?? "assets/png/admin_home_foodpic.png",
                                          group["GroupName"] ?? "",
                                          group["lastMessage"] ?? "No messages yet",
                                          getTimeAgo(date),
                                          msgCountBool(),
                                          msgCount, // 🔥 UNREAD MESSAGE COUNT ADDED HERE
                                          memberCount(),
                                          groupId: group["groupId"],
                                          senderName: group["lastMessageSenderName"],
                                          invitationMsg: group["groupDescription"] ?? "",
                                          adminId: group["adminId"],
                                        isGroupEnabled: group["disableGroup"],
                                        isAdmin: true
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //   child: chatListWidget(
                      //     "assets/png/admin_home_foodpic.png",
                      //     "Gizelle Dinner Event",
                      //     "Sophia: Thank You For Your Suggestions",
                      //     "2hrs Ago",
                      //     true, // just alternate unseen for example
                      //     4,
                      //     "30+"
                      //   ),
                      // ),
                      //
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //   child: chatListWidget(
                      //     "assets/png/admin_home_foodpic.png",
                      //     "Sophia Dinner Event",
                      //     "Sophia: Thank You For Your Suggestions",
                      //     "2hrs Ago",
                      //     false, // just alternate unseen for example
                      //     4,
                      //       "30+"
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: blueColor,
      //     foregroundColor: whiteColor,
      //     shape: const CircleBorder(),
      //     onPressed: () {
      //     Get.toNamed("newmessagescreen");
      //     },
      //     child: Icon(Icons.add,size: 20.sp,color: whiteColor,)
      // ),
    );
  }
}
