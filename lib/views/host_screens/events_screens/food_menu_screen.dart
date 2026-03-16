import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/ai_menu_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/event_dialog.dart';
import 'package:yestable/widget/menu_form_widget.dart';
import 'package:yestable/widget/redirecting_dialog.dart';
import 'package:yestable/widget/selected_menu_bottomsheet.dart';
import '../../../widget/home_screen_widget.dart';

class FoodMenuScreen extends StatelessWidget {
  FoodMenuScreen({super.key});

  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: Row(
                    children: [
                      homeIconWidget(
                        icon: Icons.arrow_back_ios_new,
                        color: lightgreenColor,
                        iconsize: 16.sp,
                        onTap: () {
                          Get.back();
                        },
                      ),
                      SizedBox(width: 2.w),
                      customText(
                        text: "Select Your Food Menu",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                        fontFamily: "CormorantGaramond",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // Main Scrollable Body with Rounded Corners
                SizedBox(
                  height: 80.h,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      text: "Food preferences",
                                      fontSize: 20.sp,
                                      fontFamily: "CormorantGaramond",
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                      height: 0.13.h
                                    ),
                                    // customText(
                                    //   text: "Your guests' safety, visualized.",
                                    //   fontSize: 14.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   color: darkGreyColor,
                                    // ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 2.h),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                              //   child: Container(
                              //     width: double.infinity,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20.sp),
                              //       color: whiteColor,
                              //     ),
                              //     child: Padding(
                              //       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              //       child: Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               customText(
                              //                 text: "Guest Taste preferences",
                              //                 fontSize: 17.sp,
                              //                 fontWeight: FontWeight.w600,
                              //                 fontFamily: "CormorantGaramond",
                              //                 color: blackColor,
                              //               ),
                              //               customText(
                              //                 text: "18 Guest",
                              //                 fontSize: 13.sp,
                              //                 fontWeight: FontWeight.w400,
                              //                 color: darkGreyColor,
                              //               ),
                              //             ],
                              //           ),
                              //           SizedBox(height: 2.h),
                              //           Image.asset("assets/png/pie_chart.png", fit: BoxFit.contain),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         buttonWidget(
                                //           "YesTable Menu (AI)",
                                //           image: Image.asset('assets/png/chat_images/yesGPT.png', width: 5.w,),
                                //           whiteColor,
                                //           colors: greenColor,
                                //           width: 43.w,
                                //           height: 4.5.h,
                                //           fontsize: 14.sp,
                                //           onTap: (){
                                //
                                //           }
                                //         ),
                                //       ],
                                //     ),
                                //     buttonWidget(
                                //       "Manually Picked",
                                //       blackColor,
                                //       colors: backgroundColor,
                                //       width: 43.w,
                                //       height: 4.5.h,
                                //       borderColor: greenColor,
                                //       fontsize: 14.sp,
                                //     ),
                                //   ],
                                // ),
                                child: Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buttonWidget(
                                      "YesTable Menu (AI)",
                                      image: Image.asset(
                                        'assets/png/chat_images/yesGPT.png',
                                        width: 5.w,
                                      ),
                                      controller.isYesTableSelected.value ? whiteColor:blackColor,
                                      colors: controller.isYesTableSelected.value
                                          ? greenColor
                                          : backgroundColor,
                                      borderColor: greenColor.withValues(alpha: 0.3),
                                      width: 43.w,
                                      height: 4.5.h,
                                      fontsize: 14.sp,
                                      onTap: controller.selectYesTable,
                                    ),

                                    buttonWidget(
                                      "Manually Picked",
                                      controller.isYesTableSelected.value ? blackColor:whiteColor,
                                      colors: controller.isYesTableSelected.value
                                          ? backgroundColor
                                          : greenColor,
                                      borderColor: greenColor.withValues(alpha: 0.3),
                                      width: 43.w,
                                      height: 4.5.h,
                                      fontsize: 14.sp,
                                      onTap: controller.selectManual,
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(height: 0.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Column(
                                  children: [
                                    DefaultTabController(
                                      length: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(height: 1.h),
                                          Obx(() {
                                            if (controller.isYesTableSelected.value) {
                                              /// ✅ YesTable Menu Selected (VERTICAL LIST)
                                              return Column(
                                                children: [
                                                  Container(
                                                    //margin: EdgeInsets.symmetric(horizontal: 5.w),
                                                    height: 5.5.h,
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(right: 2.w, left: 4.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(25.sp),
                                                      border: Border.all(color: lightgreenColor),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontFamily: "WorkSans",
                                                            ),
                                                            decoration: InputDecoration(
                                                              hintText: '"Suggest a brunch for this group!"',
                                                              hintStyle: TextStyle(
                                                                fontSize: 14.5.sp,
                                                                color: Colors.black.withValues(alpha: 0.6),
                                                              ),
                                                              border: InputBorder.none,       // ✅ remove border
                                                              enabledBorder: InputBorder.none,
                                                              focusedBorder: InputBorder.none,
                                                              disabledBorder: InputBorder.none,
                                                              isDense: true,
                                                              contentPadding: EdgeInsets.zero,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 5.2.h,
                                                          width: 9.w,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: greenColor,
                                                          ),
                                                          child: Image.asset('assets/png/chat_images/circle.png'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 0.8.h,),
                                                  SizedBox(
                                                    height: 4.h,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Row(
                                                        children: [
                                                          list('Suggest a brunch menu this group would like'),
                                                          SizedBox(width: 2.w,),
                                                          list('Suggest a brunch menu this group would like'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24.h,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Row(
                                                        children: [
                                                          FoodMenuCard(),
                                                          SizedBox(width: 2.w),
                                                          FoodMenuCard(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              /// ✅ Manual Menu Selected (HORIZONTAL LIST)
                                              return Column(
                                                children: [

                                                  TabBar(
                                                    labelColor: Colors.black,
                                                    unselectedLabelColor: Colors.grey,
                                                    indicatorColor: Colors.black,
                                                    indicatorWeight: 2,

                                                    labelStyle: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "WorkSans",
                                                    ),
                                                    // unselectedLabelStyle: TextStyle(
                                                    //   fontSize: 14.sp,
                                                    //   fontWeight: FontWeight.w400,
                                                    //   fontFamily: "WorkSans",
                                                    // ),

                                                    tabs: const [
                                                      Tab(text: "Appetizers"),
                                                      Tab(text: "Main Course"),
                                                      Tab(text: "Drinks"),
                                                    ],
                                                  ),

                                                  SizedBox(height: 0.7.h,),
                                                  SizedBox(
                                                    height: 32.h,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 2.w),
                                                          menuItem(
                                                            title: "Caprese Skewers",
                                                            subtitle:
                                                            "Cherry Tomatoes, Fresh Mozzarella, Basil, Balsamic Glaze",
                                                            imagePath: "assets/png/event_detail_img/event1.png",
                                                            text1: "Vegetarian",
                                                            text2: "Containt Dairy",
                                                            boximg1: "assets/png/event_food_image/brocolli.png",
                                                            boximg2: "assets/png/event_food_image/milk.png",
                                                          ),
                                                          SizedBox(width: 3.w),
                                                          menuItem(
                                                            title: "Avocado Shrimp Ceviche",
                                                            subtitle:
                                                            "Shrimp, Avocado, Lime, Red Onion, Cilantro, Tomato",
                                                            imagePath: "assets/png/event_detail_img/event2.png",
                                                            text1: "Gluten Free",
                                                            text2: "Shellfish",
                                                            boximg1: "assets/png/event_food_image/glutenfree.png",
                                                            boximg2: "assets/png/event_food_image/shell.png",
                                                          ),
                                                          SizedBox(width: 2.w),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h), // Give space for bottom panel
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// ⬇️ Bottom Confirm Panel
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text: "Your Selected Menu",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "CormorantGaramond",
                          color: blackColor,
                        ),
                        InkWell(
                          onTap: (){
                            selectedMenuBottomSheet(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            size: 20.sp,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    buttonWidget(
                      "Continue",
                      whiteColor,
                      colors: greenColor,
                      width: double.infinity,
                      height: 5.h,
                      fontsize: 16.sp,
                      onTap: () {
                        Get.toNamed("eventcomfortone");
                      },
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: FloatingActionButton(
          backgroundColor: greenColor,
          shape: CircleBorder(),
          onPressed: (){
            menuFormDialog(context);
        },
        child: Icon(Icons.add, color: whiteColor,),),
      ),
    );
  }
}


Widget menuItem({
  required String title,
  required String subtitle,
  required String imagePath,
  required String text1,
  required String text2,
  required String boximg1,
  required String boximg2,
}) {
  return Container(
    width: 53.w,
    margin: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: Image.asset(
                imagePath,
                height: 15.h,
                width: 53.w,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.5.h,
              right: 0.5.h,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  )],
                ),
                child: Icon(
                  Icons.add,
                  size: 17.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        customText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: "CormorantGaramond",
          color: blackColor,
        ),
        SizedBox(height: 0.3.h),
        customText(
          text: subtitle,
          fontSize: 14.sp,
          color: darkGreyColor,
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            foodPreferenceBox(text: text1, imgPath: boximg1),
            SizedBox(width: 2.w),
            foodPreferenceBox(text: text2, imgPath: boximg2),
          ],
        ),
      ],
    ),
  );
}

Widget foodPreferenceBox({
  required String text,
  required String imgPath,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: Colors.grey,
          width: 0.1.w,
        )
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imgPath,
          height: 14.sp,
          width: 14.sp,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 1.5.w),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
Widget list(String title){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
    height: 3.5.h,
    // width: 10.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.sp),
        border: Border.all(color: Colors.grey)
    ),
    child: customText(
        textAlign: TextAlign.center,
        text: title,
        fontSize: 14.sp
    ),
  );
}
