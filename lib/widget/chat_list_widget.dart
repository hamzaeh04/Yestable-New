import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

Widget chatListWidget (String? imagePath,String? groupName, String? lastMsg, String? time, bool? unSeen,int? msgCount,String? memberCount,{String? groupId,String? senderName,String? invitationMsg,String? adminId}){
  return
      InkWell(
        onTap: (){
          Get.toNamed("chatmessagescreen", arguments: {
          "membersCount": memberCount,
          "groupName": groupName,
          "imagePath": imagePath,
            "groupId": groupId,
            "invitationMsg": invitationMsg,
            "adminId": adminId
          });
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5.h),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Image.asset("$imagePath",width: 12.w),
                      Positioned(
                        left: 7.5.w,
                        top: 3.6.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.sp),
                          child: SizedBox(
                            height: 2.h,
                            width: 5.w,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // 🔥 Image (background)
                                Image.asset(
                                  "assets/png/girl_profile.png",
                                  fit: BoxFit.cover,
                                ),

                                // 🔥 Blur overlay
                                BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Center(
                                    child: Container(
                                      child: Center(
                                        child: customText(
                                            text: memberCount,
                                            color: whiteColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      color: Colors.black26.withOpacity(0.25),
                                    ),
                                  ),
                                ),

                                // 🔥 Border layer (on top)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.4.w,
                                      color: whiteColor,
                                    )
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]

                  ),
                  SizedBox(width: 2.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: groupName,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                          fontFamily: "CormorantGaramond",
                          height: 1.1,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h,),
                        customText(
                          text: (senderName != null &&
                              senderName.toString().isNotEmpty &&
                              lastMsg != null &&
                              lastMsg.toString().isNotEmpty)
                              ? "$senderName: $lastMsg"
                              : "",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      customText(
                        text: time,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w200,
                        color: blackColor,
                      ),
                      SizedBox(height: 0.6.h),
                      unSeen == true
                          ? Container(
                        height: 2.h,
                        width: 4.w,
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Center(
                          child: customText(
                            text: "$msgCount",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: whiteColor,
                            fontFamily: 'WorkSans2'
                          ),
                        ),
                      )
                          : SizedBox(height: 1.7.h),  // placeholder to keep size
                    ],
                  ),

                ],
              ),
            ),
            Divider(),
          ],
        ),
      );
}
