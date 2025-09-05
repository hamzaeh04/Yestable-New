import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/event_dialog.dart';
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
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                        fontFamily: "CormorantGaramond",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // Main Scrollable Body with Rounded Corners
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
                                      text: "Allergen Analytics",
                                      fontSize: 20.sp,
                                      fontFamily: "CormorantGaramond",
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                    customText(
                                      text: "Your guests' safety, visualized.",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    color: whiteColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            customText(
                                              text: "Guest Taste preferences",
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "CormorantGaramond",
                                              color: blackColor,
                                            ),
                                            customText(
                                              text: "18 Guest",
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              color: darkGreyColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.h),
                                        Image.asset("assets/png/pie_chart.png", fit: BoxFit.contain),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buttonWidget(
                                      "Ai Suggested",
                                      whiteColor,
                                      colors: greenColor,
                                      width: 43.w,
                                      height: 4.5.h,
                                      fontsize: 14.sp,
                                      onTap: (){
                                        Get.toNamed("yesgptscreen");
                                      }
                                    ),
                                    buttonWidget(
                                      "Manually Picked",
                                      blackColor,
                                      colors: backgroundColor,
                                      width: 43.w,
                                      height: 4.5.h,
                                      borderColor: greenColor,
                                      fontsize: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Column(
                                  children: [
                                    DefaultTabController(
                                      length: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TabBar(
                                            labelColor: Colors.black,
                                            unselectedLabelColor: Colors.grey,
                                            indicatorColor: Colors.black,
                                            indicatorWeight: 2,
                                            tabs: const [
                                              Tab(text: "Appetizers"),
                                              Tab(text: "Main Course"),
                                              Tab(text: "Drinks"),
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          SizedBox(
                                            height: 32.h,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 2.w),
                                                  menuItem(
                                                    title: "Caprese Skewers",
                                                    subtitle: "Cherry Tomatoes, Fresh Mozzarella, Basil, Balsamic Glaze",
                                                    imagePath: "assets/png/event_detail_img/event1.png",
                                                    text1: "Vegetarian",
                                                    text2: "Containt Dairy",
                                                    boximg1: "assets/png/event_food_image/brocolli.png",
                                                    boximg2: "assets/png/event_food_image/milk.png",
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  menuItem(
                                                    title: "Avocado Shrimp Ceviche",
                                                    subtitle: "Shrimp, Avocado, Lime, Red Onion, Cilantro, Tomato",
                                                    imagePath: "assets/png/event_detail_img/event2.png",
                                                    text1: "Gluten Free",
                                                    text2: "Shellfish",
                                                    boximg1: "assets/png/event_food_image/glutenfree.png",
                                                    boximg2: "assets/png/event_food_image/shell.png",
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  menuItem(
                                                    title: "Spiced Chickpea Falafel",
                                                    subtitle: "Chickpeas, Garlic, Cumin, Parsley, Tahini Dip",
                                                    imagePath: "assets/png/event_detail_img/event3.png",
                                                    text1: "Vegan",
                                                    text2: "Nut Free",
                                                    boximg1: "assets/png/event_food_image/vegan.png",
                                                    boximg2: "assets/png/event_food_image/nutfree.png",
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  menuItem(
                                                    title: "Stuffed Mushrooms",
                                                    subtitle: "Cremini Mushrooms, Cream Cheese, Garlic, Breadcrumbs",
                                                    imagePath: "assets/png/event_detail_img/event1.png",
                                                    text1: "Vegetarian",
                                                    text2: "Containt Dairy",
                                                    boximg1: "assets/png/event_food_image/glutenfree.png",
                                                    boximg2: "assets/png/event_food_image/milk.png",
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  menuItem(
                                                    title: "Mango Salsa & Chips",
                                                    subtitle: "Mango, Red Bell Pepper, Jalapeño, Lime, Corn Tortilla Chips",
                                                    imagePath: "assets/png/event_detail_img/event2.png",
                                                    text1: "Gluten Free",
                                                    text2: "Shellfish",
                                                    boximg1: "assets/png/event_food_image/vegan.png",
                                                    boximg2: "assets/png/event_food_image/milk.png",
                                                  ),
                                                  SizedBox(width: 2.w),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h), // Give space for bottom panel
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
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        ),
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
          fontSize: 18.sp,
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
