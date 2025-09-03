import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';

void showShareWithFriendsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.close, size: 20.sp)
                )
              ],
            ),
            Center(
              child: Container(
                height: 25.w,
                width: 25.w,
                decoration: const BoxDecoration(
                  color: containerBlueColor,
                  shape: BoxShape.circle, // outer blue circle
                ),
                child: Center(
                  child: Container(
                    height: 15.w,
                    width: 15.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle, // inner white circle
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/png/icons/img.png",
                        width: 8.w,
                        height: 8.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.5.h),
            customText(
              text: 'Share with Friends',
              fontSize: 20.sp,
              fontFamily: "CormorantGaramond",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: 'Communicating is more effective when you connect with firends!',
                fontSize: 15.5.sp,
                fontFamily: "WorkSans",
                textAlign: TextAlign.center
              ),
            ),
            SizedBox(height: 2.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(
                  text: 'Share your link',
                  fontSize: 15.5.sp,
                  fontFamily: "WorkSans",
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: 'https://app.yestable841759709',
              ),
              decoration: InputDecoration(
                hintText: 'https://app.yestable841759709',
                fillColor: friendTextfieldColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy,size: 18.sp),
                  onPressed: () {
                  },
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 0.11.h,
                  width: 25.w,
                    color: Colors.black,
                ),
                SizedBox(width: 4.w,),
                customText(
                  text: 'Share via',
                ),
                SizedBox(width: 4.w,),
                Container(
                  height: 0.11.h,
                  width: 25.w,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  socialIcon('assets/png/social_icons/fb.png'),
                  socialIcon('assets/png/social_icons/whatsapp.png'),
                  socialIcon('assets/png/social_icons/x.png'),
                  socialIcon('assets/png/social_icons/skype.png'),
                  socialIcon('assets/png/social_icons/linkedin.png'),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
Widget socialIcon(String path){
  return InkWell(
    onTap: (){},
    child: Image.asset( path, width: 10.w,),
  );
}
