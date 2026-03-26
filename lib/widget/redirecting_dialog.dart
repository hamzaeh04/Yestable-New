import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yestable/constants/color_constants.dart';

import '../constants/constants_widgets.dart';

void showRedirectingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return _RedirectingDialogContent();
    },
  );
}

class _RedirectingDialogContent extends StatefulWidget {
  @override
  State<_RedirectingDialogContent> createState() =>
      _RedirectingDialogContentState();
}

class _RedirectingDialogContentState
    extends State<_RedirectingDialogContent>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// 🔥 Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();

    /// 🔥 Open dialer after 2 sec
    Future.delayed(Duration(seconds: 2), () {
      _launchDialer();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 📞 Open Dial Pad with 911
  Future<void> _launchDialer() async {
    final Uri url = Uri.parse("tel:911");

    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint("Dialer error: $e");
    }
  }

  /// 🔥 Animated arrow
  Widget buildArrow(double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = (_controller.value + delay) % 1;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * value, 0),
            child: child,
          ),
        );
      },
      child: Image.asset(
        "assets/png/redirect_image.png",
        width: 20.w,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFFDF3F1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔥 Animated arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildArrow(0.0),
                SizedBox(width: 1.w),
                buildArrow(0.3),
                SizedBox(width: 1.w),
                buildArrow(0.6),
              ],
            ),

            SizedBox(height: 2.h),

            /// Title
            customText(
              text: "Redirecting to Dialpad.",
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "CormorantGaramond",
            ),

            SizedBox(height: 1.h),

            /// Subtitle
            customText(
              text:
              "Please hold on for immediate assistance in an allergy emergency.",
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w400,
              color: darkGreyColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
