//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../constants/color_constants.dart';
// import '../constants/constants_widgets.dart';
// import '../controllers/navigation_controller.dart';
// import 'home_screen_widget.dart';
//
// Widget customAppBar(){
//   final NavigationController controller = Get.find<NavigationController>();
//   return Row(
//     children: [
//       customAppBar(),
//       const Spacer(),
//       InkWell(
//           onTap: (){
//             controller.goTSearchScreen();
//           },
//           child: homeIconWidget(icon: Icons.search)
//       ),
//       SizedBox(width: 2.w),
//       InkWell(
//           onTap: (){
//             controller.goToNotificationPage();
//           },
//           child: homeIconWidget(icon: Icons.notifications)),
//     ],
//   );
// }
