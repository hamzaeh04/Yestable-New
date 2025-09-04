import 'package:get/get.dart';

class ProfileController extends GetxController {
  var switchValue = true.obs;

  // List of selected options, each index represents one item (6 items for example)
  RxMap<int, String> selectedOptions = <int, String>{}.obs;
  var selectedAllergens = <int>{}.obs;
  var foodNationality = <int>{}.obs;
  var other = false.obs;
  var isChecked = false.obs;
  var isRadioChecked = false.obs;

  RxBool isArrowRotated = false.obs;
  RxBool isExpanded = false.obs;
  RxString selectedOption = "Hearing Loss".obs;

  List<String> options = [
    "Help Carrying Plate",
    "Assistance Walking In",
    "Bringing A Care Aide",
    "Hearing Loss",
    "Seating Near A Restroom",
    "Non Verbal",
    "Other"
  ];

  void toggleDropdown() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleRadioButton(){
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
