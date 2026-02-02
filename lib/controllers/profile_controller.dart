import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // --- Existing Variables (No changes here) ---


  var switchValue = true.obs;
  var switchValue2 = true.obs;
  RxString selectedValue = ''.obs;
  RxBool isSelected = false.obs;
  RxMap<int, String> selectedOptions = <int, String>{}.obs;
  var selectedAllergens = <int>{}.obs;
  var foodNationality = <int>{}.obs;
  var other = false.obs;
  var isChecked = false.obs;
  var isRadioChecked = false.obs;
  RxInt pronounIsSelected = 0.obs;
  // final RxBool isPlaceExpanded = false.obs;
  RxBool isArrowRotated = false.obs;
  RxBool isExpanded = false.obs;
  RxString selectedOption = "Hearing Loss".obs;
  // final RxList<int> places = <int>[0].obs; // first item permanent

  final RxList<int> places = <int>[0].obs;
  final RxBool isPlaceExpanded = false.obs;
  final RxBool isPreferences = false.obs;
  /// Track completion for each setPlace
  RxList<bool> placeCompleted = <bool>[false].obs;

  RxInt selectedIndex = (-1).obs;
  RxString title = ''.obs;

  void setData({required int index, String? screenTitle}) {
    selectedIndex.value = index;
    title.value = screenTitle ?? '';
  }
  /// Controllers for each setPlace
  RxList<Map<String, TextEditingController>> placeControllers = <Map<String, TextEditingController>>[
    {
      'name': TextEditingController(),
      'relation': TextEditingController(),
      'age': TextEditingController(),
    }
  ].obs;

  List<String> options = [
    "Help Carrying Plate",
    "Assistance Walking In",
    "Bringing A Care Aide",
    "Hearing Loss",
    "Seating Near A Restroom",
    "Non Verbal",
    "Other"
  ];

  // --- Food Preferences (Cleaned up) ---
  final List<String> yuckOrYumList = [
    '☘️ Cilantro', '🍄 Mushrooms', '🧴 Mayonnaise', '🫒 Olives',
    '🦈 Anchovies', '🦪 Oysters', '💙 Blue Cheese', '🪵 Licorice',
    '🧅 Raw Onion', '🫑 Green Peppers', '🌿 Mint', '🟫‍ Dark Chocolate',
    '☕‍ Coffee', '🌶 Spicy Food',
  ];

  // Initialize as an empty RxList
  var foodSelections = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Ensure list is populated immediately on controller creation
    _initializeFoodSelections();
  }

  void _initializeFoodSelections() {
    foodSelections.assignAll(List.generate(yuckOrYumList.length, (index) => 0));
  }

  // Updated Method to trigger UI update properly
  void updateFoodSelection(int index, int value) {
    if (index >= 0 && index < foodSelections.length) {
      if (foodSelections[index] == value) {
        foodSelections[index] = 0; // Toggle off
      } else {
        foodSelections[index] = value; // Set new value
      }
      // Manual refresh call to ensure Obx picks up index-based changes
      foodSelections.refresh();
    }
  }

  // --- Existing Methods (No changes here) ---
  void checkBox() {
    isSelected.value = !isSelected.value;
  }

  void select(String value) {
    selectedValue.value = value;
  }

  void updatePronounIsSelected(int index) {
    pronounIsSelected.value = index;
  }

  void toggleDropdown() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleRadioButton() {
    isRadioChecked.value = !isRadioChecked.value;
  }

  void selectOption(String value) {
    selectedOption.value = value;
    isExpanded.value = false;
  }

  void toggleArrow() {
    isArrowRotated.value = !isArrowRotated.value;
  }

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }

  void toggleSwitch2(bool value) {
    switchValue2.value = value;
  }

  void switchOption(int index, String option) {
    selectedOptions[index] = option;
  }

  void otherToggleSwitch() {
    other.value = !other.value;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
