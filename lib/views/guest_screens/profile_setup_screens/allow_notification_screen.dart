import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/animated_button.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/loading_step_indicator.dart';
import 'package:yestable/widget/picture_upload_bottomsheet.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../outh_file/local_db_key.dart';
import '../../../utils/shared_prefrences_methods.dart';
import '../../../utils/utility.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/share_profile_widget.dart';

class AllowNotificationScreen extends StatelessWidget {
  AllowNotificationScreen({super.key});

  final NotificationController controller = Get.find<NotificationController>();
  final AuthController authController = Get.find<AuthController>();
  final NavigationController navigationController = Get.find<NavigationController>();
  final prefs = SharedPreferencesMethod.storage;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      navigationController.controller.getMyProfileModel.refresh();
    });
    final steps = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // outer column alignment
          children: [
            SizedBox(height: 2.h),
            // Progress bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: backButton(),
            ),Padding(

              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: authController.controller.isUser.value == true ? loadingStepIndicator("6/6", 10): loadingStepIndicator("3/3", 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "Stay In The Know",
                fontSize: 22.sp,
                fontFamily: "CormorantGaramond",
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: customText(
                text: "We'll send you important reminders \nand updates!",
                fontSize: 15.sp,
                fontFamily: "WorkSans",
                fontWeight: FontWeight.w500,
                color: greyTextColor,
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              height: 39.h,
              width: double.infinity,
              child: Image.asset(
                "assets/png/new_guest_illustrations/allow_notification_banner.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Obx((){
                final data = navigationController.controller.getMyProfileModel.value?.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // <-- add this
                  children: [
                    SizedBox(height: 5.h),
                    animatedButton(() async {
                      if(navigationController.isUser.value == true){
                        if(steps == 2){
                          await controller.enableNotification();

                          Get.toNamed("profilecompletescreen");
                          authController.controller.controller.clearSetupProfileFields();
                          await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, true);
                        } else{
                          Utils.showToast('Complete your profile first.', true);
                        }
                      } else{
                        if (steps == 1) {
                          await controller.enableNotification();
                          showShareProfileDialog(context, onCancelTap: (){
                            Get.toNamed('bottomnavigationbar', arguments: true);
                          });
                          authController.controller.controller.clearSetupProfileFields();
                          await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, true);
                        }
                        else{
                          Utils.showToast('Complete your profile first.', true);
                        }
                      }
                      print("Profile completed: ${data?.profileCompleted}, Onboarding Step: ${data?.onboardingStep}, Steps${steps}");

                    }, "Allow Notifications"),
                    buttonWidget(
                      "Maybe Later",
                      greenColor,
                      borderColor: greenColor,
                      onTap: () async {
                        if(navigationController.isUser.value == true){
                          if(steps == 2){
                            Get.toNamed("profilecompletescreen");
                            authController.controller.controller.clearSetupProfileFields();
                            await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, true);
                          } else{
                            Utils.showToast('Complete your profile first.', true);
                          }
                        } else{
                          if (steps == 1) {
                            showShareProfileDialog(context, onCancelTap: (){
                              Get.toNamed('bottomnavigationbar', arguments: true);
                            });
                            authController.controller.controller.clearSetupProfileFields();
                            await prefs.setBool(LocalDBKeys.PROFILECOMPLETED, true);
                          }
                          else{
                            Utils.showToast('Complete your profile first.', true);
                          }
                        }
                      },
                    ),
                  ],
                );
              })
            ),
          ],
        ),
      ),
    );
  }
}
