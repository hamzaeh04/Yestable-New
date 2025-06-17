import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants_widgets.dart';

void showNewPostBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFFF6F0EC),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Title & Close
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: 'New Post',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "CormorantGaramond",
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, size: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Divider(height: 0.2.h),
                  SizedBox(height: 1.5.h),
                  // User Row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 3.h,
                        backgroundImage: AssetImage("assets/png/chat_images/user5.png"),
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: "Sarah Scarnio",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "CormorantGaramond",
                          ),
                          customText(
                            text: "|What’s New?",
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  // Media Icons
                  Row(
                    children: [
                      Icon(Icons.image, size: 22.sp),
                      SizedBox(width: 4.w),
                      Icon(Icons.camera_alt_outlined, size: 22.sp),
                      SizedBox(width: 4.w),
                      Icon(Icons.gif_box_outlined, size: 22.sp),
                      SizedBox(width: 4.w),
                      Icon(Icons.tag, size: 22.sp),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  // Reply + Accept Row
                  Row(
                    children: [
                      Icon(Icons.public, size: 16.sp),
                      SizedBox(width: 2.w),
                      customText(
                        text: "Anyone Can Reply",
                        fontSize: 10.sp,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E5A99),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 1.2.h,
                          ),
                        ),
                        child: customText(
                          text: "Accept",
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
