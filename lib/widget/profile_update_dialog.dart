import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/share_with_friends_bottomsheet.dart';
import 'package:yestable/widget/update_sent_sucessfull_dialog.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

void profileUpdateDialog(BuildContext context) {
  // Track selection state
  List<bool> selectedHosts = [true, false]; // Initial selection states

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Container(
                      height: 20.w,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: containerBlueColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/png/profile_update_tick.png",
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Center(
                      child: customText(
                        text: "Profile Updated",
                        fontWeight: FontWeight.w600,
                        fontSize: 21.sp,
                        fontFamily: "CormorantGaramond",
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Center(
                      child: customText(
                        text: "Would you like to send this update\nto your host?",
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        fontFamily: "WorkSans",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    customText(
                      text: "Select hosts to notify:",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: "WorkSans",
                    ),
                    SizedBox(height: 1.h),

                    // ✅ Selectable host widgets
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedHosts[0] = !selectedHosts[0];
                        });
                      },
                      child: hostToNotifyWidget(
                        isSelected: selectedHosts[0],
                        path: "assets/png/profile_update_image1.png",
                        hostTitle: "Emma's Dinner Party",
                        date: "Nov 24",
                      ),
                    ),
                    SizedBox(height: 1.h),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedHosts[1] = !selectedHosts[1];
                        });
                      },
                      child: hostToNotifyWidget(
                        isSelected: selectedHosts[1],
                        path: "assets/png/profile_update_image2.png",
                        hostTitle: "Thanksgiving at David's",
                        date: "Nov 28",
                      ),
                    ),
                    SizedBox(height: 1.h),

                    Center(
                      child: InkWell(
                        onTap: () {
                          showShareWithFriendsBottomSheet(context);
                        },
                        child: customText(
                          text: "Share via Link another method",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          fontFamily: "WorkSans",
                          color: Colors.black.withValues(alpha: 0.6)
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    Row(
                      children: [
                        Expanded(
                          child: buttonWidget(
                            "Not Now",
                            blackColor,
                            colors: backgroundColor,
                            borderColor: Colors.grey.shade400,
                            fontsize: 15.sp,
                            height: 4.5.h,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: buttonWidget(
                            "Send Update",
                            whiteColor,
                            colors: greenColor,
                            fontsize: 15.sp,
                            height: 4.5.h,
                            onTap: () {
                              Future.delayed(Duration(milliseconds: 200), () {
                                updateSentSuccessfull(context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                  ],
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

Widget hostToNotifyWidget({bool? isSelected,String? path,String? hostTitle,String? date}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.sp),
      border: Border.all(
        width: 0.3.w,
        color: containerBorderColor,
      )
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
      child: Row(
        children: [
          isSelected == true ?
        Container(
          height: 5.h,
          width: 5.w,
          decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
          ),
          child: Icon(Icons.check,size: 16.sp,color: Colors.white),
        ):
          Container(
            height: 5.h,
            width: 5.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: containerUnselectedColor,
                width: 0.2.w
              )
            ),
          ),
          SizedBox(width: 2.w),
          Image.asset("$path",width: 12.w),
          SizedBox(width: 2.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: hostTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  fontFamily: "WorkSans",
                  textAlign: TextAlign.center
              ),

              customText(
                  text: date,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  fontFamily: "WorkSans",
                  color: Colors.black.withValues(alpha: 0.6)
              ),
            ],
          )
        ],
      ),
    ),
  );
}
