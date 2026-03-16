import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/views/guest_screens/chat_screens/chat_list_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/add_freind_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/community_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/event_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/user_home_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/my_notification_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/search_screen.dart';
import 'package:yestable/views/guest_screens/profile_setup_screens/host_profile_screen.dart';
import 'package:yestable/views/host_screens/dashboard/host_home_screen.dart';

import '../dashboard/my_profile_screen.dart';
import '../dashboard/viewall_invitation_screen.dart';
import '../profile_setup_screens/community_profile.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>     {
  final NavigationController controller = Get.find<NavigationController>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: controller.currentIndex.value);


    // Expose this page controller to the controller manually
    controller.setPageController(_pageController);

    // Listen to current index and move page
    controller.currentIndex.listen((index) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(index);
      }
    });
    controller.controller.fetchMyProfile();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> pages = [
    Obx(() => Get.find<NavigationController>().isUser.value ? HomeScreen() : AdminHomeScreen()),
    EventScreen(),
    // CommunityScreen(),
    ChatListScreen(),
    MyProfileScreen(),
    // Obx(() => Get.find<NavigationController>().isUser.value ? MyProfileScreen() : HostProfileScreen()),
    ViewallInvitationScreen(),
    MyNotificationScreen(),
    SearchScreen(),
    AddFreindScreen(),
    CommunityProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.sp),
          topLeft: Radius.circular(30.sp),
        ),
        child: Container(
          height: 10.h,
          color: greenColor,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem("assets/png/bottom_bar_icons/home_icon.png", 0, 'Home'),
              navItem("assets/png/bottom_bar_icons/event_icon.png", 1, 'Event'),
              // navItem("assets/png/bottom_bar_icons/community_icon.png", 2, 'Community'),
              navItem("assets/png/bottom_bar_icons/chat_icon.png", 2, 'Chat'),
              navItem("assets/png/bottom_bar_icons/profile_icon.png", 3, 'My Profile'),
            ],
          )),
        ),
      ),
    );
  }

  Widget navItem(String iconPath, int index, String label) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 20.sp, color: isSelected ? whiteColor : Colors.grey),
            SizedBox(height: 0.5.h),
            Text(label, style: TextStyle(fontSize: 12.sp, color: isSelected ? whiteColor : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
