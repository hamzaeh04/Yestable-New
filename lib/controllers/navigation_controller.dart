import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/complete_guest_dialog.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  RxInt allergenSelectedIndex = 0.obs;
  var showAllergicGuest = false.obs;
  var selectedIndex = 0.obs;
  var selectedIndexTab = 0.obs;
  var sortBySelectedIndex = 0.obs;
  var isUser = true.obs;
  var selectedTabIndex = 0.obs;
  late BuildContext context;
  RxBool isProfileComplete = false.obs;
  RxBool hasCheckedProfile = false.obs;
  RxBool isInvited = false.obs;
  RxBool isGuestUpdateReceived = true.obs;
  var selectedEvent = ''.obs;
  PageController? _pageController;

  final List<String> allergenList = ["Allergens List", "Common Allergens", "Severity Level"];
  final List<String> events = ['Gizelle Lunch Event', 'Gizelle Dinner Event', 'Thanksgiving Dinner Event'];
  void selectEvent(String value) {
    selectedEvent.value = value;
  }
  // Track "added" status for each user
  var isFriendAdded = <int, bool>{}.obs;

  RxBool isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

  void toggleShowAllergicGuest(){
    showAllergicGuest.value = true;
  }

  void switchTab(int index) {
    selectedTabIndex.value = index;
  }


  // Toggle function
  void toggleAdd(int index) {
    isFriendAdded[index] = !(isFriendAdded[index] ?? false);
  }

  // Check if added
  bool isAdded(int index) {
    return isFriendAdded[index] ?? false;
  }



  final List<String> tabs = [
    "All",
    "Invitations",
    "Friend Request",
    "Replies",
  ];

  final List<String> searchScreenTabs = [
    "All",
    "Recipes",
    "Events",
    "People",
    "Filter",

  ];

  final List<String> sortBy = [
    "All",
    "With Photos Only ",
    "2.0+",
    "4.0+",
    "3.0+",
    "4.0+",
    "Filter",
  ];

  // Call this from the widget to set the page controller
  void setPageController(PageController controller) {
    _pageController = controller;
  }

  void switchUser() {
    isUser.value = false;
  }

  void selectTabSearch(int index) {
    selectedIndexTab.value = index;
  }

  void selectSortBy(int index) {
    sortBySelectedIndex.value = index;
  }

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  void changePage(int index) {
    currentIndex.value = index;
    if (_pageController?.hasClients ?? false) {
      _pageController!.jumpToPage(index);
    } else {
      debugPrint("⚠️ PageController not set or not attached");
    }
  }

  // Named navigation helpers
  void goToSeeAllPage() => changePage(5);
  void goToNotificationPage() => changePage(6);
  void goTSearchScreen() => changePage(7);
  void addtoFriendScreen() => changePage(8);
  void addtoCommunityProfile() => changePage(9);
  void viewAllEvents() => changePage(1);

  void goToHome() {
    if (currentIndex.value > 0) {
      changePage(0);
    }
  }

  void backPage() {
    if (_pageController?.hasClients ?? false && currentIndex.value > 0) {
      int previousIndex = currentIndex.value - 1;
      currentIndex.value = previousIndex;
      _pageController!.jumpToPage(previousIndex);
    }
  }

  @override
  void onClose() {
    // Don't dispose the controller here — it's owned by the widget
    super.onClose();
  }
}
