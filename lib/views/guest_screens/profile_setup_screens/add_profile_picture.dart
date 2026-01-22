import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/picture_upload_bottomsheet.dart';

import '../../../widget/button_widget.dart';

class AddProfilePicture extends StatelessWidget {
  AddProfilePicture({super.key});
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // outer column alignment
          children: [
            // Progress bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
              child: navigationController.isUser == true ? loadingStepIndicator("0/6", 0.02):loadingStepIndicator("0/3", 0.1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // <-- add this
                children: [
                  SizedBox(height: 1.h),
                  customText(
                    text: "Add A Profile Picture",
                    fontSize: 23.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                  ),
                  navigationController.isUser.value == true ?
                  customText(
                    text: "Let everyone get to know that cute face of yours!",
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor
                  ):
                  customText(
                    text: "You’re sparkling like gluten-free champagne",
                    fontSize: 15.sp,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.w400,
                    color: darkGreyColor
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Container(
                      height: 20.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/png/profile_image_large.png",
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h), // Adjust as needed
                    child: buttonWidget(
                      "Add Picture",
                      whiteColor,
                      colors: greenColor,
                      onTap: () {
                        pictureUpload(context);
                      },
                    ),
                  ),
                  buttonWidget(
                    "Skip",
                    greenColor,
                    borderColor: greenColor,
                    onTap: () {
                      Get.toNamed("profileeditscreen");
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
