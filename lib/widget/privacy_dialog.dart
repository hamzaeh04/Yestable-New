import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/profile_controller.dart';
import 'button_widget.dart';

Future privacyDialog(BuildContext context) {
  final ProfileController controller = Get.find<ProfileController>();

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 85.h,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                customText(
                  text: "YesTable Privacy Policy",
                  fontWeight: FontWeight.w600,
                  fontSize: 19.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "Effective Date: April 20, 2026\nLast Updated: April 20, 2026",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "Welcome to YesTable, a product of Siren Theory LLC (“YesTable,” “we,” “our,” or “us”). We believe thoughtful hosting starts with trust. This Privacy Policy explains how we collect, use, and protect your information when you use the YesTable app, website, and related services (collectively, the “Platform”).",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "We collect information to help you create better, safer, and more inclusive gatherings. This includes information you provide directly, such as your name, username, email address, and profile details, as well as dietary preferences, allergies, restrictions, and event-related information like guest lists and responses. You may also choose to provide optional information, such as your location (at the city level), pronouns, Food Mood tracking data, and photos or profile images. In addition, we automatically collect certain technical information, including device type, browser, usage patterns, and log data such as IP address and timestamps.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "We use your information to operate and improve the Platform. This includes facilitating communication between hosts and guests, matching preferences with accommodations, improving functionality, and providing insights such as Food Mood trends where applicable. We may also use your information to communicate with you about updates, support inquiries, and important notices. We do not sell your personal data.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "We share your information only in limited and expected ways. For example, information you choose to provide may be visible to other users as necessary for event planning, such as when a host views guest preferences. We may also share information with trusted service providers who help us operate the Platform, such as hosting, analytics, and email services. In certain circumstances, we may disclose information if required by law or to protect the rights, safety, and integrity of YesTable and its users.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "YesTable may include information related to allergies, dietary restrictions, and food-related experiences. This information is provided by you at your discretion and is used solely to enhance the user experience and support better event planning. It is not intended as medical advice, diagnosis, or treatment. You are responsible for determining what information you choose to share and with whom.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "We take reasonable administrative, technical, and physical measures to protect your information. However, no system is completely secure, and use of the Platform is at your own risk.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "You remain in control of your information. You can update your profile, adjust what you share with others, and request deletion of your account at any time, subject to legal obligations. To request access to or deletion of your data, please contact us at hello@yes-table.com.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "YesTable is not intended for children under the age of 13, and we do not knowingly collect personal information from children.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "If you are a California resident, you may have rights under the California Consumer Privacy Act (CCPA), including the right to know what personal information we collect, the right to request deletion, and the right to correct inaccurate information. To exercise these rights, please contact us at hello@yes-table.com.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "The Platform may include links to or integrations with third-party services. We are not responsible for the privacy practices of those third parties.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "We may update this Privacy Policy from time to time. When we do, we will update the “Last Updated” date and provide notice where appropriate.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "If you have any questions or concerns about this Privacy Policy, you may contact YesTable (Siren Theory LLC) at 3579 E. Foothill Blvd, Suite #709, Pasadena, CA 91107 or hello@yes-table.com.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 1.h),

                customText(
                  text:
                  "YesTable is built around one simple idea: everyone deserves a seat at the table. Your information helps make that possible, but you remain in control of what you share.",
                  fontSize: 13.5.sp,
                ),

                SizedBox(height: 2.h),

                Align(
                  alignment: Alignment.center,
                  child: buttonWidget(
                    height: 5.h,
                    fontsize: 15.sp,
                    "Agree",
                    whiteColor,
                    colors: greenColor,
                    onTap: () {
                      controller.checkBox();
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
