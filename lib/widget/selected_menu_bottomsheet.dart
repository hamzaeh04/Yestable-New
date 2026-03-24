import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/widget/button_widget.dart';
import '../constants/constants_widgets.dart';

void selectedMenuBottomSheet(BuildContext context) {
  final EventController eventController = Get.find<EventController>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: whiteColor,
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
              SizedBox(height: 1.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: 'Your Selected Menu',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "CormorantGaramond",
                      color: blackColor,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: blackColor,
                      ),
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

              SizedBox(height: 0.h),

              // Scrollable Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TabBarView(
                    children: [
                      _selectedMenusTab(eventController, "Appetizers"),
                      _selectedMenusTab(eventController, "Main Course"),
                      _selectedMenusTab(eventController, "Drinks"),
                    ],
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

Widget _selectedMenusTab(EventController eventController, String type) {
  return Obx(() {
    final items = eventController.selectedMenus
        .where((m) => (m.type ?? "").toLowerCase() == type.toLowerCase())
        .toList();

    if (items.isEmpty) {
      return Center(
        child: customText(
          text: "No menu selected",
          fontSize: 14.sp,
          color: darkGreyColor,
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Builder(builder: (context) {
              final m = items[i];
              final categories = (m.mealCategory ?? <String>[]);
              final text1 = categories.isNotEmpty ? categories[0] : "";
              final text2 = categories.length > 1 ? categories[1] : "";

              return menuItem(
                title: m.title ?? "",
                subtitle: m.description ?? "",
                imagePath: m.menuImage ?? "assets/png/event_detail_img/event1.png",
                text1: text1,
                text2: text2,
                boximg1: eventController.mealCategoryIcon(text1) ??
                    "assets/png/event_food_image/brocolli.png",
                boximg2: eventController.mealCategoryIcon(text2) ??
                    "assets/png/event_food_image/milk.png",
                cheaque: true,
                containerColor: whiteColor,
                ontap: () => eventController.removeSelectedMenuById(m.id),
              );
            }),
            Divider(),
          ],
        ],
      ),
    );
  });
}

Widget menuItem({
  required String title,
  required String subtitle,
  required String imagePath,
  required String text1,
  required String text2,
  required String boximg1,
  required String boximg2,
  bool? cheaque,
  Color? containerColor,
  VoidCallback? ontap,
}) {
  final baseService = BaseService();
  return Container(
    margin: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.8.h,
              ),
              customText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
                color: blackColor,
              ),
              SizedBox(height: 0.h),
              customText(
                text: subtitle,
                fontSize: 14.sp,
                color: darkGreyColor,
              ),
              SizedBox(height: 1.5.h),
              Wrap(
                spacing: 3.w,
                runSpacing: 1.h,
                children: [
                  if (text1.trim().isNotEmpty)
                    foodPreferenceBox(
                      text: text1,
                      imgPath: boximg1,
                      bgColor: containerColor,
                    ),
                  if (text2.trim().isNotEmpty)
                    foodPreferenceBox(
                      text: text2,
                      imgPath: boximg2,
                      bgColor: containerColor,
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 3.w),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: Builder(
                builder: (context) {
                  final trimmed = imagePath.trim();

                  if (trimmed.startsWith('http')) {
                    return Image.network(
                      trimmed,
                      height: 13.h,
                      width: 12.h,
                      fit: BoxFit.cover,
                    );
                  }

                  if (trimmed.startsWith('assets/')) {
                    return Image.asset(
                      trimmed,
                      height: 13.h,
                      width: 12.h,
                      fit: BoxFit.cover,
                    );
                  }

                  final fullUrl = "${baseService.baseURL}$trimmed";
                  return Image.network(
                    fullUrl,
                    height: 13.h,
                    width: 12.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            if (cheaque == true)
              Positioned(
                bottom: 1.h,
                right: 1.w,
                child: GestureDetector(
                  onTap: ontap,
                  child: Container(
                    height: 3.h,
                    width: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 2.h,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget foodPreferenceBox({
  required String text,
  required String imgPath,
  Color? bgColor,
}) {
  return InkWell(
    onTap: () {
      print(bgColor);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: Colors.grey, // 👈 Grey border color
          width: 0.1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imgPath,
            height: 16.sp,
            width: 16.sp,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 2.w),
          Flexible(
            child: customText(
              text: text,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

