import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/core/services/apiendpoints.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import '../utils/utility.dart';

class EventController extends GetxController {

  // Event Controllers
  final TextEditingController eventName = TextEditingController();
  final TextEditingController eventDate = TextEditingController();
  final TextEditingController eventTime = TextEditingController();
  final TextEditingController eventType = TextEditingController();
  final TextEditingController eventLocation = TextEditingController();
  final TextEditingController inviteMsg = TextEditingController();
  final TextEditingController parkingDetails = TextEditingController();
  final TextEditingController addNote = TextEditingController();
  final TextEditingController eventReminder = TextEditingController();
  final TextEditingController otherComfortController = TextEditingController();

  // Guest Aware Controllers
  final TextEditingController swimmingPoolController = TextEditingController();
  final TextEditingController itemContainingController = TextEditingController();
  final TextEditingController guestAwareOthersController = TextEditingController();
  final TextEditingController guestContactController = TextEditingController();

  var poolSelection = ''.obs;
  var guestsWelcomeToSwim = false.obs;

  final BaseService baseService = BaseService();

  /// SAFE BOOL OPTION GETTER
  bool? getBoolOption(ProfileController profileController, int index) {
    if (index >= profileController.selectedOptions.length) {
      print("⚠️ Index $index OUT OF RANGE");
      return null;
    }

    final value = profileController.selectedOptions[index];
    print("Index $index value: $value");

    if (value == 'yes') return true;
    if (value == 'no') return false;

    return null;
  }

  /// EVENT COMFORT API
  Future<void> updateEventComfortMethod(String eventId) async {
    final ProfileController profileController = Get.find<ProfileController>();

    print("============= EVENT COMFORT DEBUG START =============");
    print("EventId: $eventId");

    print("selectedOptions length: ${profileController.selectedOptions.length}");
    print("selectedOptions: ${profileController.selectedOptions}");

    Map<String, dynamic> comfortData = {};

    bool? quietSpace = getBoolOption(profileController, 1);
    bool? largerSeating = getBoolOption(profileController, 2);
    bool? wheelChairAccess = getBoolOption(profileController, 3);
    bool? aslInterpreter = getBoolOption(profileController, 4);
    bool? veganMenu = getBoolOption(profileController, 5);
    bool? restroom = getBoolOption(profileController, 6);

    print("quietSpace: $quietSpace");
    print("largerSeating: $largerSeating");
    print("wheelChairAccess: $wheelChairAccess");
    print("aslInterpreter: $aslInterpreter");
    print("veganMenu: $veganMenu");
    print("restroom: $restroom");

    if (quietSpace != null) comfortData['quietSpace'] = quietSpace;
    if (largerSeating != null) comfortData['largerSeating'] = largerSeating;
    if (wheelChairAccess != null) comfortData['wheelChairAccess'] = wheelChairAccess;
    if (aslInterpreter != null) comfortData['aslInterpreter'] = aslInterpreter;
    if (veganMenu != null) comfortData['veganMenu'] = veganMenu;
    if (restroom != null) comfortData['restroom'] = restroom;

    String otherText = otherComfortController.text.trim();
    print("Other Comfort Text: $otherText");

    if (otherText.isNotEmpty) {
      comfortData['other'] = otherText;
    }

    print("Final comfortData Payload → $comfortData");

    try {
      final response = await baseService.basePatchAPI(
        ApiEndPoints.updateEventComfort(eventId),
        body: comfortData,
      );

      print("API Response → $response");

      if (response['success'] == true) {
        // ✅ Show success toast
        Utils.showToast(
          response['message'] ?? "Event comfort updated successfully",
          false,
        );

        // ✅ RESET ONLY SELECTED OPTIONS
        profileController.selectedOptions.clear();
        otherComfortController.clear();
        print("✅ selectedOptions cleared after success");

      } else {
        Utils.showToast(
          response['message'] ?? "Failed to update event comfort",
          true,
        );
      }

    } catch (e) {
      print("❌ Error in updateEventComfortMethod: $e");

      Utils.showToast(
        "Something went wrong: $e",
        true,
      );
    }

    print("============= EVENT COMFORT DEBUG END =============");
  }

