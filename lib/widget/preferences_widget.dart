import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yestable/constants/constants_widgets.dart';

Widget preferencesWidget(String title) {
  return Theme(
    data: Theme.of(Get.context!).copyWith(
      dividerColor: Colors.transparent,  // removes the default divider line
    ),
    child: ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 0), // reduce horizontal padding
      childrenPadding: EdgeInsets.zero, // optional: reduce padding inside expanded content
      title: customText(text: title),
      // If you want no trailing icons spacing, set below
      // trailing: null, // if you want to remove arrow icons (optional)
    ),
  );
}
