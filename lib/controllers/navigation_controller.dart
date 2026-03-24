import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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



  onGuestClick() async {
    final prefs = await SharedPreferences.getInstance();

    isUser.value = true;
    await prefs.setBool('isUser', true);
  }

  onHostClick() async {
    final prefs = await SharedPreferences.getInstance();

    isUser.value = false;
    await prefs.setBool('isUser', false);
  }
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



  /// Formats the date part: "2026-02-20T16:46:23.956Z" -> "20 Feb 2026"
  String formatDate(String isoDate) {
    try {
      DateTime dateTime = DateTime.parse(isoDate).toLocal(); // Convert to local time
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } catch (e) {
      return isoDate; // fallback to original string if parsing fails
    }
  }

  String formatDate2(DateTime? dateTime) {
    try {
      if (dateTime == null) return "";

      return DateFormat('MMM dd, yyyy').format(dateTime.toLocal());
    } catch (e) {
      return "";
    }
  }

  /// Formats the time part: "2026-02-20T16:46:23.956Z" -> "04:46 PM"
  String formatTime(String isoDate) {
    try {
      DateTime dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return isoDate;
    }
  }
  String formatTime2(DateTime? dateTime) {
    try {
      if (dateTime == null) return "";

      return DateFormat('hh:mm a').format(dateTime.toLocal());
    } catch (e) {
      return "";
    }
  }

// Example function
  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        return "Unknown Location";
      }
    } catch (e) {
      print("Reverse geocoding error: $e");
      return "Unknown Location";
    }
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
