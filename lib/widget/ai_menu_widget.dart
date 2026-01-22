import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/widget/button_widget.dart';

class FoodMenuCard extends StatelessWidget {
  const FoodMenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w, // Adjust based on your layout
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              'assets/png/profile_food_images/selected_menu_image.png', // Replace with your asset
              height: 11.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w
            ),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h,),
                // 2. Title and Button Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          customText(
                            text: 'Grilled Lemon Herb',
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'CormorrantGaramond',
                            height: 1
                          ),
                          // SizedBox(height: 0.8.h),

                          customText(
                            text: 'Gluten-Free, Nut-Free',
                            fontSize: 15.sp,
                            color: Colors.black.withValues(alpha: 0.5)
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    // Add To Menu Button
                    SizedBox(
                      width: 30.w,
                        height: 3.6.h,
                        child: buttonWidget('Add To Menu', whiteColor,colors: greenColor,fontsize: 15.sp))
                  ],
                ),

                SizedBox(height: 1.5.h),

                // 3. Chips Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip('👦 Kid-Friendly'),
                      const SizedBox(width: 8),
                      _buildChip('😚 Mild Flavor'),
                      const SizedBox(width: 8),
                      _buildChip('🥘 Crowd Pleaser'),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: customText(
        text: label,
        fontSize: 14.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4
      ),
    );
  }
}
