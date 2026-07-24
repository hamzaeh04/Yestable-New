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
                  Center  (
                    child: Stack(
                      children: [
                        Container(
                          height: 20.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Center(
                            child: Obx(() {
                              return navigationController.controller.profilePicture.value != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(15.sp),
                                child: Image.file(
                                  navigationController.controller.profilePicture.value!,
                                  height: 20.h,
                                  width: 45.w,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Image.asset(
                                "assets/png/profile_image_large.png",
                                height: 30.h,
                                width: 30.w,
                              );
                            }),
                          ),
                        ),

                        // Cross button overlay
                        Obx(() {
                          return navigationController.controller.profilePicture.value != null
                              ? Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                navigationController.controller.profilePicture.value = null;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5.sp),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15.sp,
                                ),
                              ),
                            ),
                          )
                              : SizedBox.shrink();
                        }),
                      ],
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
                  Obx(()=>
                    buttonWidget(
                      navigationController.controller.profilePicture.value != null ? "Next" : "Skip",
                      greenColor,
                      borderColor: greenColor,
                      onTap: () {
                        final pickedPicture = navigationController.controller.profilePicture.value;
                        navigationController.controller.clearSetupProfileFields();
                        navigationController.controller.profilePicture.value = pickedPicture;
                        navigationController.controller.isEdit.value = false;
                        Get.toNamed("profileeditscreen");
                      },
                    ),
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
