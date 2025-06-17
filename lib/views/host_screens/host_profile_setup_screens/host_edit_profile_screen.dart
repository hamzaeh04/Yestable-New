import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/profile_controller.dart';

import '../../../widget/loading_step_indicator.dart';

class HostEditProfileScreen extends StatelessWidget {
  HostEditProfileScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w,right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed("bottomnavigationbar");
                    },
                    child: customText(
                        text: "Cancel",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: whiteColor
                    ),
                  ),
                  SizedBox(width: 6.w),
                  customText(
                      text: "Edit Profile",
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      fontFamily: "CormorantGaramond",
                      color: whiteColor
                  ),
                  SizedBox(width: 1.w),
                  InkWell(
                    onTap: (){
                      Get.toNamed('allowhostnotificationscreen');
                    },
                    child: customText(
                        text: "Continue",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: whiteColor
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      child: loadingStepIndicator("1/3", 0.08),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp), // Apply the same border radius here
                      child: Container(
                        height: 13.h,
                        width: 26.w,
                        child: Image.asset("assets/png/girl_profile.png", fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    customText(
                        text: "Polish Your Profile",
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: blueColor
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align columns to the top
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ListView.builder(
                              //     itemCount: users.length,
                              //     itemBuilder: (context,index){
                              //       final user = users[index];
                              //       return customText(
                              //         text: user['title'],
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 15.sp,
                              //       );
                              //     }
                              // ),
                              customText(
                                text: "Name",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Username",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Emails",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.9.h),
                              customText(
                                text: "Pronouns",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 6.2.h),
                              customText(
                                text: "Location",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.h),
                              customText(
                                text: "Bio",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "Sarah Scarnio!",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              customText(
                                text: "Sarah_scarnio01",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              customText(
                                text: "Sarahscarnio@gmail.com",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: "He, She, It, They, Them, Him, Her",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                        text: "Show This on My Profile",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                      Transform.scale(
                                        scale: 8.w / 50,
                                        child: Obx(() => CupertinoSwitch(
                                          activeTrackColor: blackColor,
                                          value: controller.switchValue.value,
                                          onChanged: (val) => controller.toggleSwitch(val),
                                        )),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                              customText(
                                text: "📍   New York",
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: "✏️   ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                  ),
                                  Expanded(
                                    child: customText(
                                      text: "Dog mom, dairy-free diva,\nalways RSVPs yes.",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        SizedBox(height: 0.7.h),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: customText(
                              text: "Set a Place for Someone Else",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              color: greenColor
                          ),
                        ),
                        SizedBox(height: 0.7.h),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                  text: "Show This on My Profile",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                  color: greenColor
                              ),
                              Transform.scale(
                                scale: 8.w / 50,
                                child: Obx(() => CupertinoSwitch(
                                  activeTrackColor: blackColor,
                                  value: controller.switchValue.value,
                                  onChanged: (val) => controller.toggleSwitch(val),
                                )),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 0.7.h),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: customText(
                              text: "More About You",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              color: greenColor
                          ),
                        ),
                        SizedBox(height: 0.7.h),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
