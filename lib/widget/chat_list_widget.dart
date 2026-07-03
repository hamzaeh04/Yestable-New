import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/custom_image_widget.dart';

import '../constants/constants_widgets.dart';

Widget chatListWidget(
    String? imagePath,
    String? groupName,
    String? lastMsg,
    String? time,
    bool? unSeen,
    int? msgCount,
    String? memberCount, {
      String? groupId,
      String? senderName,
      String? invitationMsg,
      String? adminId,
      bool? isGroupEnabled,
      bool? isAdmin = false
    }) {
  final bool isDisabled = isGroupEnabled ?? false;

  return Opacity(
    opacity: isDisabled ? 0.55 : 1.0,
    child: InkWell(
      onTap: (isDisabled && isAdmin != true)
          ? null
          : () {
        Get.toNamed(
          "chatmessagescreen",
          arguments: {
            "membersCount": memberCount,
            "groupName": groupName,
            "imagePath": imagePath,
            "groupId": groupId,
            "invitationMsg": invitationMsg,
            "adminId": adminId,
            "isGroupEnable": isGroupEnabled
          },
        );

        print("isDisabled: $isDisabled");
        print("isAdmin: $isAdmin");
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Row(
              children: [
                Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: isDisabled
                          ? const ColorFilter.matrix([
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0, 0, 0, 1, 0,
                      ])
                          : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.dst,
                      ),
                      child: groupImage(imagePath, isDisabled),
                    ),

                    if (isDisabled)
                      Positioned.fill(
                        child: Container(
                          color: Colors.grey.withOpacity(0.25),
                        ),
                      ),

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
                              Image.asset(
                                "assets/png/girl_profile.png",
                                fit: BoxFit.cover,
                              ),

                              BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 3,
                                  sigmaY: 3,
                                ),
                                child: Center(
                                  child: Container(
                                    color: Colors.black26.withOpacity(0.25),
                                    child: Center(
                                      child: customText(
                                        text: memberCount,
                                        color: whiteColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.4.w,
                                    color: whiteColor,
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

                SizedBox(width: 2.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: customText(
                              text: groupName,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: isDisabled
                                  ? Colors.grey.shade700
                                  : blackColor,
                              fontFamily: "CormorantGaramond",
                              height: 1.1,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),

                          if (isDisabled)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.3.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: customText(
                                text: "Disabled",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: whiteColor,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 0.5.h),
                      customText(
                        text: (senderName != null &&
                            senderName.toString().isNotEmpty &&
                            lastMsg != null &&
                            lastMsg.toString().isNotEmpty)
                            ? "$senderName: $lastMsg"
                            : "",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDisabled
                            ? Colors.grey.shade600
                            : blackColor,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 2.w),
                if(!isDisabled)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    customText(
                      text: time,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w200,
                      color: isDisabled
                          ? Colors.grey.shade600
                          : blackColor,
                    ),

                    SizedBox(height: 0.6.h),

                    unSeen == true
                        ? Container(
                      height: 2.h,
                      width: 4.w,
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.grey
                            : blueColor,
                        borderRadius:
                        BorderRadius.circular(8.sp),
                      ),
                      child: Center(
                        child: customText(
                          text: "$msgCount",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                          fontFamily: 'WorkSans2',
                        ),
                      ),
                    )
                        : SizedBox(height: 1.7.h),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    ),
  );
}
Widget groupImage(String? imagePath, bool isDisabled) {
  String baseUrl = baseService.baseURL;

  Widget imageWidget;

  if (imagePath != null && imagePath.isNotEmpty) {
    imageWidget = CachedNetworkImage(
      imageUrl: "$baseUrl$imagePath",
      width: 12.w,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 6.h,
          width: 12.w,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) {
        return Image.asset(
          "assets/png/admin_home_foodpic.png",
          width: 12.w,
          fit: BoxFit.cover,
        );
      },
    );
  } else {
    imageWidget = Image.asset(
      "assets/png/admin_home_foodpic.png",
      width: 12.w,
      fit: BoxFit.cover,
    );
  }

  return ColorFiltered(
    colorFilter: isDisabled
        ? const ColorFilter.matrix([
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0, 0, 0, 1, 0,
    ])
        : const ColorFilter.mode(
      Colors.transparent,
      BlendMode.dst,
    ),
    child: imageWidget,
  );
}
// Widget chatListWidget (String? imagePath,String? groupName, String? lastMsg, String? time, bool? unSeen,int? msgCount,String? memberCount,{String? groupId,String? senderName,String? invitationMsg,String? adminId, bool? isGroupEnabled = false}){
//   return
//       InkWell(
//         onTap: (){
//           Get.toNamed("chatmessagescreen", arguments: {
//           "membersCount": memberCount,
//           "groupName": groupName,
//           "imagePath": imagePath,
//             "groupId": groupId,
//             "invitationMsg": invitationMsg,
//             "adminId": adminId
//           });
//         },
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0.5.h),
//               child: Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Image.asset("$imagePath",width: 12.w),
//                       Positioned(
//                         left: 7.5.w,
//                         top: 3.6.h,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8.sp),
//                           child: SizedBox(
//                             height: 2.h,
//                             width: 5.w,
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 // 🔥 Image (background)
//                                 Image.asset(
//                                   "assets/png/girl_profile.png",
//                                   fit: BoxFit.cover,
//                                 ),
//
//                                 // 🔥 Blur overlay
//                                 BackdropFilter(
//                                   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                                   child: Center(
//                                     child: Container(
//                                       child: Center(
//                                         child: customText(
//                                             text: memberCount,
//                                             color: whiteColor,
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                       color: Colors.black26.withOpacity(0.25),
//                                     ),
//                                   ),
//                                 ),
//
//                                 // 🔥 Border layer (on top)
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       width: 0.4.w,
//                                       color: whiteColor,
//                                     )
//                                   ),
//
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ]
//
//                   ),
//                   SizedBox(width: 2.w,),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         customText(
//                           text: groupName,
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w500,
//                           color: blackColor,
//                           fontFamily: "CormorantGaramond",
//                           height: 1.1,
//                           maxLines: 1,
//                           overFlow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 0.5.h,),
//                         customText(
//                           text: (senderName != null &&
//                               senderName.toString().isNotEmpty &&
//                               lastMsg != null &&
//                               lastMsg.toString().isNotEmpty)
//                               ? "$senderName: $lastMsg"
//                               : "",
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: blackColor,
//                           maxLines: 1,
//                           overFlow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 2.w,),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       customText(
//                         text: time,
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w200,
//                         color: blackColor,
//                       ),
//                       SizedBox(height: 0.6.h),
//                       unSeen == true
//                           ? Container(
//                         height: 2.h,
//                         width: 4.w,
//                         decoration: BoxDecoration(
//                           color: blueColor,
//                           borderRadius: BorderRadius.circular(8.sp),
//                         ),
//                         child: Center(
//                           child: customText(
//                             text: "$msgCount",
//                             fontSize: 13.sp,
//                             fontWeight: FontWeight.w500,
//                             color: whiteColor,
//                             fontFamily: 'WorkSans2'
//                           ),
//                         ),
//                       )
//                           : SizedBox(height: 1.7.h),  // placeholder to keep size
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//             Divider(),
//           ],
//         ),
//       );
// }
