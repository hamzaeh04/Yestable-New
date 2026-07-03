import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/core/services/login/google_auth_service.dart';
import 'package:yestable/outh_file/local_db_key.dart';

import '../../../utils/shared_prefrences_methods.dart';
import '../../../utils/utility.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/loading_step_indicator.dart';
import '../../../widget/privacy_dialog.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final NavigationController navigationController =
      Get.find<NavigationController>();

  // final ProfileController controller = Get.find<ProfileController>();
  final prefs = SharedPreferencesMethod.storage;
  GoogleAuthService authService = GoogleAuthService();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigationController.controller.fetchMyProfile();
      if(navigationController.controller.isEdit.value == true){
        navigationController.controller.populatePersonalInfo();
      }
      navigationController.controller.email.text =
          prefs.getString(LocalDBKeys.USEREMAIL) ?? "";
    });
    return Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SafeArea(
            child:
                navigationController.isUser.value == true
                    ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              (navigationController.controller.getMyProfileModel.value?.data?.profileCompleted == true) ?
                                Get.toNamed("bottomnavigationbar"): Get.toNamed("addprofilepicture");
                            },
                            child: customText(
                              text: "Cancel",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: whiteColor,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Column(
                            children: [
                              customText(
                                text: "Set Your Table",
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                fontFamily: "CormorantGaramond",
                                color: whiteColor,
                              ),
                              customText(
                                text: "Your seat at the table starts here!",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: whiteColor,
                              ),
                            ],
                          ),
                          SizedBox(width: 6.w),
                          InkWell(
                            onTap: () {
                              navigationController
                                  .controller
                                  .isPreferences
                                  .value = false;
                              print(
                                navigationController
                                    .controller
                                    .isPreferences
                                    .value,
                              );
                              if(navigationController.controller.isEdit.value == false){
                                if(navigationController
                                    .controller.nameController.text.isNotEmpty && navigationController
                                    .controller.userName.text.isNotEmpty && navigationController
                                    .controller.email.text.isNotEmpty && navigationController
                                    .controller.location.text.isNotEmpty && navigationController
                                    .controller.bio.text.isNotEmpty) {
                                  navigationController.controller.setupProfile(navigationController.isUser.value, profilePic: navigationController.controller.profilePicture.value);
                                } else {
                                  Utils.showToast("Fill all the fields!", true);
                                }
                              } else{
                                navigationController.controller.editProfile(navigationController.isUser.value, profilePic: navigationController.controller.profilePicture.value, hosting: navigationController.controller.switchValue2.value, navController: navigationController, isPreference: true);
                              }
                              // Get.toNamed('allergiesdietryscreen');
                              print(
                                "Name: ${navigationController.controller.nameController.text}",
                              );
                              print(
                                "Email: ${navigationController.controller.email.text}",
                              );
                              print(
                                "Username: ${navigationController.controller.userName.text}",
                              );
                              print(
                                "Location: ${navigationController.controller.location.text}",
                              );
                              print(
                                "Bio: ${navigationController.controller.bio.text}",
                              );
                            },
                            child: customText(
                              text: "Continue",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if(navigationController.controller.isEdit.value == true){
                                Get.toNamed("bottomnavigationbar");
                              } else{
                                (navigationController.controller.getMyProfileModel.value?.data?.profileCompleted == true) ?
                                Get.toNamed("bottomnavigationbar"): Utils.showToast("Complete your profile first", true);
                              }
                              // authService.logout();
                              // prefs.clear();
                            },
                            child: customText(
                              text: "Cancel",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: whiteColor,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          customText(
                            text: "Edit Profile",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            fontFamily: "CormorantGaramond",
                            color: whiteColor,
                          ),
                          SizedBox(width: 6.w),
                          Obx(() {
                            return
                            navigationController.controller.isEdit == false ?
                            InkWell(
                              onTap: () {
                                if(navigationController.isUser.value == false)
                                navigationController.controller.setupProfile(navigationController.isUser.value, profilePic: navigationController.controller.profilePicture.value, isEdit: false);
                                // Get.toNamed('allownotificationscreen');
                                // Get.toNamed('bottomnavigationbar');
                              },
                              child: customText(
                                text: "Continue",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: whiteColor,
                              ),
                            ) : SizedBox.shrink();

                          }),
                          Obx((){return navigationController.controller.isEdit == true ? SizedBox(width: 8.w):SizedBox.shrink();}),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child:
                          navigationController.isUser.value == true
                              ? loadingStepIndicator("1/6", 0.08)
                              : loadingStepIndicator("2/3", 0.3),
                    ),
                    Obx(() {
                      BaseService baseService = BaseService();
                      final controller = navigationController.controller;

                      final localImage = controller.profilePicture.value;
                      final profilePic =
                          controller.getMyProfileModel.value?.data?.profilePic;

                      if (localImage != null) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.sp),
                              child: Image.file(
                                localImage,
                                height: 13.h,
                                width: 26.w,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // 🔴 Close Button
                            Positioned(
                              top: 0.25.h,
                              right: 1.5.w,
                              child: GestureDetector(
                                onTap: () {
                                  controller.profilePicture.value = null;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 0.5.h),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (profilePic?.isNotEmpty ?? false) {
                        final imageUrl = profilePic!.startsWith("https")
                            ? profilePic!
                            : "${baseService.baseURL}$profilePic";

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.sp),
                          child: SizedBox(
                            height: 13.h,
                            width: 26.w,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 13.h,
                                  width: 26.w,
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        );
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15.sp),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 13.h,
                          width: 26.w,
                          color: greenColor,
                          child: Image.asset(
                            "assets/png/profile_image_large.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 0.5.h),
                    InkWell(
                      onTap: () {
                        print('hello');
                        navigationController.controller.pickFromGallery();
                      },
                      child: customText(
                        text: "Edit Profile",
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: blueColor,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align columns to the top
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
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.9.h),
                              customText(
                                text: "Username",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.h),
                              customText(
                                text: "Emails",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.h),
                              customText(
                                text: "Pronouns",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              Obx(
                                () =>
                                    navigationController
                                                .controller
                                                .pronounIsSelected
                                                .value ==
                                            3
                                        ? SizedBox(height: 20.3.h)
                                        : SizedBox(height: 18.h),
                              ),
                              customText(
                                text: "Location",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.h),
                              customText(
                                text: "Bio",
                                fontWeight: FontWeight.w400,
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
                              // customText(
                              //   text: "Sarah Scarnio!",
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 15.sp,
                              // ),
                              customProfileField(
                                hint: 'Sarah Scarnio!',
                                controller:
                                    navigationController
                                        .controller
                                        .nameController,
                              ),
                              const Divider(),
                              // customText(
                              //   text: "Sarah_scarnio01",
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 15.sp,
                              // ),
                              customProfileField(
                                hint: 'Sarah_scarnio01',
                                controller:
                                    navigationController.controller.userName,
                              ),

                              const Divider(),
                              // customText(
                              //   text: "Sarahscarnio@gmail.com",
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 15.sp,
                              // ),
                              customProfileField(
                                hint: "Sarahscarnio@gmail.com",
                                controller:
                                    navigationController.controller.email,
                                readonly: true,
                              ),
                              const Divider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // customText(
                                  //   text: "He, She, They, Them, Him, Her",
                                  //   fontWeight: FontWeight.w400,
                                  //   fontSize: 15.sp,
                                  //   color: Colors.grey,
                                  // ),
                                  SizedBox(height: 0.5.h),
                                  pronounList(),
                                  SizedBox(height: 0.8.h),
                                  const Divider(height: 0),
                                  SizedBox(height: 0.2.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                        text: "Show This on My Profile",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                      Transform.scale(
                                        scale: 7.w / 50,
                                        child: Obx(
                                          () => CupertinoSwitch(
                                            activeTrackColor: blackColor,
                                            value:
                                                navigationController
                                                    .controller
                                                    .switchValue
                                                    .value,
                                            onChanged:
                                                (val) => navigationController
                                                    .controller
                                                    .toggleSwitch(val),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.2.h),

                                  const Divider(height: 0),
                                ],
                              ),
                              SizedBox(height: 0.8.h),
                              // customText(
                              //   text: "📍   New York",
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 15.sp,
                              // ),
                              customProfileField(
                                hint: "📍   New York",
                                controller:
                                    navigationController.controller.location,
                              ),
                              const Divider(),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     customText(
                              //       text: "✏️   ",
                              //       fontWeight: FontWeight.w400,
                              //       fontSize: 15.sp,
                              //     ),
                              //     Expanded(
                              //       child: customText(
                              //         text: "Dog mom, dairy-free diva,\nalways RSVPs yes.",
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 15.sp,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              customProfileField(
                                hint:
                                    "✏️   Dog mom, dairy-free diva, always RSVPs yes.",
                                controller: navigationController.controller.bio,
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
                        // Padding(
                        //   padding: EdgeInsets.only(left: 5.w),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       customText(
                        //         text: "Set a Place for Someone Else",
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 17.sp,
                        //         color: greenColor
                        //       ),
                        //       Container(
                        //         //padding: EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 0.2.h),
                        //         margin: EdgeInsets.only(right: 4.w),
                        //         height: 3.h,
                        //         width: 6.5.w,
                        //         decoration: BoxDecoration(
                        //           color: Colors.black,
                        //           shape: BoxShape.circle
                        //         ),
                        //         child: Icon(Icons.add, color: Colors.white, size: 17.sp,),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Obx(
                          () =>
                              navigationController.isUser.value == true
                                  ? Column(
                                    children: [
                                      Divider(),
                                      SizedBox(height: 0.7.h),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5.w,
                                          right: 5.w,
                                        ),
                                        child: Column(
                                          children: [
                                            /// ================= HEADER =================
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  customText(
                                                    text:
                                                        "Set a Place for Someone Else",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17.sp,
                                                    color: greenColor,
                                                  ),

                                                  InkWell(
                                                    onTap:
                                                        () =>
                                                            navigationController
                                                                .controller
                                                                .isPlaceExpanded
                                                                .toggle(),
                                                    child: Container(
                                                      height: 3.h,
                                                      width: 6.5.w,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        navigationController
                                                                .controller
                                                                .isPlaceExpanded
                                                                .value
                                                            ? Icons.remove
                                                            : Icons.add,
                                                        color: Colors.white,
                                                        size: 17.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// ================= EXPANDABLE CONTENT =================
                                            Obx(
                                              () => AnimatedCrossFade(
                                                firstChild: SizedBox.shrink(),
                                                secondChild: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 0.5.h,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      /// 🔹 DYNAMIC SET PLACE FORMS
                                                      // Obx(
                                                      //       () {
                                                      //     final controller = navigationController.controller;
                                                      //
                                                      //     return ListView.builder(
                                                      //       shrinkWrap: true,
                                                      //       padding: EdgeInsets.zero,
                                                      //       physics: NeverScrollableScrollPhysics(),
                                                      //       itemCount: controller.places.length,
                                                      //       itemBuilder: (context, index) {
                                                      //
                                                      //         /// Check if previous form is completed safely
                                                      //         bool showForm = false;
                                                      //
                                                      //         if (index == 0) {
                                                      //           showForm = true;
                                                      //         } else if (controller.placeCompleted.length > index - 1) {
                                                      //           showForm = controller.placeCompleted[index - 1];
                                                      //         }
                                                      //
                                                      //         if (!showForm) {
                                                      //           return const SizedBox.shrink();
                                                      //         }
                                                      //
                                                      //         return setPlace(index);
                                                      //       },
                                                      //     );
                                                      //   },
                                                      // ),
                                                      Obx(() {
                                                        final controller =
                                                            navigationController
                                                                .controller;
                                                        return Column(
                                                          children: List.generate(
                                                            controller
                                                                .places
                                                                .length,
                                                            (index) {
                                                              return setPlace(
                                                                index,
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                      SizedBox(height: 1.5.h),

                                                      /// 🔹 ADD MORE BUTTON
                                                      // ADD MORE BUTTON LOGIC
                                                      if (navigationController
                                                              .controller
                                                              .places
                                                              .length <
                                                          4)
                                                        InkWell(
                                                          onTap: () {
                                                            final controller =
                                                                navigationController
                                                                    .controller;

                                                            // If list is empty, just add the first place
                                                            if (controller
                                                                .places
                                                                .isEmpty) {
                                                              controller.places
                                                                  .add(0);
                                                              controller
                                                                  .placeCompleted
                                                                  .add(false);
                                                              return;
                                                            }

                                                            int lastIndex =
                                                                controller
                                                                    .places
                                                                    .length -
                                                                1;

                                                            // Safety check for placeCompleted length
                                                            if (controller
                                                                    .placeCompleted
                                                                    .length <=
                                                                lastIndex) {
                                                              controller
                                                                  .placeCompleted
                                                                  .add(false);
                                                            }

                                                            // Check if previous form is completed
                                                            if (!controller
                                                                .placeCompleted[lastIndex]) {
                                                              Utils.showToast(
                                                                "Please complete previous form first",
                                                                false,
                                                              );
                                                              return;
                                                            }

                                                            // Add new form safely
                                                            controller.places
                                                                .add(
                                                                  controller
                                                                      .places
                                                                      .length,
                                                                );
                                                            controller
                                                                .placeCompleted
                                                                .add(false);

                                                            // Ensure controllers lists are big enough
                                                            while (controller
                                                                    .memberNameControllers
                                                                    .length <
                                                                controller
                                                                    .places
                                                                    .length) {
                                                              controller
                                                                  .memberNameControllers
                                                                  .add(
                                                                    TextEditingController(),
                                                                  );
                                                              controller
                                                                  .memberReleationControllers
                                                                  .add(
                                                                    TextEditingController(),
                                                                  );
                                                              controller
                                                                  .memberAgeControllers
                                                                  .add(
                                                                    TextEditingController(),
                                                                  );
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 23.w,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  shape:
                                                                      BoxShape
                                                                          .circle,
                                                                  color:
                                                                      greenColor,
                                                                ),
                                                                padding:
                                                                    EdgeInsets.all(
                                                                      0.5.w,
                                                                    ),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 14.sp,
                                                                  color:
                                                                      whiteColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              customText(
                                                                text:
                                                                    'Add more',
                                                                fontSize:
                                                                    15.5.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    greenColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                crossFadeState:
                                                    navigationController
                                                            .controller
                                                            .isPlaceExpanded
                                                            .value
                                                        ? CrossFadeState
                                                            .showSecond
                                                        : CrossFadeState
                                                            .showFirst,
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : SizedBox.shrink(),
                        ),

                        SizedBox(height: 0.7.h),
                        Obx(
                          () =>
                              (navigationController.isUser.value &&
                                      navigationController
                                          .controller
                                          .isEdit
                                          .value)
                                  ? Column(
                                    children: [
                                      Divider(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            customText(
                                              text: "I'm Hosting!",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17.sp,
                                              color: greenColor,
                                            ),
                                            Transform.scale(
                                              scale: 7.w / 50,
                                              child: CupertinoSwitch(
                                                activeTrackColor: blackColor,
                                                value:
                                                    navigationController
                                                        .controller
                                                        .switchValue2
                                                        .value,
                                                onChanged: (val) {
                                                  navigationController
                                                      .controller
                                                      .toggleSwitch2();

                                                  print(
                                                    "I'm Hosting: ${navigationController.controller.switchValue2.value}",
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                  : const SizedBox.shrink(),
                        ),

                        Divider(),
                        // SizedBox(height: 0.7.h),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 5.w),
                        //   child: customText(
                        //     text: "More About You",
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 17.sp,
                        //     color: greenColor,
                        //   ),
                        // ),
                        // SizedBox(height: 0.7.h),
                        // Divider(),
                        SizedBox(height: 0.7.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 6.w),
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  if (!navigationController
                                      .controller
                                      .isSelected
                                      .value) {
                                    privacyDialog(context);
                                  } else {
                                    // Checkbox is TRUE → just uncheck
                                    navigationController.controller.checkBox();
                                  }
                                },
                                child: Container(
                                  height: 3.h,
                                  width: 4.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        navigationController
                                                    .controller
                                                    .isSelected ==
                                                false
                                            ? Colors.white
                                            : radioButtonBlueColor,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 2.w),
                            customText(text: 'I Agree To All', fontSize: 14.sp),
                            SizedBox(width: 1.w),
                            // Policy text with underline
                            InkWell(
                              onTap: () {
                                // handle Policy click
                              },
                              child: customText(
                                text: 'Policy',
                                fontSize: 14.sp,
                                txtDecoration: TextDecoration.underline,
                                height: 0.1.h,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            customText(text: '&', fontSize: 14.sp),
                            SizedBox(width: 1.w),
                            // Terms of Condition text with underline
                            InkWell(
                              onTap: () {
                                // handle Terms click
                              },
                              child: customText(
                                text: 'Terms Of Condition',
                                fontSize: 14.sp,
                                txtDecoration: TextDecoration.underline,
                                height: 0.1.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Obx(() {
                          if (navigationController.controller.isEdit == true) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              child: buttonWidget(
                                "Save",
                                whiteColor,
                                colors: greenColor,
                                onTap: () {
                                  navigationController.controller.editProfile(navigationController.isUser.value, profilePic: navigationController.controller.profilePicture.value, hosting: navigationController.controller.switchValue2.value, navController: navigationController);
                                  // navigationController.changePage(0);
                                  // Get.toNamed("bottomnavigationbar");
                                },
                              ),
                            );
                          }

                          // 👇 IMPORTANT: return something when condition is false
                          return const SizedBox();
                        }),
                        SizedBox(height: 6.h),
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

// List of pronouns
final List<String> pronouns = ['He/Him', 'She/Her', 'They/Them', 'Custom'];

// Widget
Widget pronounList() {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: pronouns.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          pronounItem(pronouns[index], index),
          SizedBox(height: 0.4.h),
        ],
      );
    },
  );
}

// Pronoun item with selection logic
Widget pronounItem(String title, int index) {
  ProfileController controller = Get.find<ProfileController>();
  print(controller.pronounIsSelected.value);
  return Obx(
    () => InkWell(
      onTap: () {
        controller.updatePronounIsSelected(index);
        print(controller.pronounIsSelected.value);
        print(controller.pronounsValue());
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(0.6.w),
                height: 1.8.h,
                width: 4.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color:
                        controller.pronounIsSelected.value == index
                            ? radioButtonBlueColor
                            : Colors.white, // border grey if not selected
                    width: 1.5, // optional border width
                  ),
                ),
                child:
                    controller.pronounIsSelected.value == index
                        ? Container(
                          height: 1.h,
                          width: 1.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: radioButtonBlueColor,
                          ),
                        )
                        : SizedBox.shrink(),
              ),
              SizedBox(width: 1.5.w),
              customText(text: title),
            ],
          ),
          SizedBox(height: 0.7.h),
          controller.pronounIsSelected.value == index && index == 3
              ? customProfileField(
                hint: "Select Custom Values",
                controller: controller.customPronoun,
              )
              : SizedBox.shrink(),
        ],
      ),
    ),
  );
}

// Widget setPlace(int index, {String? title}) {
//   final ProfileController controller = Get.find<ProfileController>();
//
//   final members = controller.getMyProfileModel.value?.data?.members;
//   final isCompleted =
//       controller.placeCompleted.length > index
//           ? controller.placeCompleted[index]
//           : false;
//
//   // Ensure controller lists are big enough
//   while (controller.memberNameControllers.length <= index) {
//     controller.memberNameControllers.add(TextEditingController());
//     controller.memberReleationControllers.add(TextEditingController());
//     controller.memberAgeControllers.add(TextEditingController());
//   }
//
//   while (controller.placeCompleted.length <= index) {
//     controller.placeCompleted.add(false);
//   }
//   // Get memberId for this index
//   final memberId =
//       (members != null && members.length > index) ? members[index].id : null;
//
//   // 🔹 Update controllers AFTER build to avoid setState/build conflicts
//   if (isCompleted && members != null && members.length > index) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.memberNameControllers[index].text = members[index].name ?? "";
//       controller.memberReleationControllers[index].text =
//           members[index].relation ?? "";
//       controller.memberAgeControllers[index].text =
//           members[index].age != null ? members[index].age.toString() : "";
//     });
//   }
//
//   return Padding(
//     padding: EdgeInsets.only(bottom: 1.5.h),
//     child: Column(
//       children: [
//         if (index > 0) ...[
//           SizedBox(height: 1.h),
//           Divider(thickness: 0.4),
//           SizedBox(height: 1.h),
//         ],
//
//         /// ================= NAME =================
//         Row(
//           children: [
//             customText(text: 'Name', fontSize: 15.5.sp),
//             SizedBox(width: 13.w),
//             Expanded(
//               child: TextField(
//                 controller: controller.memberNameControllers[index],
//                 readOnly: isCompleted,
//                 decoration: InputDecoration(
//                   hintText: 'Robert Elbert',
//                   isDense: true,
//                   contentPadding: EdgeInsets.symmetric(vertical: 1.3.h),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                   suffixIcon: InkWell(
//                     onTap: () async {
//                       if (memberId != null) {
//                         await controller.deleteMember(memberId, index);
//                         // No need to remove controllers here; the API already does it
//                       }
//                     },
//                     child: Icon(Icons.delete, size: 18.sp),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         SizedBox(height: 0.8.h),
//
//         /// ================= RELATION =================
//         Row(
//           children: [
//             customText(text: 'Relation', fontSize: 15.5.sp),
//             SizedBox(width: 8.w),
//             Expanded(
//               child: TextField(
//                 controller: controller.memberReleationControllers[index],
//                 readOnly: isCompleted,
//                 decoration: InputDecoration(
//                   hintText: 'Son',
//                   isDense: true,
//                   contentPadding: EdgeInsets.symmetric(vertical: 1.2.h),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         SizedBox(height: 0.8.h),
//
//         /// ================= AGE =================
//         Row(
//           children: [
//             customText(text: 'Age', fontSize: 15.5.sp),
//             SizedBox(width: 16.w),
//             Expanded(
//               child: TextField(
//                 controller: controller.memberAgeControllers[index],
//                 keyboardType: TextInputType.number,
//                 readOnly: isCompleted,
//                 decoration: InputDecoration(
//                   hintText: '15',
//                   isDense: true,
//                   contentPadding: EdgeInsets.symmetric(vertical: 0.8.h),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.6),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//
//         SizedBox(height: 2.h),
//
//         /// ================= SET PREFERENCES =================
//         InkWell(
//           onTap: () {
//             controller.setData(index: index, screenTitle: title ?? "Robert");
//
//             while (controller.placeCompleted.length <= index) {
//               controller.placeCompleted.add(false);
//             }
//             controller.placeCompleted[index] = true;
//             controller.isPreferences.value = true;
//             Get.toNamed('allergiesdietryscreen');
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: greenColor,
//               borderRadius: BorderRadius.circular(20.sp),
//               border: Border.all(width: 0.1.w, color: greenColor),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.3.h),
//               child: customText(
//                 text: "Set Preferences",
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w500,
//                 color: whiteColor,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
Widget setPlace(int index, {String? title}) {
  final controller = Get.find<ProfileController>();
  final members = controller.getMyProfileModel.value?.data?.members ?? [];

  // Controllers are now securely maintained by ProfileController.
  final isMemberCompleted =
      (index < members.length && members.isNotEmpty)
          ? (members[index].profileCompleted ?? false)
          : false;

  final memberId =
      (index < members.length && members.isNotEmpty) ? members[index].id : null;

  return Padding(
    padding: EdgeInsets.only(bottom: 1.5.h),
    child: Column(
      children: [
        if (index > 0) ...[
          SizedBox(height: 1.h),
          Divider(thickness: 0.4),
          SizedBox(height: 1.h),
        ],

        /// NAME
        Row(
          children: [
            customText(text: 'Name', fontSize: 15.5.sp),
            SizedBox(width: 13.w),
            Expanded(
              child: TextField(
                controller: controller.memberNameControllers[index],
                readOnly: isMemberCompleted,
                decoration: InputDecoration(
                  hintText: 'Robert Elbert',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 1.3.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  suffixIcon:
                      memberId != null
                          ? InkWell(
                            onTap: () async {
                              await controller.deleteMember(memberId, index);
                            },
                            child: Icon(Icons.delete, size: 18.sp),
                          )
                          : null,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.8.h),

        /// RELATION
        Row(
          children: [
            customText(text: 'Relation', fontSize: 15.5.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: controller.memberReleationControllers[index],
                readOnly: isMemberCompleted,
                decoration: InputDecoration(
                  hintText: 'Son',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 1.2.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.8.h),

        /// AGE
        Row(
          children: [
            customText(text: 'Age', fontSize: 15.5.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: TextField(
                controller: controller.memberAgeControllers[index],
                keyboardType: TextInputType.number,
                readOnly: isMemberCompleted,
                decoration: InputDecoration(
                  hintText: '15',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0.8.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        /// SET PREFERENCES BUTTON
        InkWell(
          onTap:
              isMemberCompleted
                  ? null
                  : () async {
                    controller.setData(
                      index: index,
                      screenTitle: title ?? "Robert",
                    );

                    // If member is not yet in the DB, add them first
                    if (memberId == null) {
                      bool success = await controller.addMember(
                        activeIndex: index,
                      );
                      if (!success) return;
                    } else {
                      // If they already exist, we should still ensure the controller knows their ID
                      controller.memberId = memberId;
                    }

                    controller.isPreferences.value = true;
                    Get.toNamed('allergiesdietryscreen');
                  },
          child: Container(
            decoration: BoxDecoration(
              color: isMemberCompleted ? Colors.grey : greenColor,
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(
                width: 0.1.w,
                color: isMemberCompleted ? Colors.grey : greenColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.3.h),
              child: customText(
                text: "Set Preferences",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customProfileField({
  required String hint,
  double? size,
  TextEditingController? controller,
  bool? readonly = false,
  Icon? suffixIcon,
  VoidCallback? onSuffixTap,
  TextInputType? keyboardType
}) {
  return TextField(
    readOnly: readonly ?? false,
    controller: controller,
    keyboardType: keyboardType ?? TextInputType.text,
    cursorColor: greenColor,
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      isDense: true,
      contentPadding: EdgeInsets.zero,

      // 👇 remove default 48px constraint
      suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 45),

      suffixIcon:
          suffixIcon != null
              ? GestureDetector(
                onTap: onSuffixTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: suffixIcon,
                ),
              )
              : null,

      hintStyle: TextStyle(
        fontFamily: 'WorkSans',
        fontWeight: FontWeight.w400,
        fontSize: size ?? 15.sp,
        overflow: TextOverflow.visible,
      ),
    ),
    style: TextStyle(
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w400,
      fontSize: size ?? 15.sp,
      overflow: TextOverflow.visible,
    ),
  );
}
