import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/navigation_controller.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/button_widget.dart';

void hostReviewsBottomSheet(BuildContext context) {
  final NavigationController controller = Get.find<NavigationController>();

  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: "Reviews",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                      fontFamily: "CormorantGaramond",
                    ),
                    InkWell(
                      onTap: () => controller.backPage(),
                      child: Icon(Icons.close, color: blackColor),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),

              // Scrollable Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Row
                    Row(
                      children: [
                        customText(
                          text: "4.8",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                        ),
                        SizedBox(width: 2.w),
                        RatingBarIndicator(
                          rating: 5,
                          itemCount: 5,
                          itemSize: 19.sp,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                        ),
                        SizedBox(width: 1.w),
                        customText(
                          text: "25 Reviews",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Sort by Row
                    Row(
                      children: [
                        customText(
                          text: "Sort by: Recommended",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: blackColor,
                          fontFamily: "CormorantGaramond",
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 21.sp),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Sort Options
        Obx(
              () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.sortBy.length,
                    (index) {
                  bool isSelected = controller.sortBySelectedIndex.value == index;
                  bool isLastIndex = index == controller.sortBy.length - 1; // ✅ define this

                  return Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: GestureDetector(
                      onTap: () => controller.sortBySelectedIndex(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? greenColor
                              : greenColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(30.sp),
                        ),
                        child: Row(
                          children: [
                            if (isLastIndex) ...[
                              Image.asset(
                                'assets/png/icons/filter_icon.png',
                                height: 16.sp,
                                width: 16.sp,
                                color: isSelected ? whiteColor : greenColor,
                              ),
                              SizedBox(width: 2.w),
                            ],
                            customText(
                              text: controller.sortBy[index],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? whiteColor : greenColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Reviews Section
                     // Optional bottom padding
                  ],
                ),
              ),
              SizedBox(height: 1.5.h),
              Divider(),
              reveiws(),
              SizedBox(height: 1.h),
              Divider(),
              reveiws(),
              SizedBox(height: 1.h),
              reveiws(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    },
  );
}

Widget reveiws() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed("myprofilescreen");
  },
              child: GestureDetector(
                onTap: (){
                  Get.toNamed("hostprofilepcreen");
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.sp),
                      child: Image.asset(
                        "assets/png/chat_images/user1.png",
                        width: 12.w,
                        height: 12.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Elizabeth Smith",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: "CormorantGaramond",
                        ),
                        customText(
                          text: "1 Week Ago",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Row(
                children: [
              RatingBarIndicator(
                rating: 5,
                itemCount: 5,
                itemSize: 19.sp,
                physics: BouncingScrollPhysics(),
                itemBuilder:
                    (context, _) => Icon(Icons.star, color: Colors.amber),
              ),
              customText(
                text: "Love It!",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ]
            ),
            SizedBox(height: 1.h),
            customText(
              text: "Review For:  Sofia Lunch Event",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: darkGreyColor,
            ),
            SizedBox(height: 1.h),
            customText(
              text: "“Lorem ipsum dolor sit amet consectetur. Viverra tellus eget magna sapien. Faucibus nibh mauris mattis aliquam proin pellentesque sed done Nu lla sed cons memagnat consectetur. Viv emauris rra tellus eget magna sapieneget”",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: darkGreyColor,
            ),
            SizedBox(height: 1.h),
            Row(
              children: List.generate(3, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index != 2 ? 2.w : 0.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                    child: Image.asset(
                      'assets/png/reveiw_images/reveiw${index + 1}.png',
                      width: 28.w,
                      height: 12.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              ),
            ),SizedBox(height: 1.h),
            Row(
              children: List.generate(2, (index) {
                int actaulIndex = index + 2;
                return Padding(
                  padding: EdgeInsets.only(right: index != 2 ? 2.w : 0.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18.sp)),
                    child: Image.asset(
                      'assets/png/reveiw_images/reveiw${actaulIndex + 1}.png',
                      width: 28.w,
                      height: 12.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
