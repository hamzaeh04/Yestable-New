import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/widget/allergens_widget.dart';
import 'package:yestable/widget/back_button_widget.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/loading_step_indicator.dart';

class AllergiesDietryScreen extends StatelessWidget {
  AllergiesDietryScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());

  final List<String> levels = [
    "🚨 Severe Allergy",
    "🤧 Mild Or Digestive Reaction",
    "🙏🏼 Avoid For Belief Or Culture",
    "👋 No Allergy Just A Preference",
  ];

  final List<String> more = [
    "🍀 Vegan",
    "🥬 Vegetarian",
    "Halal",
    "Kosher",
    "Keto",
  ];

  final List<Map<String, dynamic>> allergens = [
    {
      "progress": 0.3.obs,
      "title": "🥜 Peanuts",
      "desc": "Severe Allergy (Anaphylaxis)",
      "circleImg": "📷",
    },
    {
      "progress": 0.0.obs,
      "title": "🥜 Tree Nuts",
      "desc": "No Allergy",
      "circleImg": "🤗",
    },
    {
      "progress": 0.0.obs,
      "title": "🥛 Sesame",
      "desc": "No Allergy",
      "circleImg": "🤗",
    },
    {
      "progress": 0.0.obs,
      "title": "🌾 Gluten",
      "desc": "Severe Allergy",
      "circleImg": "🤗",
    },
    {
      "progress": 0.8.obs,
      "title": "🥚 Eggs",
      "desc": "Avoid for Beliefs or Culture",
      "circleImg": "🙏",
    },
    {
      "progress": 0.7.obs,
      "title": "🫘 Soy",
      "desc": "Mild or Digestive Reaction",
      "circleImg": "🤧",
    },
    {
      "progress": 0.6.obs,
      "title": "🌾 Fish",
      "desc": "Severe Allergy (Anaphylaxis)",
      "circleImg": "📷",
    },
    {
      "progress": 0.0.obs,
      "title": "🦐 Shellfish",
      "desc": "No Allergy",
      "circleImg": "🤗",
    },
    {
      "progress": 0.0.obs,
      "title": "🥛 Dairy",
      "desc": "No Allergy",
      "circleImg": "🤗",
    },
  ];
  String getAllergyType(double progress) {
    double percentage = progress * 100;

    if (percentage <= 30) {
      return "No Allergy";
    } else if (percentage < 60) {
      return "Mild or Digestive Reaction";
    } else if (percentage < 80) {
      return "Avoid for belief or Culture";
    } else {
      return "Severe Allergy (Anaphylaxis)";
    }
  }



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
                loadingStepIndicator("3/6", 0.5),
                backButton(),
                SizedBox(height: 2.h),
                Obx(() =>
                  controller.isPreferences.value == true ?
                  customText(
                    text: "${controller.title} Food Boundaries & Beliefs",
                    fontSize: 23.sp,
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
                  itemCount: allergens.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Obx(() =>
                      progressBar(
                        allergens[index]['progress'], // RxDouble
                        allergens[index]['title'],
                        getAllergyType(allergens[index]['progress'].value),
                        // allergens[index]['desc'],
                        circleImg: allergens[index]['circleImg'],
                      ),
                    );

                  },
                ),

                /// Other Allergens
                Obx(
                      () => controller.other.value
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
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                          "Lorem ipsum dolor sit amet consectetur. Nec arcu enim consequat pulvinar proin urna ac tempus. Nulla viverra dui tellus nisi mont es sit tellus ac pellentesque.",
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
                        onTap: () {},
                      ),
                    ],
                  )
                      : others(
                    title: "Others",
                    path: "assets/png/icons/others_icon.png",
                  ),
                ),
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

                /// Continue Button
                buttonWidget(
                  "Continue",
                  whiteColor,
                  colors: greenColor,
                  onTap: () {
                    Get.toNamed("yourrootandrules");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Progress Bar Widget
Widget progressBar(RxDouble progress, String title, String desc,{String? circleImg}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 1.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(text: title, fontSize: 16.sp),
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
                            child: customText(
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
