import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/event_widget.dart';
import '../../../widget/home_screen_widget.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});
  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "Hi, Sarah Scarnio!",
                          fontSize: 20.sp,
                          fontFamily: "CormorantGaramond",
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                          height: 0.1.h
                      ),
                      customText(
                        text: "May 01, 2025",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: (){
                        controller.goTSearchScreen();
                      },
                      child: homeIconWidget(imagePath: "assets/png/icons/search_icon.png", )
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                      onTap: (){
                        controller.goToNotificationPage();
                      },
                      child: homeIconWidget(icon: Icons.notifications)),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// 👇 This is the scrollable bottom half with rounded corners
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                          child: customText(
                            text: "Upcoming Events",
                            fontSize: 19.sp,
                            fontFamily: "CormorantGaramond",
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.sp),
                                        color: blueColor,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                        child: customText(
                                          text: "In 4 Hrs",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: whiteColor,
                                          fontFamily: "CormorantGaramond",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  InkWell(
                                    onTap: (){
                                      Get.toNamed("eventdetailsscreen");
                                    },
                                      child: eventScreenWidget(bgcolor: backgroundColor)
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