  /// GUEST AWARE API
  Future<void> updateGuestAwareMethod(String eventId) async {

    final ProfileController profileController = Get.find<ProfileController>();
    final NavigationController navCtrl = Get.find<NavigationController>();

    print("============= GUEST AWARE DEBUG START =============");
    print("EventId: $eventId");

    print("selectedOptions length: ${profileController.selectedOptions.length}");
    print("selectedOptions: ${profileController.selectedOptions}");

    Map<String, dynamic> guestAwareData = {};

    bool displayMenu = navCtrl.isSelected.value;

    bool? mayGuestsContact = getBoolOption(profileController, 1);
    bool? petsPresent = getBoolOption(profileController, 2);
    bool? childrenPresent = getBoolOption(profileController, 3);
    bool? forAdultOnly = getBoolOption(profileController, 4);
    bool? smokePresent = getBoolOption(profileController, 5);
    bool? smokeFree = getBoolOption(profileController, 6);
    bool? alcohol = getBoolOption(profileController, 7);
    bool? alcoholFree = getBoolOption(profileController, 8);
    bool? stepsToClimb = getBoolOption(profileController, 9);
    bool? fireArms = getBoolOption(profileController, 10);
    bool? shellFish = getBoolOption(profileController, 11);
    bool? peanuts = getBoolOption(profileController, 12);
    bool? endsInFirmTime = getBoolOption(profileController, 13);

    print("displayMenu: $displayMenu");
    print("mayGuestsContact: $mayGuestsContact");
    print("petsPresent: $petsPresent");
    print("childrenPresent: $childrenPresent");
    print("forAdultOnly: $forAdultOnly");
    print("smokePresent: $smokePresent");
    print("smokeFree: $smokeFree");
    print("alcohol: $alcohol");
    print("alcoholFree: $alcoholFree");
    print("stepsToClimb: $stepsToClimb");
    print("fireArms: $fireArms");
    print("shellFish: $shellFish");
    print("peanuts: $peanuts");
    print("endsInFirmTime: $endsInFirmTime");

    guestAwareData['displayMenu'] = displayMenu;

    if (mayGuestsContact != null) guestAwareData['mayGuestsContact'] = mayGuestsContact;
    if (petsPresent != null) guestAwareData['petsPresent'] = petsPresent;
    if (childrenPresent != null) guestAwareData['childrenPresent'] = childrenPresent;
    if (forAdultOnly != null) guestAwareData['forAdultOnly'] = forAdultOnly;
    if (smokePresent != null) guestAwareData['smokePresent'] = smokePresent;
    if (smokeFree != null) guestAwareData['smokeFree'] = smokeFree;
    if (alcohol != null) guestAwareData['alcohol'] = alcohol;
    if (alcoholFree != null) guestAwareData['alcoholFree'] = alcoholFree;
    if (stepsToClimb != null) guestAwareData['stepsToClimb'] = stepsToClimb;
    if (fireArms != null) guestAwareData['fireArms'] = fireArms;
    if (shellFish != null) guestAwareData['shellFish'] = shellFish;
    if (peanuts != null) guestAwareData['peanuts'] = peanuts;
    if (endsInFirmTime != null) guestAwareData['endsInFirmTime'] = endsInFirmTime;

    print("poolSelection: ${poolSelection.value}");
    print("guestsWelcomeToSwim: ${guestsWelcomeToSwim.value}");

    if (poolSelection.value.isNotEmpty) {

      guestAwareData['swimmingPool'] = poolSelection.value;

      if (poolSelection.value == 'pool_present') {
        guestAwareData['guestsWelcomeToSwim'] = guestsWelcomeToSwim.value;
      }

    }

    String itemContaining = itemContainingController.text.trim();
    String others = guestAwareOthersController.text.trim();
    String guestContact = guestContactController.text.trim();

    print("itemContaining: $itemContaining");
    print("others: $others");
    print("guestContact: $guestContact");

    if (itemContaining.isNotEmpty) guestAwareData['itemContaining'] = itemContaining;
    if (others.isNotEmpty) guestAwareData['others'] = others;
    if (guestContact.isNotEmpty) guestAwareData['guestContact'] = guestContact;

    print("Final guestAwareData Payload → $guestAwareData");

    try {

      final response = await baseService.basePatchAPI(
        ApiEndPoints.updatedGuestAware(eventId),
        body: guestAwareData,
      );

      print("API Response → $response");

      if (response['success'] == true) {

        Utils.showToast(
          response['message'] ?? "Guest aware details updated successfully",
          false,
        );

      } else {

        Utils.showToast(
          response['message'] ?? "Failed to update guest aware details",
          true,
        );

      }

    } catch (e) {

      print("❌ Error in updateGuestAwareMethod: $e");

      Utils.showToast(
        "Something went wrong: $e",
        true,
      );

    }

    print("============= GUEST AWARE DEBUG END =============");
  }
}
