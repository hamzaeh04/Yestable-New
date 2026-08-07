import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/allergens_widget.dart';
import 'package:yestable/widget/animated_button.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/show_other_dialog_box.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/loading_step_indicator.dart';

class AllergiesDietryScreen extends StatelessWidget {
  AllergiesDietryScreen({super.key}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Don't prefill from the guest's OWN saved profile when this screen
      // is being used to set a MEMBER's preferences (isPreferences==true) —
      // isEdit only means "editing a saved profile", it doesn't distinguish
      // whose profile, so without this check a member's form would open
      // showing the guest's own previously-saved allergies.
      if (controller.isEdit.value == true && controller.isPreferences.value != true) {
        controller.populateAllergiesDietary();
      }
    });
  }
  final ProfileController controller = Get.find<ProfileController>();
  final NavigationController navigationController = Get.find<NavigationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loadingStepIndicator("2/6", 0.5),
                backButton(onTap: (){
                  Get.back();
                  controller.clearPreferences();
                }),
                SizedBox(height: 2.h),
                Obx(() =>
                  controller.isPreferences.value == true ?
                  customText(
                    text: "${(controller.selectedIndex.value != -1 && controller.memberNameControllers.length > controller.selectedIndex.value) ? controller.memberNameControllers[controller.selectedIndex.value].text : ""} Food Boundaries & Beliefs",                    fontSize: 23.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                    height: 0.12.h,
                  ):customText(
                    text: "Food Boundaries & Beliefs",
                    fontSize: 23.sp,
                    fontFamily: "CormorantGaramond",
                    fontWeight: FontWeight.w600,
                    height: 0.12.h,
                  ),
                ),

                SizedBox(height: 0.5.h),
                customText(
                  text: "Do eggs scramble your system? Tell us!",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
                SizedBox(height: 2.h),
                customText(
                  text: "Common Allergens",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),

                /// Allergens Progress Bars
                ListView.builder(
                  itemCount: controller.allergens.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Obx(() => progressBar(
                      controller.allergens[index]['progress'], // RxDouble
                      controller.allergens[index]['title'],
                      controller.getAllergyType(controller.allergens[index]['progress'].value),
                      circleImg: controller.allergens[index]['circleImg'],
                      isEmoji: controller.allergens[index]['isEmoji'],
                      path: controller.allergens[index]['path'],
                    ));
                  },
                ),


                /// Other Allergens
                Obx(() {
                        return controller.other.value
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Other",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.h),
                            TextField(
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.w400,
                              ),
                              controller: controller.otherController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  borderSide: BorderSide(
                                    color: foodBoundariesBorderGreenColor,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  borderSide: BorderSide(
                                    color: foodBoundariesBorderGreenColor,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  borderSide: BorderSide(
                                    color: foodBoundariesBorderGreenColor,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: backgroundColor,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 1.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            buttonWidget(
                              "Edit Other",
                              whiteColor,
                              colors: blueColor,
                              height: 4.h,
                              fontsize: 15.sp,
                              onTap: () {
                                showCustomOtherDialog(controller: controller.otherController,);

                              },
                            ),
                          ],
                        )
                            : others(
                          textFieldController: controller.otherController,
                          title: "Others",
                          path: "assets/png/icons/others_icon.png",
                        );

                      }),

                SizedBox(height: 3.h),

                /// Severity Level
                // customText(
                //   text: "Severity Level",
                //   fontSize: 15.sp,
                //   fontWeight: FontWeight.bold,
                // ),
                // SizedBox(height: 1.h),
                // customText(
                //   text: "Helps hosts understand how careful they need to be",
                //   fontSize: 15.sp,
                //   fontWeight: FontWeight.normal,
                //   color: darkGreyColor,
                // ),
                // SizedBox(height: 1.h),
                // ListView.builder(
                //   itemCount: levels.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   padding: EdgeInsets.zero,
                //   itemBuilder: (context, index) {
                //     return allergenWidget(index + 6, levels[index]);
                //   },
                // ),
                // SizedBox(height: 2.h),

                // /// More About Plate
                // customText(
                //   text: "More about your plate",
                //   fontSize: 16.5.sp,
                //   fontWeight: FontWeight.bold,
                // ),
                // SizedBox(height: 1.h),
                // ListView.builder(
                //   itemCount: more.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   padding: EdgeInsets.zero,
                //   itemBuilder: (context, index) {
                //     String text = more[index];
                //     Widget? leadingWidget;
                //
                //     if (text.contains("Kosher")) {
                //       leadingWidget = Image.asset(
                //         "assets/png/profile_food_images/kosher_icon.png",
                //         height: 16.sp,
                //       );
                //     } else if (text.contains("Keto")) {
                //       leadingWidget = Image.asset(
                //         "assets/png/profile_food_images/keto_icon.png",
                //         height: 16.sp,
                //       );
                //     } else if (text.contains("Halal")) {
                //       leadingWidget = Image.asset(
                //         "assets/png/Halal.png",
                //         height: 16.sp,
                //       );
                //     }
                //     return allergenWidget(index + 10, text, icon: leadingWidget);
                //   },
                // ),
                //
                // /// Other Foods
                // Obx(
                //       () => controller.other.value
                //       ? Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       customText(
                //         text: "Other",
                //         fontSize: 15.sp,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       SizedBox(height: 1.h),
                //       TextField(
                //         maxLines: 4,
                //         decoration: InputDecoration(
                //           hintText:
                //           "Lorem ipsum dolor sit amet consectetur. Nec arcu enim consequat pulvinar proin urna ac tempus. Nulla viverra dui tellus nisi mont es sit tellus ac pellentesque.",
                //           hintStyle: TextStyle(
                //             fontSize: 15.sp,
                //             fontFamily: "WorkSans",
                //             fontWeight: FontWeight.w400,
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10.sp),
                //             borderSide: BorderSide(
                //               color: foodBoundariesBorderGreenColor,
                //               width: 1,
                //             ),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10.sp),
                //             borderSide: BorderSide(
                //               color: foodBoundariesBorderGreenColor,
                //               width: 1,
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10.sp),
                //             borderSide: BorderSide(
                //               color: foodBoundariesBorderGreenColor,
                //               width: 1,
                //             ),
                //           ),
                //           filled: true,
                //           fillColor: backgroundColor,
                //           contentPadding: EdgeInsets.symmetric(
                //             horizontal: 2.w,
                //             vertical: 1.h,
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 1.h),
                //       buttonWidget(
                //         "Edit Other",
                //         whiteColor,
                //         colors: blueColor,
                //         height: 4.h,
                //         fontsize: 15.sp,
                //         onTap: () {},
                //       ),
                //     ],
                //   )
                //       : others(
                //     title: "Others",
                //     path: "assets/png/icons/others_icon.png",
                //   ),
                // ),
                SizedBox(height: 2.h),

                animatedButton((){
                  Get.toNamed("yourrootandrules");
                  // Get.toNamed("yourrootandrules");
                }, "Continue")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Progress Bar Widget
