import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';

void showShareProfileDialog(BuildContext context, {VoidCallback? onCancelTap}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFFF6F0EC),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              customText(
                text: "Share Your Profile",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "CormorantGaramond",
              ),

              SizedBox(height: 3.h),

              // Buttons Row
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancelTap ?? () {
                        Get.toNamed('bottomnavigationbar');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: greenColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      ),
                      child: customText(
                        text: "Cancel",
                        fontSize: 15.sp,
                        color: greenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(width: 4.w),

                  // Share Button
                  Expanded(
                    child: Builder(
                      builder: (buttonContext){
                        return ElevatedButton(
                          onPressed: ()  async {
                            final prefs = await SharedPreferencesMethod.storage;
                            final userId = prefs.getString(LocalDBKeys.USERID);

                            final String url =
                                "https://yes-table-web.vercel.app/?userId=$userId";

                            final box = buttonContext.findRenderObject() as RenderBox?;
                            Share.share(
                              url,
                              subject: "Check out my profile",
                              sharePositionOrigin: box != null
                                  ? box.localToGlobal(Offset.zero) & box.size
                                  : null,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          ),
                          child: customText(
                            text: "Share",
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}