import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/home_screen_widget.dart';
import 'user_home_screen.dart';

class ViewallInvitationScreen extends StatelessWidget {
  ViewallInvitationScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  homeIconWidget(
                    icon: Icons.arrow_back_ios_new,
                    iconsize: 16.sp,
                    onTap: () => controller.goToHome(),
                  ),
                  SizedBox(width: 4.w),
                  customText(
                    text: "Invitations",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    fontFamily: "CormorantGaramond",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp),
              ),
              child: Container(
                width: double.infinity,
                color: backgroundColor,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: invitationWidget(
                          "Jenera Dinner Event",
                          "20+ Attendees",
                          "In New York",
                          "May 12, 2025",
                          "assets/png/dinner_event.png",
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
