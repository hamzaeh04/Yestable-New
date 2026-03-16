import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/customTextField.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


Future<void> menuFormDialog(BuildContext context) {

  final AuthController authController = Get.find<AuthController>();
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {

          return Dialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Title
                    Center(
                      child: customText(
                        text: "Add Item",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 15.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.sp),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/png/event_widget_icon/event.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: lightgreenColor.withAlpha(250),
                                      borderRadius: BorderRadius.circular(30.sp),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/png/icons/gallery.png",
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2.w),
                                        customText(
                                          text: "Select a cover photo",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 1.h,
                                    right: 2.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.7.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5D8783).withOpacity(0.75),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.delete_outline_sharp, color: whiteColor, size: 4.w),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Obx(
                          () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          value: authController.selectedCategory.value,
                          hint: customText(text: "Select Type", fontSize: 15.sp
                          ),

                          items: authController.categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                              value: category,
                              child: customText(text: category,fontSize: 15.sp),
                            ),
                          )
                              .toList(),

                          onChanged: (String? newValue) {
                            authController.selectedCategory.value = newValue;
                          },

                          // ---------------- FIELD ----------------
                          isExpanded: true, // field takes full width
                          buttonStyleData: ButtonStyleData(
                            height: 5.h,
                            padding: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(color: greyBorderColor),
                            ),
                          ),

                          // ---------------- DROPDOWN ----------------
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: null, // ✅ intrinsic width
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            offset: const Offset(0, 4), // dropdown below field
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 1.h,),

                    CustomTextField(
                      hintText: 'Enter title',
                    ),
                    SizedBox(height: 1.h,),
                    CustomTextField(
                      hintText: 'Enter description',
                    ),
                    SizedBox(height: 1.h,),
                    CustomTextField(
                      hintText: 'Enter meal category',
                    ),
                    SizedBox(height: 2.h),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: buttonWidget("Cancel", greyTextColor, borderColor: Colors.black54, height: 4.h, fontsize: 15.5.sp, onTap: (){
                            Get.back();
                          })
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: buttonWidget("Save", whiteColor, colors: greenColor, height: 4.h, fontsize: 15.5.sp, onTap: (){
                            Get.back();
                          })
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

    },
  );
}
