import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/widget/back_button_widget.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import '../../../constants/constants_widgets.dart';
import '../../../controllers/profile_controller.dart';

class FoodPreferencesOne extends StatelessWidget {
  FoodPreferencesOne({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // scrollDirection default vertical hi hota hai
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        backButton(),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Get.toNamed("foodpreferencestwo");
                          },
                          child: customText(
                            text: "Skip",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: greenColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.8.h),
                    customText(
                      text: "Your Taste Personality",
                      fontSize: 23.sp,
                      fontFamily: "CormorantGaramond",
                      fontWeight: FontWeight.w600,
                    ),
                    customText(
                      text: "Love it or leave it? How do you feel about these polarizing foods?",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: darkGreyColor,
                    ),
                    SizedBox(height: 3.h),
                    customText(
                      text: "Yuck or Yum?",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'CormorantGaramond',
                    ),
                  ],
                ),
              ),

              // FIXED: SizedBox ki fixed height (98.h) hata di
              // shrinkWrap: true use kiya taake list content ke hisab se adjust ho
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Scroll parent sambhalega
                itemCount: controller.yuckOrYumList.length,
                separatorBuilder: (context, index) => Divider(
                    height: 0.h,
                    color: Colors.grey.shade200
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: customText(
                                text: controller.yuckOrYumList[index],
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Yum Button
                            Obx(() => _buildToggleButton(
                              label: '😋 Yum',
                              isSelected: controller.foodSelections[index] == 1,
                              onTap: () => controller.updateFoodSelection(index, 1),
                            )),
                            SizedBox(width: 2.w),
                            // Yuck Button
                            Obx(() => _buildToggleButton(
                              label: '😝 Yuck',
                              isSelected: controller.foodSelections[index] == 2,
                              onTap: () => controller.updateFoodSelection(index, 2),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.8.h),
                        child: Divider(color: greyBorderColor),
                      )
                    ],
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.all(6.w),
                child: buttonWidget(
                  "Continue",
                  whiteColor,
                  colors: greenColor,
                  borderColor: greenColor,
                  onTap: () => Get.toNamed("foodpreferencestwo"),
                ),
              ),
              // Extra space for bottom safe area if needed
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 3.6.h,
        width: 20.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: isSelected ? greenColor : backgroundColor,
          border: Border.all(color: isSelected ? greenColor : greyBorderColor),
        ),
        child: Center(
          child: customText(
            text: label,
            fontSize: 14.sp,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
