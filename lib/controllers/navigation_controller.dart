import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yestable/controllers/profile_controller.dart';

import '../widget/complete_guest_dialog.dart';

class NavigationController extends GetxController {
  final ProfileController controller = Get.find<ProfileController>();
  var currentIndex = 0.obs;
  RxInt allergenSelectedIndex = 0.obs;
  var showAllergicGuest = false.obs;
  var selectedIndex = 0.obs;
  var selectedIndexTab = 0.obs;
  var sortBySelectedIndex = 0.obs;
  var isUser = true.obs;
  var isLoggedIn = false.obs;
  var selectedTabIndex = 0.obs;
  // NavigationController ke andar
  var hasShownInvitedDialog = false.obs;
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
  var expandedNotes = <int, bool>{}.obs;
  var isNotesClicked = <int, bool>{}.obs;

  RxBool isSelected = false.obs;

  RxBool isYesTableSelected = true.obs;

  void selectYesTable() {
    isYesTableSelected.value = true;
  }

  void selectManual() {
    isYesTableSelected.value = false;
  }

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

  // Toggle notes
  void toggleNotes(int index) {
    expandedNotes[index] = !(expandedNotes[index] ?? false);
  }


  void isNotesToggle(int index){
    isNotesClicked[index] = !(isNotesClicked[index] ?? true);
  }

  // Check if the notes expanded or not
  bool isNotesExpanded(int index) {
    return expandedNotes[index] ?? false;
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
  void goToSeeAllPage() => changePage(4);
  void goToNotificationPage() => changePage(5);
  void goTSearchScreen() => changePage(6);
  void addtoFriendScreen() => changePage(7);
  void addtoCommunityProfile() => changePage(8);
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
