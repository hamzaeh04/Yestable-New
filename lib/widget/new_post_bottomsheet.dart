import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/constants_widgets.dart';

void showNewPostBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor,
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Top Row: Title & Close
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: 'New Post',
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "CormorantGaramond",
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close, size: 18.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 0.2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                  child: Column(
                    children: [
                      SizedBox(height: 1.5.h),
                      // User Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.sp),
                            child: Image.asset(
                              "assets/png/chat_images/user5.png",
                              height: 6.h,
                              width: 6.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: "Sarah Scarnio",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  // fontFamily: "CormorantGaramond",
                                ),
                                SizedBox(height: 1.h),
                                TextField(
                                  style: TextStyle(fontSize: 15.sp,fontFamily: "WorkSans"),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "What’s New?",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                      fontFamily: "WorkSans"
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/png/icons/gallery.png',
                                      height: 18.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Image.asset(
                                      'assets/png/icons/camera.png',
                                      height: 18.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Image.asset(
                                      'assets/png/icons/gif.png',
                                      height: 18.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Image.asset(
                                      'assets/png/icons/hashtag.png',
                                      height: 18.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.h),
                      // Reply + Accept Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          children: [
                            Icon(Icons.public, size: 20.sp),
                            SizedBox(width: 2.w),
                            customText(
                              text: "Anyone Can Reply",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                            const Spacer(),
                            buttonWidget("Post", whiteColor,colors: blueColor,height: 3.5.h,width: 19.w,fontsize: 14.sp),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      );
    },
  );
}
