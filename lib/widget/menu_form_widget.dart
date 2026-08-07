import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/utils/utility.dart';
import 'package:yestable/widget/button_widget.dart';
import 'package:yestable/widget/customTextField.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


Future<void> menuFormDialog(BuildContext context) {

  final EventController eventController = Get.find<EventController>();
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
                          child: Obx(() {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16.sp),
                              child: Stack(
                                children: [
                                  // 👇 Show API image if exists, else default asset
                                  eventController.itemPic.value != null
                                      ? Image.file(
                                    eventController.itemPic.value!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                      : Image.asset(
                                    "assets/png/event_widget_icon/event.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),

                                  // 👇 Top label / select button
                                  if (eventController.itemPic.value == null)
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: InkWell(
                                      onTap: () => eventController.pickFromGallery(),
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
                                              height: 18.sp,
                                              width: 18.sp,
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
                                  ),

                                  // 👇 Delete button
                                  if (eventController.itemPic.value != null)
                                    Positioned(
                                      top: 1.3.h,
                                      right: 2.5.w,
                                      child: InkWell(
                                        onTap: eventController.removeImage,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.7.h),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF5D8783).withOpacity(0.75),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.delete_outline_sharp,
                                            color: whiteColor,
                                            size: 5.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          })
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Obx(
                          () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          value: eventController.selectedType.value,
                          hint: customText(text: "Select Type", fontSize: 15.sp
                          ),

                          items: eventController.type
                              .map(
                                (category) => DropdownMenuItem<String>(
                              value: category,
                              child: customText(text: category,fontSize: 15.sp),
                            ),
                          )
                              .toList(),

                          onChanged: (String? newValue) {
                            eventController.selectedType.value = newValue;
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
                      controller: eventController.menuTitle,
                      height: 5.h,
                    ),
                    SizedBox(height: 1.h,),
                    CustomTextField(
                      height: 5.h,
                      hintText: 'Enter description',
                      controller: eventController.menuDescription,
                    ),
                    SizedBox(height: 1.h,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final selectedNames = eventController.selectedMealCategory
                              .map((e) => e["name"])
                              .join(", ");

                          return DropdownButtonHideUnderline(
                            child: DropdownButton2<Map<String, String>>(
                              hint: customText(
                                text: "Select meal category",
                                fontSize: 15.sp,
                              ),
                              items: eventController.mealCategory.map((category) {
                                return DropdownMenuItem<Map<String, String>>(
                                  value: category,
                                  child: Row(
                                    children: [
                                      // ✅ Image for this category
                                      if (category["imgPath"] != null && category["imgPath"]!.isNotEmpty)
                                        Image.asset(
                                          category["imgPath"]!,
                                          width: 22,
                                          height: 22,
                                          fit: BoxFit.cover,
                                        ),
                                      SizedBox(width: 8),
                                      customText(text: category["name"]!),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (selected) {
                                if (selected != null &&
                                    !eventController.selectedMealCategory
                                        .any((item) => item["name"] == selected["name"])) {
                                  eventController.selectedMealCategory.add(selected);
                                }
                              },
                              isExpanded: true,
                              buttonStyleData: ButtonStyleData(
                                height: 5.h,
                                padding: EdgeInsets.only(right: 2.w),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(20.sp),
                                  border: Border.all(color: greyBorderColor),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              selectedItemBuilder: (context) {
                                return [
                                  customText(
                                    text: selectedNames.isEmpty
                                        ? "Select meal category"
                                        : selectedNames,
                                    fontSize: 15.sp,
                                  ),
                                ];
                              },
                            ),
                          );
                        }),

                        const SizedBox(height: 10),

                        // ✅ Display selected items below
                        Obx(() {
                          return Wrap(
                            spacing: 4,
                            runSpacing: 8,
                            children: eventController.selectedMealCategory.map((item) {
                              return Chip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (item["imgPath"] != null && item["imgPath"]!.isNotEmpty)
                                      Image.asset(
                                        item["imgPath"]!,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    if (item["imgPath"] != null && item["imgPath"]!.isNotEmpty)
                                      SizedBox(width: 4),
                                    customText(text: item["name"]!),
                                  ],
                                ),
                                deleteIcon: Icon(Icons.close, size: 18),
                                onDeleted: () {
                                  eventController.selectedMealCategory
                                      .removeWhere((i) => i["name"] == item["name"]);
                                },
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                backgroundColor: Colors.grey[200],
                              );
                            }).toList(),
                          );
                        })
                      ],
                    ),
                    SizedBox(height: 2.h),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: buttonWidget("Cancel", greyTextColor, borderColor: Colors.black54, height: 4.h, fontsize: 15.5.sp, onTap: (){
                            Get.back();
                            eventController.clearItemFields();
                          })
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: buttonWidget("Save", whiteColor, colors: greenColor, height: 4.h, fontsize: 15.5.sp, onTap: (){
                            if (eventController.menuTitle.text.trim().isEmpty) {
                              Utils.showToast("Please enter a title", true);
                              return;
                            }
                            if (eventController.selectedType.value == null ||
                                eventController.selectedType.value!.isEmpty) {
                              Utils.showToast("Please select a menu type", true);
                              return;
                            }

                            eventController.uploadMenu();
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
