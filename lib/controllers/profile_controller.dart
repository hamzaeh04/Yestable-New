import 'package:get/get.dart';

class ProfileController extends GetxController {
  var switchValue = true.obs;

  // List of selected options, each index represents one item (6 items for example)
  RxMap<int, String> selectedOptions = <int, String>{}.obs;
  var selectedAllergens = <int>{}.obs;
  var foodNationality = <int>{}.obs;
  var other = false.obs;

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }

  void switchOption(int index, String option) {
    selectedOptions[index] = option;
  }

  void otherToggleSwitch() {
    other.value = !other.value;
  }

}
