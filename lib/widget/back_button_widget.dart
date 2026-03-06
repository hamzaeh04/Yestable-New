import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';

Widget backButton() {
  return InkWell(
    onTap: (){
      print("Back pressed");
      Get.back();
    },
    child: Container(
      padding: EdgeInsets.all(1.5.h), // instead of fixed height/width
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: greenColor,
      ),
      child: Icon(
        Icons.arrow_back_ios_new,
        color: whiteColor,
        size: 16,
      ),
    ),
  );
}

