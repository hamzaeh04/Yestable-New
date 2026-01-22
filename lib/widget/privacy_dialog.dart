import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/profile_controller.dart';
import 'button_widget.dart';

Future privacyDialog(BuildContext context){
  final ProfileController controller = Get.find<ProfileController>();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: SizedBox(
          height: 82.h,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                    text: 'Terms & Conditions',
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp
                ),
                SizedBox(height: 1.h,),
                customText(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    fontSize: 13.5.sp
                ),
                SizedBox(height: 0.5.h,),
                customText(
                    text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Why do we use it It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
                    fontSize: 13.5.sp
                ),
                SizedBox(height: 0.5.h,),
                customText(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    fontSize: 13.5.sp
                ),
                SizedBox(height: 0.5.h,),
                customText(
                    text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Why do we use it It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.",
                    fontSize: 13.5.sp
                ),
                SizedBox(height: 1.5.h,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  buttonWidget(
                    height: 5.h,
                    fontsize: 15.sp,
                    "Agree",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      controller.checkBox(); // check it
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
