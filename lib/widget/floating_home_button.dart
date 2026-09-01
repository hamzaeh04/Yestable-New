import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';

Widget floatingHomeButton({
  required Widget screen,
  bool isProfileSetup = false,
}) {
  final controller = Get.find<NavigationController>();

  return Builder(
    builder: (context) {
      controller.initialize(context);

      return Stack(
        children: [
          screen,

          Obx(
            () {
              if (isProfileSetup && controller.controller.isEdit.value == false) {
                return const SizedBox.shrink();
              }
              return Positioned(
                left: controller.left.value,
                top: controller.top.value,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    controller.updatePosition(
                      details,
                      context,
                    );
                  },
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: (){
                      Get.offAllNamed("bottomnavigationbar");
                      controller.changePage(0);
                    },
                    backgroundColor: greenColor,
                    child: const Icon(Icons.home, color: greyBorderColor,),
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}