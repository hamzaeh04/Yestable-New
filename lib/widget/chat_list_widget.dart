import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

Widget chatListWidget (String? imagePath,String? groupName, String? lastMsg, String? time, bool? unSeen,int? msgCount){
  return
      InkWell(
        onTap: (){
          Get.toNamed("chatmessagescreen");
        },
        child: Row(
          children: [
            Image.asset("$imagePath",height: 7.h,width: 12.w),
            SizedBox(width: 2.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: groupName,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                  fontFamily: "CormorantGaramond",
                  height: 1.1
                ),
                SizedBox(height: 0.5.h,),
                customText(
                  text: lastMsg,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                  height: 1.1
                ),

              ],
            ),
            Spacer(),
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
      );
}
