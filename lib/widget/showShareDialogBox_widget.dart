import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/button_widget.dart';

import '../constants/constants_widgets.dart';

void showShareProfileDialog(BuildContext context,{VoidCallback? onTap,VoidCallback? onCancel,String? title,String? link}) {
  final targetContext = context.mounted ? context : Get.context;
  if (targetContext == null) return;

  showDialog(
    context: targetContext,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close icon
                Container(
                  height: 20.w,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: containerBlueColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/png/update_successfull_icon.png",
                      width: 11.w,
                      height: 11.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                /// SUCCESS TITLE
                customText(
                  text: "Event Created Successfully!",
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  fontFamily: "CormorantGaramond",
                ),

                SizedBox(height: 0.8.h),

                // Share This Profile With
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: customText(
                //     text: 'Share This Profile With',
                //     fontWeight: FontWeight.w500,
                //     fontSize: 18.sp,
                //     fontFamily: "CormorantGaramond",
                //   ),
                // ),
                // SizedBox(height: 1.5.h),
                //
                // // Profile images row
                // SizedBox(
                //   height: 5.h,
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 6,
                //     separatorBuilder: (_, __) => SizedBox(width: 2.w),
                //     itemBuilder: (_, index) {
                //       final image = Image.asset(
                //         'assets/png/chat_images/user${index % 5 + 1}.png',
                //         width: 5.2.h,
                //         height: 5.2.h,
                //         fit: BoxFit.cover,
                //       );
                //
                //       return ClipRRect(
                //         borderRadius: BorderRadius.circular(10.sp),
                //         child: Stack(
                //           children: [
                //             image,
                //             if (index == 5)
                //               Positioned.fill(
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     color: Colors.black.withOpacity(0.4),
                //                   ),
                //                   child: Center(
                //                     child: Icon(
                //                       Icons.more_horiz,
                //                       color: Colors.white,
                //                       size: 22.sp,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Copy Profile Link
                Align(
                  alignment: Alignment.center,
                  child: customText(
                    text: title ?? 'Copy Profile Link',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    fontFamily: "CormorantGaramond",
                  ),
                ),
                SizedBox(height: 1.h),

                // Link and Copy button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  height: 5.5.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: greenColor, width: 0.1.w),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/png/icons/chain_icon.png",height: 4.5.h,width: 4.5.w),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: customText(
                          text: link ?? 'Example.Com/Share-Link',
                          fontSize: 15.sp,
                        ),
                      ),
                      buttonWidget(
                        onTap: onTap,
                        "Copy", whiteColor,colors: blueColor,
                        height: 3.5.h,
                        width: 15.w,
                        fontsize: 14.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -5.w, // minimal top gap
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/png/get_started.gif',
                width: 45.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 2.h, // minimal top gap
            left: 0,
            right: -76.w,
            child: InkWell(
                onTap: () {
                  if (onCancel != null) {
                    onCancel();
                  } else {
                    Get.back();
                  }
                },
                child: Icon(Icons.close, size: 18.sp,))
          ),
        ],
      )
    ),
  );
}