Widget progressBar(RxDouble progress, String title, String desc,{String? circleImg,bool? isEmoji,String? path}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 1.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// LEFT SIDE (IMAGE ONLY IF PATH EXISTS)
            Row(
              children: [
                if (path != null) ...[
                  Image.asset(
                    path,
                    height: 2.5.h,
                    width: 2.5.h,
                  ),
                  SizedBox(width: 1.w),
                ],
                customText(
                  text: title,
                  fontSize: 16.sp,
                ),
              ],
            ),
            // Obx(() => customText(
            //   text: "${(progress.value * 100).round()}%",
            //   fontSize: 14.5.sp,
            // )),
            customText(
                text: "${desc}",
                fontSize: 14.5.sp,
              ),

          ],
        ),
        SizedBox(height: 0.5.h),

        LayoutBuilder(
          builder: (context, constraints) {
            final barHeight = 1.25.h;
            final circleSize = 3.h;

            return GestureDetector(
              onPanUpdate: (details) {
                double dx = details.localPosition.dx;
                double newProgress = dx / constraints.maxWidth;
                progress.value = newProgress.clamp(0.0, 1.0);
              },

              onTapDown: (details) {
                double dx = details.localPosition.dx;
                double newProgress = dx / constraints.maxWidth;
                progress.value = newProgress.clamp(0.0, 1.0);
              },

              child: SizedBox(
                height: circleSize,
                child: Obx(() {
                  final leftPosition =
                      (constraints.maxWidth * progress.value) - (circleSize / 2);

                  return Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      /// Progress Bar
                      Positioned(
                        top: (circleSize - barHeight) / 2,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.sp),
                          child: Container(
                            height: barHeight,
                            color: Colors.white,
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.value,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFEDDAA7),
                                      Color(0xFFFBC93F),
                                      Color(0xFF5F9CD3),
                                      Color(0xFF2C608F),
                                      Color(0xFFE83D3D),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// Indicator Circle
                      Positioned(
                        left: leftPosition.clamp(
                          0.0,
                          constraints.maxWidth - circleSize,
                        ),
                        top: 0,
                        child: Container(
                          height: circleSize,
                          width: circleSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFC0D3E5),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.5.w,
                            ),
                          ),
                          child: Center(
                            child: path !=null ? Image.asset(
                              path,
                              height: 2.h,
                              width: 2.h,
                            ):customText(
                              text: circleImg,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ],
    ),
  );
}
