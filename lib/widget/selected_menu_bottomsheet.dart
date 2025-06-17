import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/constants_widgets.dart';
import '../views/guest_screens/dashboard/event_details_screen.dart';

void selectedMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFFF6F0EC),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.sp)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // Title Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: 'Your Selected Menu',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "CormorantGaramond",
                      color: blackColor,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.keyboard_arrow_down, size: 18.sp),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: TabBar(
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
              ),

              SizedBox(height: 1.h),

              // Scrollable Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        menuItem(
                          title: "Caprese Skewers",
                          subtitle: "Cherry Tomatoes, Fresh Mozzarella, Basil, Balsamic Glaze",
                          imagePath: "assets/png/event_detail_img/event1.png",
                          text1: "Vegetarian",
                          text2: "Contain Dairy",
                          boximg1: "assets/png/event_food_image/brocolli.png",
                          boximg2: "assets/png/event_food_image/milk.png",
                          cheaque: true,
                        ),
                        Divider(),
                        menuItem(
                          title: "Avocado Shrimp Ceviche",
                          subtitle: "Shrimp, Avocado, Lime, Red Onion, Cilantro, Tomato",
                          imagePath: "assets/png/event_detail_img/event2.png",
                          text1: "Gluten Free",
                          text2: "Shellfish",
                          boximg1: "assets/png/event_food_image/glutenfree.png",
                          boximg2: "assets/png/event_food_image/shell.png",
                          cheaque: true,
                        ),
                        Divider(),
                        menuItem(
                          title: "Spiced Chickpea Falafel",
                          subtitle: "Chickpeas, Garlic, Cumin, Parsley, Tahini Dip",
                          imagePath: "assets/png/event_detail_img/event3.png",
                          text1: "Vegan",
                          text2: "Nut Free",
                          boximg1: "assets/png/event_food_image/vegan.png",
                          boximg2: "assets/png/event_food_image/nutfree.png",
                          cheaque: true,
                        ),
                        Divider(),
                        menuItem(
                          title: "Stuffed Mushrooms",
                          subtitle: "Cremini Mushrooms, Cream Cheese, Garlic, Breadcrumbs",
                          imagePath: "assets/png/event_detail_img/event1.png",
                          text1: "Vegetarian",
                          text2: "Contain Dairy",
                          boximg1: "assets/png/event_food_image/glutenfree.png",
                          boximg2: "assets/png/event_food_image/milk.png",
                          cheaque: true,
                        ),
                        Divider(),
                        menuItem(
                          title: "Mango Salsa & Chips",
                          subtitle: "Mango, Red Bell Pepper, Jalapeño, Lime, Corn Tortilla Chips",
                          imagePath: "assets/png/event_detail_img/event2.png",
                          text1: "Gluten Free",
                          text2: "Shellfish",
                          boximg1: "assets/png/event_food_image/vegan.png",
                          boximg2: "assets/png/event_food_image/milk.png",
                          cheaque: true,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

