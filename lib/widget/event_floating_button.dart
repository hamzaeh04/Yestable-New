import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/controllers/event_controller.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

Widget buildCreateNewEventButton(BuildContext context) {
  EventController eventController = Get.find<EventController>();
  return SizedBox(
    height: 27.sp, // 🔁 Adjust height here
    child: FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed("createneweventscreen", arguments: null);
        eventController.clearEventFields();
      },
      label: Row(
        children: [
          Icon(Icons.add, size: 20.sp, color: Colors.white),
          SizedBox(width: 2.w),
          customText(
            text: "Create an Event",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: blueColor,
      // ✅ use your desired color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.sp)),
      elevation: 5,
    ),
  );
}
