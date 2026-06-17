import 'package:get/get.dart';

/// GetX controller to manage tab selection state
class AllergenChartController extends GetxController {
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
