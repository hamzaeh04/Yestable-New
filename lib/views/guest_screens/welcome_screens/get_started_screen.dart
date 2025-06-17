import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Image.asset("assets/png/yestable_logo.png",height: 22.h,width: 22.w),
            ),
            Container(
              height: 32.h,
                width: double.infinity,
                child: Image.asset("assets/png/updated_banner/get_started_banner.png",
                  fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 2.h),
            customText(
              text: "Welcome To Yes Table",
              fontSize: 24.sp,
              fontFamily: "CormorantGaramond",
              fontWeight: FontWeight.w600
            ),
            customText(
                text: "Got allergies? Picky eaters? Friends who go\ngluten-free for fun? ",
                fontSize: 15.sp,
                fontFamily: "WorkSans",
                fontWeight: FontWeight.w400,
              textAlign: TextAlign.center
            ),
            SizedBox(height: 0.5.h),
            customText(
                text: "We’ve got you. Join as a guest or host, and\nlet the planning feel joyful again.",
                fontSize: 15.sp,
                fontFamily: "WorkSans",
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h), // Adjust as needed
              child: buttonWidget(
                "I’m a Guest",
                whiteColor,
                colors: greenColor,
                onTap: () {
                  Get.toNamed('signupscreen');

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w), // Adjust as needed
              child: buttonWidget(
                "I’m a Host",
                greenColor,
                borderColor: greenColor,
                onTap: () {
                  controller.switchUser();
                  Get.toNamed('signupscreen');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
