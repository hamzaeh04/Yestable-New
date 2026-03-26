// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:yestable/constants/color_constants.dart';
// import 'package:yestable/constants/constants_widgets.dart';
// import 'package:yestable/controllers/profile_controller.dart';
// import 'package:yestable/widget/loading_step_indicator.dart';
// import 'package:yestable/widget/picture_upload_bottomsheet.dart';
//
// import '../../../widget/button_widget.dart';
//
// class AddHostProfilePicture extends StatelessWidget {
//   AddHostProfilePicture({super.key});
//   ProfileController controller = Get.fin
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,  // outer column alignment
//           children: [
//             // Progress bar
//             Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
//                 child: loadingStepIndicator("0/3", 0.02)
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 6.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,  // <-- add this
//                 children: [
//                   SizedBox(height: 1.h),
//                   customText(
//                     text: "Add A Profile Picture",
//                     fontSize: 24.sp,
//                     fontFamily: "CormorantGaramond",
//                     fontWeight: FontWeight.w600,
//                   ),
//                   customText(
//                     text: "Lorem ipsum dolor sit amet consectetur. Tincidunt\ndiam ligula leo scelerisque volutpat.",
//                     fontSize: 16.sp,
//                     fontFamily: "CormorantGaramond",
//                     fontWeight: FontWeight.w600,
//                   ),
//                   SizedBox(height: 7.h),
//                   Center(
//                     child: Container(
//                       height: 20.h,
//                       width: 45.w,
//                       decoration: BoxDecoration(
//                         color: greenColor,
//                         borderRadius: BorderRadius.circular(15.sp),
//                       ),
//                       child: Center(
//                         child: Image.asset(
//                           "assets/png/profile_image_large.png",
//                           height: 30.h,
//                           width: 30.w,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 21.5.h),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 1.h), // Adjust as needed
//                     child: buttonWidget(
//                       "Add Picture",
//                       whiteColor,
//                       colors: greenColor,
//                       onTap: () {
//                         pictureUpload(context);
//                       },
//                     ),
//                   ),
//                   buttonWidget(
//                     "Skip",
//                     greenColor,
//                     borderColor: greenColor,
//                     onTap: () {
//                       Get.toNamed("hosteditprofilescreen");
//
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
