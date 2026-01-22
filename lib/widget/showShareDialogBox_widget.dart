import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/button_widget.dart';

import '../constants/constants_widgets.dart';

void showShareProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 18.sp),
              ),
            ),


            // Share This Profile With
            Align(
              alignment: Alignment.centerLeft,
              child: customText(
                text: 'Share This Profile With',
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                fontFamily: "CormorantGaramond",
              ),
            ),
            SizedBox(height: 1.5.h),

            // Profile images row
            SizedBox(
              height: 5.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => SizedBox(width: 2.w),
                itemBuilder: (_, index) {
                  final image = Image.asset(
                    'assets/png/chat_images/user${index % 5 + 1}.png',
                    width: 5.2.h,
                    height: 5.2.h,
                    fit: BoxFit.cover,
                  );

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Stack(
                      children: [
                        image,
                        if (index == 5)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 1.h),
            // Copy Profile Link
            Align(
              alignment: Alignment.centerLeft,
              child: customText(
                text: 'Copy Profile Link',
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
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
                      text: 'Example.Com/Share-Link',
                      fontSize: 15.sp,
                    ),
                  ),
                  buttonWidget(
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
    ),
  );
}
