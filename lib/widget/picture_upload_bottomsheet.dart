import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

void pictureUpload(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: greenColor,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.h,vertical: 3.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                    text: "Add Picture",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: whiteColor,
                  fontFamily: "CormorantGaramond"
                ),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.close,color: whiteColor,)
                )
              ],
            ),
            SizedBox(height: 4.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: customText(
                      text: "Choose From Camera Roll",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: blackColor
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: customText(
                      text: "Add from Gallery",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                        color: blackColor
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 6.h),
          ],
        ),
      );
    },
  );
}
