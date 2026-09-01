import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/model/get_ai_menu.dart';
import 'package:yestable/model/get_all_allergen_list.dart';
import 'package:yestable/model/get_event_review_model.dart';
import 'package:yestable/model/get_my_event_model.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../core/services/firebase_messaging/messaging_service.dart';
import '../model/get_all_event_model.dart' hide Event;
import '../model/get_event_allergen_list.dart';
import '../model/get_event_by_id_model.dart' show EventDetailsResponse;
import '../model/get_menu_model.dart';
import '../model/pending_invitation_model.dart' hide GuestAware, EventComfort;
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../widget/event_posted_dialog.dart';
import 'location_controller.dart';
import 'navigation_controller.dart';

class EventController extends GetxController {
  ProfileController profileController = Get.find<ProfileController>();
  TextEditingController aiController = TextEditingController();
  bool refreshMenu = false;
  String? imagePath = "";
  var isNetworkImageDeleted = false.obs;

  bool? quietSpace;
  bool? largerSeating;
  bool? wheelChairAccess;
  bool? aslInterpreter;
  bool? veganMenu;
  bool? restroom;

  bool? petsPresent;
  bool? childrenPresent;
  bool? forAdultOnly;
  bool? smokePresent;
  bool? smokeFree;
  bool? alcohol;
  bool? alcoholFree;
  bool? stepsToClimb;
  bool? fireArms;
  bool? shellFish;
  bool? peanuts;
  bool? endsInFirmTime;
  bool? mayGuestsContact;
  String mainEventId = "";

  final selectedDay = DateTime.now().obs;
  final focusedDay = DateTime.now().obs;

  final SharedPreferences pref = SharedPreferencesMethod.storage;
  final MessagingService messagingService = MessagingService();
  var switchValue3 = false.obs;
  StreamSubscription? groupSubscription;

  void listenGroupStatus(String groupId) {
    groupSubscription?.cancel();

    groupSubscription = FirebaseFirestore.instance
        .collection('group')
        .doc(groupId)
        .snapshots()
        .listen((doc) {
          if (doc.exists) {
            final bool isDisable = doc.data()?['disableGroup'] ?? false;
            switchValue3.value = !isDisable;
          }
        });
  }

  @override
  void onClose() {
    groupSubscription?.cancel();
    super.onClose();
  }

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
  final TextEditingController guestCount = TextEditingController();

  var selectedEventType = RxnString();
  var selectedReminderTime = RxnString();
  Rxn<EventReviewModel> eventReviewModel = Rxn<EventReviewModel>();
  Rxn<GetAllEventsModel> getAllEventsModel = Rxn<GetAllEventsModel>();
  Rxn<GetMyEventModel> myEventsModel = Rxn<GetMyEventModel>();
  Rxn<GetMenuModel> getMenuModel = Rxn<GetMenuModel>();
  Rxn<PendingInvitationModel> pendingInvitationModel = Rxn<PendingInvitationModel>();
  Rxn<AiMenu> getAiMenuModel = Rxn<AiMenu>();
  final RxBool isAiMenuLoading = false.obs;
  final RxString aiMenuError = ''.obs;
  Rxn<EventDetailsResponse> getEventByIdModel = Rxn<EventDetailsResponse>();

  Rxn<AllAllergen> getAllergenList = Rxn<AllAllergen>();
  Rxn<EventAllergenResponse> getEventAllergenData =
      Rxn<EventAllergenResponse>();
  final RxBool isLoadingAllerganList = false.obs;
  final RxBool isLoadingEventAllergens = false.obs;

  // Guest Aware Controllers
  final TextEditingController swimmingPoolController = TextEditingController();
  final TextEditingController itemContainingController =
      TextEditingController();
  final TextEditingController guestAwareOthersController =
      TextEditingController();
  final TextEditingController guestContactController = TextEditingController();

  void toggleSwitch3() {
    switchValue3.value = !switchValue3.value;
  }

  var poolSelection = ''.obs;
  var guestsWelcomeToSwim = false.obs;
  final LocationController locationController = Get.find<LocationController>();
  BaseService baseService = BaseService();
  final prefs = SharedPreferencesMethod.storage;

  final RxBool isMenusLoading = false.obs;
  final RxBool isLoadingMyEvents = false.obs;
  final RxBool isLoadingAllEvents = false.obs;
  final RxBool isLoadingCreateEvent = false.obs;
  final RxString menusError = ''.obs;
  final RxList<MenuItem> menus = <MenuItem>[].obs;
  final RxList<MenuItem> selectedMenus = <MenuItem>[].obs;
  final RxSet<String> addedAiMenuKeys = <String>{}.obs;

  final TextEditingController menuTitle = TextEditingController();
  final TextEditingController menuDescription = TextEditingController();

  var itemPic = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  Future<void> pickFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    itemPic.value = File(file.path);
    print(itemPic.value);
  }

  void removeImage() {
    itemPic.value = null;
  }

  final List<String> eventMenuList = [
    "Vegetarian",
    "Contain Dairy",
    "Gluten-Free",
    "Shelfish",
    "Vegan",
    "Nut-Free",
  ];

  final List<String> eventAccesibilityList = [
    "Quiet Space Available",
    "Larger Seating",
    "Wheelchair Accessible",
    "ASL Interpreter",
    "Vegan Option",
    "Rest Room",
    "Pets Allowed",
    "Childrens Allowed",
    "For Adults Only",
    "Smoke Present",
    "Smoke Free",
    "Alcohol",
    "Alcohol Free",
    "There Are Steps To Climb",
    "Swimming Pool Is Present",
    "Firearms Are Present",
    "Shellfish Will Be Served",
    "Peanuts Present",
    "Event Ends At A Time",
  ];
  RxList<String> eventComfortAccessibility = <String>[].obs;

  String generateEventLink(String eventId) {
    return "https://yestable-107c6.web.app/event/$eventId";
  }

  void mapEventComfortAccessibility(
    EventComfort? eventComfort,
    GuestAware? guestAware,
  ) {
    eventComfortAccessibility.clear();

    // Event Comfort
    if (eventComfort?.quietSpace == true) {
      eventComfortAccessibility.add("Quiet Space");
    }

    if (eventComfort?.largerSeating == true) {
      eventComfortAccessibility.add("Larger Seating");
    }

    if (eventComfort?.wheelChairAccess == true) {
      eventComfortAccessibility.add("Wheelchair Accessible");
    }

    if (eventComfort?.aslInterpreter == true) {
      eventComfortAccessibility.add("ASL Interpreter");
    }

    if (eventComfort?.veganMenu == true) {
      eventComfortAccessibility.add("Vegan Option");
    }

    if (eventComfort?.restroom == true) {
      eventComfortAccessibility.add("Rest Room");
    }

    // Guest Aware
    if (guestAware?.petsPresent == true) {
      eventComfortAccessibility.add("Pets Allowed");
    }

    if (guestAware?.childrenPresent == true) {
      eventComfortAccessibility.add("Childrens Allowed");
    }

    if (guestAware?.forAdultOnly == true) {
      eventComfortAccessibility.add("For Adults Only");
    }

    if (guestAware?.smokePresent == true) {
      eventComfortAccessibility.add("Smoke Present");
    }

    if (guestAware?.smokeFree == true) {
      eventComfortAccessibility.add("Smoke Free");
    }

    if (guestAware?.alcohol == true) {
      eventComfortAccessibility.add("Alcohol");
    }

    if (guestAware?.alcoholFree == true) {
      eventComfortAccessibility.add("Alcohol Free");
    }

    if (guestAware?.stepsToClimb == true) {
      eventComfortAccessibility.add("There Are Steps To Climb");
    }

    if (guestAware?.swimmingPool == "pool_present") {
      eventComfortAccessibility.add("Swimming Pool Is Present");
    }

    if (guestAware?.fireArms == true) {
      eventComfortAccessibility.add("Firearms Are Present");
    }

    if (guestAware?.shellFish == true) {
      eventComfortAccessibility.add("Shellfish Will Be Served");
    }

    if (guestAware?.peanuts == true) {
      eventComfortAccessibility.add("Peanuts Present");
    }

    if (guestAware?.endsInFirmTime == true) {
      eventComfortAccessibility.add("Event Ends At A Time");
    }
  }

  var selectedType = RxnString();
  RxList<Map<String, String>> selectedMealCategory =
      <Map<String, String>>[].obs; // List of categories
  final type = ["Appetizers", "Main Course", "Desserts & Others"];

  // Event Details/Publish screens filter menus by exact match against
  // `type` above. AI suggestions come back with free-text types (e.g.
  // "Starter", "Entree", "Beverage") that never match those three strings,
  // so an AI-picked item would save fine but never show under any tab.
  // Map whatever the AI returns onto one of the three canonical categories.
  String normalizeMenuType(String? aiType) {
    final t = (aiType ?? '').toLowerCase();
    if (t.contains('dessert') ||
        t.contains('sweet') ||
        t.contains('cake') ||
        t.contains('pastry') ||
        t.contains('ice cream') ||
        t.contains('icecream') ||
        t.contains('pudding') ||
        t.contains('cookie') ||
        t.contains('brownie') ||
        t.contains('donut') ||
        t.contains('chocolate')) {
      return "Desserts & Others";
    }
    if (t.contains('appetizer') ||
        t.contains('starter') ||
        t.contains('snack') ||
        t.contains('small plate')) {
      return "Appetizers";
    }
    return "Main Course";
  }
  final List<Map<String, String>> mealCategory = [
    {
      "name": "Vegetarian",
      "imgPath": "assets/png/event_food_image/brocolli.png",
    },
    {"name": "Dairy-Free", "imgPath": "assets/png/event_food_image/milk.png"},
    {
      "name": "Gluten-Free",
      "imgPath": "assets/png/event_food_image/glutenfree.png",
    },
    {"name": "Selfish", "imgPath": "assets/png/event_food_image/shell.png"},
    {"name": "Vegan", "imgPath": "assets/png/profile_food_images/vegan.png"},
    {"name": "Nut-Free", "imgPath": "assets/png/event_food_image/nutfree.png"},
  ];

  //   Future<void> createEvent(BuildContext context,{File? image}) async {
  //     try {
  //       final lat = locationController.latitude.value;
  //       final lng = locationController.longitude.value;
  //
  //       // Build ISO 8601 event time from separate date & time controllers
  //       String? isoEventTime;
  //       final dateStr = eventDate.text.trim();
  //       final timeStr = eventTime.text.trim();
  //
  //       if (dateStr.isNotEmpty && timeStr.isNotEmpty) {
  //         try {
  //           // Expected formats:
  //           // date: "dd-MM-yyyy"
  //           // time: "hh:mm AM/PM"
  //           final dateParts = dateStr.split('-');
  //           final day = int.parse(dateParts[0]);
  //           final month = int.parse(dateParts[1]);
  //           final year = int.parse(dateParts[2]);
  //
  //           final timeParts = timeStr.split(' ');
  //           final hm = timeParts[0].split(':');
  //           var hour = int.parse(hm[0]);
  //           final minute = int.parse(hm[1]);
  //           final period = timeParts.length > 1 ? timeParts[1].toUpperCase() : 'AM';
  //
  //           if (period == 'PM' && hour != 12) {
  //             hour += 12;
  //           } else if (period == 'AM' && hour == 12) {
  //             hour = 0;
  //           }
  //
  //           final dt = DateTime(year, month, day, hour, minute);
  //           isoEventTime = dt.toUtc().toIso8601String();
  //         } catch (_) {
  //           isoEventTime = null;
  //         }
  //       }
  //
  //       final typeValue = eventType.text.trim().isEmpty
  //           ? "Private"
  //           : eventType.text.trim();
  //
  //       final body = {
  //         "image": image,
  //         "eventName": eventName.text.trim(),
  //         "eventTime": isoEventTime,
  //         "eventType": typeValue,
  //         "location": {
  //           "type": "Point",
  //           "coordinates": [lng, lat],
  //         },
  //         "address": locationController.addressController.text.trim(),
  //         "invitationMessage": inviteMsg.text.trim(),
  //         "parkingDetails": parkingDetails.text.trim(),
  //         "addNote": addNote.text.trim(),
  //         "reminderNotification": true,
  //         "members": [],
  //         "menus": selectedMenus.map((m) => m.id).whereType<String>().toList(),
  //         "displayMenu": selectedMenus.isNotEmpty,
  //       };
  //
  //       final res = await baseService.basePostAPI(
  //         ApiEndPoints.createEvent,
  //         body,
  //         loading: true,
  //       );
  //
  //       if (res["success"] == true) {
  //         Utils.showToast(res["message"] ?? "Event created", false);
  //         String eventId = res["data"]["_id"];
  //         String link = generateEventLink(eventId);
  //
  //         print("Generated Link: $link");
  //
  // // // 🚀 SHOW DIALOG
  // // Get.defaultDialog(
  // //   title: "Event Created Successfully 🎉",
  // //   middleText: link,
  // //   textConfirm: "Copy Link",
  // //   textCancel: "Close",
  // //   confirmTextColor: Colors.white,
  // //   onConfirm: () {
  // //     // 👉 Copy to clipboard
  // //     Get.back();
  // //     Clipboard.setData(ClipboardData(text: link));
  // //     Utils.showToast("Link copied!", false);
  // //   },
  // // );
  //         showShareProfileDialog(context,title: "Share Event Link",link:link,onTap: (){
  //           Clipboard.setData(ClipboardData(text: link));
  //           Utils.showToast("Link copied!", false);
  //         },
  //             onCancel: (){
  //               Navigator.pop(context); // ✅ close dialog
  //               Get.toNamed("eventcomfortone", arguments: eventId);
  //             }
  //
  //         );
  //
  //       }
  //     } catch (e) {
  //       Utils.showToast("Failed to create event", true);
  //     }
  //   }
  Future<void> createEvent(BuildContext context, {File? image}) async {
    try {
      final lat = locationController.latitude.value;
      final lng = locationController.longitude.value;

      // Convert date + time → ISO
      String? isoEventTime;
      final dateStr = eventDate.text.trim();
      final timeStr = eventTime.text.trim();

      if (dateStr.isNotEmpty && timeStr.isNotEmpty) {
        try {
          final dateParts = dateStr.split('-');
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);

          final timeParts = timeStr.split(' ');
          final hm = timeParts[0].split(':');
          var hour = int.parse(hm[0]);
          final minute = int.parse(hm[1]);
          final period =
              timeParts.length > 1 ? timeParts[1].toUpperCase() : 'AM';

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          final dt = DateTime(year, month, day, hour, minute);
          isoEventTime = dt.toUtc().toIso8601String();
        } catch (_) {
          isoEventTime = null;
        }
      }

      final typeValue =
          eventType.text.trim().isEmpty ? "Private" : eventType.text.trim();

      // ---------------------------
      // Multipart Fields
      // ---------------------------
      final fields = {
        "eventName": eventName.text.trim(),
        "eventTime": isoEventTime ?? "",
        "eventType": typeValue,
        "address": locationController.addressController.text.trim(),
        "invitationMessage": inviteMsg.text.trim(),
        "parkingDetails": parkingDetails.text.trim(),
        "addNote": addNote.text.trim(),
        "reminderNotification": "true",
        "displayMenu": (selectedMenus.isNotEmpty).toString(),

        // ✅ Nested location (matches editEvent fix)
        "location[type]": "Point",
        "location[coordinates][0]": lng.toString(),
        "location[coordinates][1]": lat.toString(),
        "estimatedGuests": guestCount.text.trim(),
      };

      // menus array
      // List<String> menus = selectedMenus
      //     .map((m) => m.id)
      //     .whereType<String>()
      //     .toList();

      await _sendMultipartEventRequest(
        ApiEndPoints.createEvent,
        fields,
        // menus,
        image,
        context,
      );
    } catch (e) {
      Utils.showToast("Failed to create event", true);
    }
  }

  Future<void> _sendMultipartEventRequest(
    String endpoint,
    Map<String, String> fields,
    // List<String> menus,
    File? image,
    BuildContext context,
  ) async {
    isLoadingCreateEvent.value = true;
    try {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
      final url = "${baseService.baseURL}$endpoint";
      final uri = Uri.parse(url);
      print(url);

      var request = http.MultipartRequest('POST', uri);
      final token = prefs.getString(LocalDBKeys.TOKEN);

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      // Add fields
      request.fields.addAll(fields);

      // Add menus array
      // for (var menu in menus) {
      //   request.fields['menus[]'] = menu;
      // }

      // Add image
      if (image != null) {
        String ext = path.extension(image.path).toLowerCase();
        String mimeType = 'image/jpeg';

        if (ext == '.png')
          mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg')
          mimeType = 'image/jpeg';
        else if (ext == '.gif')
          mimeType = 'image/gif';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // make sure backend expects this key
            image.path,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast(jsonResponse['message'] ?? "Event created", false);

        String eventId = jsonResponse["data"]["_id"];
        mainEventId = eventId;
        String eventImage = jsonResponse["data"]["image"] ?? "";
        final adminName = pref.getString(LocalDBKeys.USERFULLNAME);
        final adminId = pref.getString(LocalDBKeys.USERID);
        print("sjkfghigshdsdsasdbv : ${adminId}");
        print("sjkfghigshdsdsasdbv : ${eventImage}");
        messagingService.createGroup(
          imagePath: eventImage,
          name: eventName.text,
          createdBy: adminName ?? '',
          enableGroup: switchValue3.value,
          eventId: eventId.toString(),
          adminId: adminId!,
          invitationMsg: inviteMsg.text,
          adminProfilePic:
              profileController.getMyProfileModel.value?.data?.profilePic ?? "",
        );
        // clearEventFields();
        // Share-link dialog now shows on the "Publish Now" flow instead of here.
        Get.toNamed("foodmenuscreen", arguments: eventId);
      } else {
        Utils.showToast(
          jsonResponse['message'] ?? "Something went wrong",
          false,
        );
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", false);
    } finally {
      EasyLoading.dismiss(); // ✅ MUST
    }
  }

  Future<void> editEvent({
    required String eventId,
    File? image,
    bool isEdit = false,
  }) async {
    try {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
      final lat = locationController.latitude.value;
      final lng = locationController.longitude.value;

      // ISO time
      String? isoEventTime;
      final dateStr = eventDate.text.trim();
      final timeStr = eventTime.text.trim();

      if (dateStr.isNotEmpty && timeStr.isNotEmpty) {
        try {
          final dateParts = dateStr.split('-');
          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);

          final timeParts = timeStr.split(' ');
          final hm = timeParts[0].split(':');
          var hour = int.parse(hm[0]);
          final minute = int.parse(hm[1]);
          final period =
              timeParts.length > 1 ? timeParts[1].toUpperCase() : 'AM';

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          final dt = DateTime(year, month, day, hour, minute);
          isoEventTime = dt.toUtc().toIso8601String();
        } catch (_) {
          isoEventTime = null;
        }
      }

      final typeValue =
          eventType.text.trim().isEmpty ? "Dinner" : eventType.text.trim();

      /// ---------------------------
      /// Multipart Fields
      /// ---------------------------
      final fields = {
        "eventName": eventName.text.trim(),
        "eventTime": isoEventTime ?? "",
        "eventType": typeValue,
        "address": locationController.addressController.text.trim(),
        "invitationMessage": inviteMsg.text.trim(),
        "parkingDetails": parkingDetails.text.trim(),
        "addNote": addNote.text.trim(),
        "reminderNotification": "true",
        "displayMenu": (selectedMenus.isNotEmpty).toString(),

        // ✅ Nested location (IMPORTANT FIX)
        "location[type]": "Point",
        "location[coordinates][0]": lng.toString(),
        "location[coordinates][1]": lat.toString(),
        "estimatedGuests": guestCount.text.trim(),
      };
      print("📤 API Fields: $fields");
      // menus array
      List<String> menus =
          selectedMenus.map((m) => m.id).whereType<String>().toList();

      await _sendMultipartEditRequest(
        ApiEndPoints.editEvent(eventId),
        fields,
        menus,
        image,
        eventId,
        isEdit,
      );
    } catch (e) {
      Utils.showToast("Failed to update event", true);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _sendMultipartEditRequest(
    String endpoint,
    Map<String, String> fields,
    List<String> menus,
    File? image,
    String eventId,
    bool isEdit,
  ) async {
    try {
      final url = "${baseService.baseURL}$endpoint";
      final uri = Uri.parse(url);
      print(url);

      var request = http.MultipartRequest('PATCH', uri);
      final token = prefs.getString(LocalDBKeys.TOKEN);

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      // Add fields
      request.fields.addAll(fields);

      // Add menus array. request.fields is a Map<String, String>, so
      // repeatedly setting the same 'menus[]' key here would silently
      // overwrite all but the last selected menu. Add each id as its own
      // multipart part instead — request.files is a List and preserves
      // duplicate field names correctly.
      for (var menu in menus) {
        request.files.add(http.MultipartFile.fromString('menus[]', menu));
      }

      // Add image
      if (image != null) {
        String ext = path.extension(image.path).toLowerCase();
        String mimeType = 'image/jpeg';

        if (ext == '.png')
          mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg')
          mimeType = 'image/jpeg';
        else if (ext == '.gif')
          mimeType = 'image/gif';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast(jsonResponse['message'] ?? "Event updated", false);
        eventReviewModel.refresh();
        isEdit == false
            ? Get.toNamed("eventcomfortone", arguments: eventId)
            : Get.toNamed("foodmenuscreen", arguments: eventId);

        // NOTE: Do NOT call clearEventFields() here — the flow continues
        // through EventComfortOne → Two → Three, which need prefilled data.
      } else {
        Utils.showToast(
          jsonResponse['message'] ?? "Something went wrong",
          false,
        );
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", true);
    }
  }

  Future<void> getMenus() async {
    isMenusLoading.value = true;
    menusError.value = '';
    try {
      final allMenus = <MenuItem>[];
      int page = 1;
      int totalPages = 1;
      do {
        final response = await baseService.baseGetAPI(
          '${ApiEndPoints.getMenus}?page=$page&limit=50',
        );
        if (response["success"] != true) {
          menus.clear();
          menusError.value =
              (response["message"] ?? "Failed to fetch menus").toString();
          return;
        }
        final model = GetMenuModel.fromJson(
          Map<String, dynamic>.from(response),
        );
        getMenuModel.value = model;
        allMenus.addAll(model.data?.data ?? <MenuItem>[]);
        totalPages = model.data?.totalPages ?? 1;
        page++;
      } while (page <= totalPages);
      menus.assignAll(allMenus);
    } catch (e) {
      menus.clear();
      menusError.value = "Failed to fetch menus";
    } finally {
      isMenusLoading.value = false;
    }
  }

  String? mealCategoryIcon(String? name) {
    if (name == null) return null;
    final match = mealCategory.firstWhereOrNull(
      (e) => (e["name"] ?? "").toLowerCase() == name.toLowerCase(),
    );
    return match?["imgPath"];
  }

  bool isMenuSelected(String? id) {
    if (id == null || id.isEmpty) return false;
    return selectedMenus.any((m) => m.id == id);
  }

  bool addSelectedMenu(MenuItem menu) {
    final id = menu.id;
    if (id == null || id.isEmpty) return false;
    if (isMenuSelected(id)) return false;
    selectedMenus.add(menu);
    return true;
  }

  bool isAiMenuAdded(String? key) {
    if (key == null || key.isEmpty) return false;
    return addedAiMenuKeys.contains(key);
  }

  void markAiMenuAdded(String key) {
    addedAiMenuKeys.add(key);
  }

  bool removeSelectedMenuById(String? id) {
    if (id == null || id.isEmpty) return false;
    final menu = selectedMenus.firstWhereOrNull((m) => m.id == id);
    if (menu == null) return false;
    selectedMenus.removeWhere((m) => m.id == id);
    if (menu.isAi == true) {
      if (menu.title != null && menu.title!.isNotEmpty) {
        addedAiMenuKeys.remove(menu.title);
      }
      print(
        "🗑️ Removing AI-created menu id=$id — hitting DELETE ${ApiEndPoints.deleteMenu(id)}",
      );
      baseService
          .baseDeleteAPI(ApiEndPoints.deleteMenu(id), loading: false)
          .then((response) {
            print("🗑️ Delete AI menu id=$id response: $response");
          });
    }
    return true;
  }

  Future<void> pickDateOrTime({
    required BuildContext context,
    required TextEditingController controller,
    required String type, // "date" or "time"
  }) async {
    final primaryColor = const Color(0xFF1F4F51);
    final accentColor = const Color(0xFF5D8783).withOpacity(0.75);
    final whiteColor = Colors.white;
    final blackColor = Colors.black;

    if (type == "date") {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryColor, // header background & selected date
                onPrimary: whiteColor, // header text color
                onSurface: blackColor, // dates text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor, // "CANCEL" & "OK" button
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        controller.text =
            "${pickedDate.day.toString().padLeft(2, '0')}-"
            "${pickedDate.month.toString().padLeft(2, '0')}-"
            "${pickedDate.year}";
      }
    }

    if (type == "time") {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input, // 👈 Digital input mode

        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: whiteColor,
                hourMinuteColor: primaryColor,
                hourMinuteTextColor: whiteColor,
                dayPeriodTextColor: accentColor, // 👈 AM/PM text color
                dayPeriodColor: accentColor.withOpacity(
                  0.2,
                ), // 👈 AM/PM selected bg
                dialHandColor: primaryColor,
                dialBackgroundColor: accentColor.withOpacity(0.2),
                entryModeIconColor: primaryColor,
              ),
              colorScheme: ColorScheme.light(
                primary: primaryColor,
                onPrimary: whiteColor,
                onSurface: accentColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedTime =
            "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')} "
            "${pickedTime.period == DayPeriod.am ? "AM" : "PM"}";

        controller.text = formattedTime;
      }
    }
  }

  Future<MenuItem?> uploadMenu({bool noNavigate = false}) async {
    // Remove jsonEncode
    final fields = {
      "title": menuTitle.text.trim(),
      "type": selectedType.value ?? "",
      "description": menuDescription.text.trim(),
      if (noNavigate) "isAi": "true",
    };

    // Prepare list of meal categories
    List<String> mealCategories =
        selectedMealCategory.map((e) => e["name"] ?? "").toList();

    // Send request
    return await _sendMultipartMenuRequest(
      ApiEndPoints.addMenu,
      fields,
      mealCategories,
      itemPic.value,
      noNavigate,
    );
  }

  Future<MenuItem?> _sendMultipartMenuRequest(
    String endpoint,
    Map<String, String> fields,
    List<String> mealCategories,
    File? menuImage,
    bool noNavigate,
  ) async {
    try {
      EasyLoading.show(
        status: 'Please wait...',
        maskType: EasyLoadingMaskType.black,
      );
      final url = "${baseService.baseURL}$endpoint";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri);
      final token = prefs.getString(LocalDBKeys.TOKEN);

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      // Add normal fields
      request.fields.addAll(fields);

      // Add mealCategory as array. Same fields-map collision as menus[]
      // above — use separate multipart parts so every category survives.
      for (var category in mealCategories) {
        request.files.add(
          http.MultipartFile.fromString('mealCategory[]', category),
        );
      }

      // Add image
      if (menuImage != null) {
        String ext = path.extension(menuImage.path).toLowerCase();
        String mimeType = 'image/jpeg';
        if (ext == '.png')
          mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg')
          mimeType = 'image/jpeg';
        else if (ext == '.gif')
          mimeType = 'image/gif';

        request.files.add(
          await http.MultipartFile.fromPath(
            'menuImage',
            menuImage.path,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast("${jsonResponse['message']}", false);
        final createdMenu =
            jsonResponse['data'] != null
                ? MenuItem.fromJson(jsonResponse['data'])
                : null;
        // Get.toNamed('menuSuccessScreen');
        clearItemFields();
        getMenus();
        print("==== Menu ID ==== ${jsonResponse['data']}");
        final menu = MenuItem.fromJson(jsonResponse['data']);

        addSelectedMenu(menu); // ✅ menu is MenuItem

        if (noNavigate == false) Get.back();
        return createdMenu;
      } else {
        Utils.showToast(
          jsonResponse['message'] ?? "Something went wrong",
          false,
        );
        return null;
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", false);
      return null;
    } finally {
      getMenuModel.refresh();
      menus.refresh();
      EasyLoading.dismiss();
    }
  }

  void clearItemFields() {
    itemPic.value = null;
    menuTitle.clear();
    menuDescription.clear();
    selectedType.value = null;
    selectedMealCategory.value = [];
  }

  /// SAFE BOOL OPTION GETTER
  bool? getBoolOption(ProfileController profileController, int index) {
    if (!profileController.selectedOptions.containsKey(index)) {
      print("⚠️ Index $index NOT FOUND in selectedOptions");
      return null;
    }

    final value = profileController.selectedOptions[index];
    print("Index $index value: $value");

    if (value?.toLowerCase() == 'yes') return true;
    if (value?.toLowerCase() == 'no') return false;

    return null;
  }

  /// EVENT COMFORT API
  Future<void> updateEventComfortMethod(String eventId) async {
    final ProfileController profileController = Get.find<ProfileController>();

    print("============= EVENT COMFORT DEBUG START =============");
    print("EventId: $eventId");

    print(
      "selectedOptions length: ${profileController.selectedOptions.length}",
    );
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
    if (wheelChairAccess != null)
      comfortData['wheelChairAccess'] = wheelChairAccess;
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

        // Clear selectedOptions so EventComfortTwo can reuse indices 1-13 for guestAware
        profileController.selectedOptions.clear();
        otherComfortController.clear();
        Get.toNamed("eventcomforttwo", arguments: eventId);
        print("✅ selectedOptions cleared after comfort submit");
      } else {
        Utils.showToast(
          response['message'] ?? "Failed to update event comfort",
          true,
        );
      }
    } catch (e) {
      print("❌ Error in updateEventComfortMethod: $e");

      Utils.showToast("Something went wrong: $e", true);
    }

    print("============= EVENT COMFORT DEBUG END =============");
  }

  /// GUEST AWARE API
  Future<void> updateGuestAwareMethod(String eventId) async {
    final ProfileController profileController = Get.find<ProfileController>();
    final NavigationController navCtrl = Get.find<NavigationController>();

    print("============= GUEST AWARE DEBUG START =============");
    print("EventId: $eventId");

    print(
      "selectedOptions length: ${profileController.selectedOptions.length}",
    );
    print("selectedOptions: ${profileController.selectedOptions}");

    Map<String, dynamic> guestAwareData = {};

    bool displayMenu = navCtrl.isSelected.value;

    bool? petsPresent = getBoolOption(profileController, 1);
    bool? childrenPresent = getBoolOption(profileController, 2);
    bool? forAdultOnly = getBoolOption(profileController, 3);
    bool? smokePresent = getBoolOption(profileController, 4);
    bool? smokeFree = getBoolOption(profileController, 5);
    bool? alcohol = getBoolOption(profileController, 6);
    bool? alcoholFree = getBoolOption(profileController, 7);
    bool? stepsToClimb = getBoolOption(profileController, 8);
    bool? fireArms = getBoolOption(profileController, 10);
    bool? shellFish = getBoolOption(profileController, 11);
    bool? peanuts = getBoolOption(profileController, 12);
    bool? endsInFirmTime = getBoolOption(profileController, 13);
    bool? guestContact = getBoolOption(profileController, 14);

    print("displayMenu: $displayMenu");
    print("mayGuestsContact: $guestContact");
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

    if (mayGuestsContact != null)
      guestAwareData['mayGuestsContact'] = mayGuestsContact;
    if (petsPresent != null) guestAwareData['petsPresent'] = petsPresent;
    if (childrenPresent != null)
      guestAwareData['childrenPresent'] = childrenPresent;
    if (forAdultOnly != null) guestAwareData['forAdultOnly'] = forAdultOnly;
    if (smokePresent != null) guestAwareData['smokePresent'] = smokePresent;
    if (smokeFree != null) guestAwareData['smokeFree'] = smokeFree;
    if (alcohol != null) guestAwareData['alcohol'] = alcohol;
    if (alcoholFree != null) guestAwareData['alcoholFree'] = alcoholFree;
    if (stepsToClimb != null) guestAwareData['stepsToClimb'] = stepsToClimb;
    if (fireArms != null) guestAwareData['fireArms'] = fireArms;
    if (shellFish != null) guestAwareData['shellFish'] = shellFish;
    if (peanuts != null) guestAwareData['peanuts'] = peanuts;
    if (endsInFirmTime != null)
      guestAwareData['endsInFirmTime'] = endsInFirmTime;

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
    // String guestContact = guestContactController.text.trim();

    print("itemContaining: $itemContaining");
    print("others: $others");
    print("guestContact: $guestContact");

    if (itemContaining.isNotEmpty)
      guestAwareData['itemContaining'] = itemContaining;
    if (others.isNotEmpty) guestAwareData['others'] = others;
    guestAwareData['guestContact'] = guestContact;

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
        // Get.toNamed("eventcomfortthree", arguments: eventId);
        Get.toNamed("eventpublishscreen", arguments: eventId);
      } else {
        Utils.showToast(
          response['message'] ?? "Failed to update guest aware details",
          true,
        );
      }
    } catch (e) {
      print("❌ Error in updateGuestAwareMethod: $e");

      Utils.showToast("Something went wrong: $e", true);
    }
    print("============= GUEST AWARE DEBUG END =============");
  }

  Future<void> eventReview(String eventId) async {
    isMenusLoading.value = true;
    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.eventReview(eventId),
      );

      if (response != null && response['success'] == true) {
        eventReviewModel.value = EventReviewModel.fromJson(response);
        // Utils.showToast(response['message'], false);
        final data = eventReviewModel.value?.data;

        mapEventComfortAccessibility(data?.eventComfort, data?.guestAware);
      } else {
        // Handle API failure

        final message = response?['message'] ?? "Something went wrong";
        print("API Error: $message");
        Utils.showToast(response['message'], true);
      }
    } catch (e, stackTrace) {
      // Handle exception
      print("Exception in eventReview: $e");
      print(stackTrace);
      Utils.showToast("Something went wrong ${e}", true);
    } finally {
      isMenusLoading.value = false;
    }
  }

  Future<void> publishEvent(String eventId, BuildContext context) async {
    isMenusLoading.value = true;

    try {
      final response = await baseService.basePatchAPI(
        ApiEndPoints.publishEvent(eventId),
        body: {},
      );

      if (response != null && response['success'] == true) {
        // Success
        // Utils.showToast(
        //     response?['message'], false
        // );
        eventPostedDialog(context, shareLink: generateEventLink(eventId));
        clearEventFields();
        // Optional: navigate or refresh
        // Get.back();
        // eventReview(eventId);
      } else {
        // API returned failure
        Utils.showToast(response?['message'], true);
      }
    } catch (e) {
      Utils.showToast("Error ${e}", true);
    } finally {
      isMenusLoading.value = false;
    }
  }

  Future<void> getAllEvents({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage.value >= totalPages.value) return; // no more pages
      isLoadingMore.value = true;
      currentPage.value += 1;
    } else {
      currentPage.value = 1;
      isLoadingAllEvents.value = true;
    }

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getAllEvent(currentPage.value),
      );

      if (response != null && response['success'] == true) {
        final newData = GetAllEventsModel.fromJson(response);

        totalPages.value = newData.data?.totalPages ?? 1;

        if (loadMore) {
          // Append new events
          var currentData = getAllEventsModel.value;
          currentData?.data?.data?.addAll(newData.data?.data ?? []);
          getAllEventsModel.value = currentData;
          getAllEventsModel.refresh();
        } else {
          getAllEventsModel.value = newData;
        }

        // Utils.showToast(response['message'] ?? "Events fetched successfully", false);
      } else {
        Utils.showToast(response['message'] ?? "Failed to fetch events", true);
      }
    } catch (e, stackTrace) {
      Utils.showToast("Something went wrong: $e", true);
      print("Error in getAllEvents(): $e");
      print(stackTrace);
    } finally {
      isLoadingAllEvents.value = false;
      isLoadingMore.value = false;
    }
  }

  // Used by getAllEvents() / event_screen.dart's pagination only.
  var isLoadingMore = false.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  // Dedicated pagination state for getMyEvents() / host_home_screen.dart.
  // MUST NOT be shared with getAllEvents()'s fields above: both calls are
  // fired together (unawaited) at app boot from bottom_navigation_bar.dart,
  // and sharing state meant whichever response landed last clobbered the
  // other's currentPage/totalPages — the cause of the Load More button
  // showing/hiding inconsistently across app launches.
  var isLoadingMoreMyEvents = false.obs;
  var myEventsCurrentPage = 1.obs;
  var myEventsTotalPages = 1.obs;

  Future<void> getMyEvents({bool loadMore = false}) async {
    // Serialize fresh-load and load-more requests: letting them overlap lets
    // whichever response lands last clobber currentPage/totalPages/the list
    // out from under the other in-flight request, which is what made the
    // Load More button flicker in and out unpredictably.
    if (isLoadingMyEvents.value || isLoadingMoreMyEvents.value) return;

    if (loadMore) {
      if (myEventsCurrentPage.value >= myEventsTotalPages.value) return; // No more pages
      isLoadingMoreMyEvents.value = true;
      myEventsCurrentPage.value += 1;

      try {
        final response = await baseService.baseGetAPI(
          ApiEndPoints.myEvents(myEventsCurrentPage.value),
          loading: false,
        );

        if (response != null && response['success'] == true) {
          final newData = GetMyEventModel.fromJson(response);
          myEventsTotalPages.value = newData.data?.totalPages ?? 1;

          var currentData = myEventsModel.value;
          currentData?.data?.data?.addAll(newData.data?.data ?? []);
          // Newest-created events first, regardless of the backend's order.
          currentData?.data?.data?.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          );
          myEventsModel.value = currentData;
          myEventsModel.refresh();
        } else {
          Utils.showToast(response['message'] ?? "Failed to fetch events", true);
        }
      } catch (e, stackTrace) {
        Utils.showToast("Something went wrong: $e", true);
        print("Error in getMyEvents(): $e");
        print(stackTrace);
      } finally {
        isLoadingMoreMyEvents.value = false;
      }
      return;
    }

    // Fresh load: just page 1, sorted locally by createdAt. Note the
    // backend's page 1 isn't guaranteed to contain the most recently
    // created event (its default list order isn't by createdAt) — a
    // brand-new event could land on a later page, in which case it'll
    // bubble to the top once Load More merges that page in below.
    myEventsCurrentPage.value = 1;
    isLoadingMyEvents.value = true;
    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.myEvents(myEventsCurrentPage.value),
        loading: true,
      );

      if (response != null && response['success'] == true) {
        final newData = GetMyEventModel.fromJson(response);
        myEventsTotalPages.value = newData.data?.totalPages ?? 1;
        newData.data?.data?.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
        myEventsModel.value = newData;
      } else {
        Utils.showToast(response['message'] ?? "Failed to fetch events", true);
      }
    } catch (e, stackTrace) {
      Utils.showToast("Something went wrong: $e", true);
      print("Error in getMyEvents(): $e");
      print(stackTrace);
    } finally {
      isLoadingMyEvents.value = false;
    }
  }

  Future<Map<String, dynamic>?> eventJoin(String eventId) async {
    final body = {};

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.joinEvent(eventId),
      body,
      loading: true,
    );

    if (responseMap["success"] != true) {
      return responseMap;
    }

    // Refresh events after successful join
    await getAllEvents();

    return responseMap;
  }

  Future<Map<String, dynamic>?> ignoreEventLink(String eventId) async {
    final body = {};

    final responseMap = await baseService.basePostAPI(
      ApiEndPoints.ignoreEventLink(eventId),
      body,
      loading: true,
    );

    return responseMap;
  }

  final RxBool isLoadingPendingInvitations = false.obs;

  Future<void> getPendingInvitations() async {
    isLoadingPendingInvitations.value = true;

    final responseMap = await baseService.baseGetAPI(
      ApiEndPoints.pendingInvitations(),
    );

    isLoadingPendingInvitations.value = false;

    if (responseMap["success"] != true) return;

    pendingInvitationModel.value = PendingInvitationModel.fromJson(responseMap);
  }

  Future<Map<String, dynamic>?> respondToInvitation(
    String invitationId,
    String status,
  ) async {
    final responseMap = await baseService.basePatchAPI(
      ApiEndPoints.respondToInvitation(invitationId),
      body: {"status": status},
      loading: true,
    );

    if (responseMap["success"] == true) {
      pendingInvitationModel.value?.data
          ?.removeWhere((invitation) => invitation.id == invitationId);
      pendingInvitationModel.refresh();
      getAllEvents();

    }

    return responseMap;
  }

  Map<String, String> formatDateTime(String isoString) {
    final dateTime = DateTime.parse(isoString).toLocal();

    return {
      "date": DateFormat('dd-MM-yyyy').format(dateTime),
      "time": DateFormat('hh:mm a').format(dateTime),
    };
  }

  /// Stores a bool value into selectedOptions as 'yes' or 'no'.
  /// Uses the SAME keys that yesNoWidget reads and getBoolOption parses.
  void _setOption(bool? value, int index) {
    if (value == null) return;
    profileController.selectedOptions[index] = value ? 'yes' : 'no';
    print(
      "_setOption index=$index value=${profileController.selectedOptions[index]}",
    );
  }

  // Future<void> getEventById(String eventId) async {
  //   isMenusLoading.value = true;
  //   try {
  //     final response = await baseService.baseGetAPI(
  //       ApiEndPoints.getEventById(eventId),
  //     );
  //     if (response["success"] == true) {
  //       final data = response["data"];
  //       final eventComfort = Map<String, dynamic>.from(
  //         response["data"]["eventComfort"] ?? {},
  //       );
  //       final guestAware = Map<String, dynamic>.from(
  //         response["data"]["guestAware"] ?? {},
  //       );
  //       print("Comfort: ${eventComfort}");
  //       print("Aware: ${guestAware}");
  //       final result = formatDateTime(data["eventTime"]);
  //
  //       getEventByIdModel.value = EventDetailsResponse.fromJson(response);
  //       // Utils.showToast(response["message"], false); // suppress toast on edit load
  //
  //       // // ── Basic event fields ──────────────────────────────────────────
  //       eventName.text = data["eventName"] ?? "";
  //       guestCount.text = data["estimatedGuests"] ?? "";
  //       eventDate.text = result['date']?.toString() ?? "";
  //       eventTime.text = result["time"] ?? "";
  //       eventType.text = data["eventType"] ?? "";
  //       selectedEventType.value =
  //           eventType.text.isEmpty ? null : eventType.text;
  //       eventLocation.text = data["address"] ?? "";
  //       inviteMsg.text = data["invitationMessage"] ?? "";
  //       parkingDetails.text = data["parkingDetails"] ?? "";
  //       addNote.text = data["addNote"] ?? "";
  //       locationController.addressController.text = data["address"] ?? "";
  //       profileController.profilePicture.value = data["image"];
  //
  //       // Print all values
  //       print("========== EVENT DETAILS ==========");
  //
  //       print("Event Name: ${eventName.text}");
  //       print("Guest Count: ${guestCount.text}");
  //       print("Event Date: ${eventDate.text}");
  //       print("Event Time: ${eventTime.text}");
  //       print("Event Type: ${eventType.text}");
  //       print("Selected Event Type: ${selectedEventType.value}");
  //       print("Event Location: ${eventLocation.text}");
  //       print("Invitation Message: ${inviteMsg.text}");
  //       print("Parking Details: ${parkingDetails.text}");
  //       print("Add Note: ${addNote.text}");
  //
  //       print(
  //         "Location Controller Address: "
  //         "${locationController.addressController.text}",
  //       );
  //
  //       print(
  //         "Profile Picture: "
  //         "${profileController.profilePicture.value}",
  //       );
  //       print("========== EVENT DETAILS ==========");
  //     } else {
  //       Utils.showToast(response["message"], true);
  //     }
  //   } catch (e) {
  //     print("Something went wrong in getEventById: $e");
  //   } finally {
  //     isMenusLoading.value = false;
  //   }
  // }
  Future<void> getEventById(String eventId) async {
    isMenusLoading.value = true;
    isNetworkImageDeleted.value = false;

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getEventById(eventId),
      );

    if (response["success"] == true) {
    final data = Map<String, dynamic>.from(
    response["data"] ?? {},
    );

    final eventComfort = Map<String, dynamic>.from(
    data["eventComfort"] ?? {},
    );

    final guestAware = Map<String, dynamic>.from(
    data["guestAware"] ?? {},
    );

    print("Comfort: $eventComfort");
    print("Aware: $guestAware");

    final result = formatDateTime(
    data["eventTime"]?.toString() ?? "",
    );

    // Save API response in model
    getEventByIdModel.value =
    EventDetailsResponse.fromJson(response);

    // ── Basic event fields ───────────────────────────────

    eventName.text =
    data["eventName"]?.toString() ?? "";

    // estimatedGuests is an int, so convert it to String
    guestCount.text =
    data["estimatedGuests"]?.toString() ?? "";

    eventDate.text =
    result["date"]?.toString() ?? "";

    eventTime.text =
    result["time"]?.toString() ?? "";

    eventType.text =
    data["eventType"]?.toString() ?? "";

    selectedEventType.value =
    eventType.text.trim().isEmpty
    ? null
        : eventType.text;

    eventLocation.text =
    data["address"]?.toString() ?? "";

    inviteMsg.text =
    data["invitationMessage"]?.toString() ?? "";

    parkingDetails.text =
    data["parkingDetails"]?.toString() ?? "";

    addNote.text =
    data["addNote"]?.toString() ?? "";

    locationController
        .addressController
        .text = data["address"]?.toString() ?? "";
    //
    // profileController
    //     .profilePicture
    //     .value = data["image"];

    imagePath = data["image"]?.toString() ?? "";
    // ── Print all values ─────────────────────────────────

    print("");
    print("========== EVENT DETAILS ==========");

    print("Event ID: $eventId");
    print("Event Name: ${eventName.text}");
    print("Guest Count: ${guestCount.text}");
    print("Event Date: ${eventDate.text}");
    print("Event Time: ${eventTime.text}");
    print("Event Type: ${eventType.text}");
    print(
    "Selected Event Type: "
    "${selectedEventType.value}",
    );
    print("Event Location: ${eventLocation.text}");
    print(
    "Invitation Message: "
    "${inviteMsg.text}",
    );
    print(
    "Parking Details: "
    "${parkingDetails.text}",
    );
    print("Add Note: ${addNote.text}");

    print(
    "Location Controller Address: "
    "${locationController.addressController.text}",
    );

    print(
    "Profile Picture: "
    "${imagePath}",
    );

    print("==================================");
    print("");
    } else {
    Utils.showToast(
    response["message"]?.toString() ??
    "Unable to get event details",
    true,
    );
    }
    } catch (e, stackTrace) {
    print(
    "Something went wrong in getEventById: $e",
    );

    print(
    "Stack trace: $stackTrace",
    );

    } finally {
    isMenusLoading.value = false;
    }
  }



  Future<void> GetAiMenu(String id, bool refresh, String prompt) async {
    isAiMenuLoading.value = true;
    aiMenuError.value = '';
    addedAiMenuKeys.clear();
    try {
      final body = {"prompt": prompt, "refresh": refresh};

      final responseMap = await baseService.basePostAPI(
        ApiEndPoints.aiMenu(id),
        body,
        loading: false,
      );
      if (responseMap["success"] != true) {
        aiMenuError.value =
            (responseMap["message"] ?? "Failed to fetch AI menu suggestions")
                .toString();
        return;
      }
      final data = responseMap["data"];
      if (data == null) {
        aiMenuError.value = "Failed to fetch AI menu suggestions";
        return; // Safety guard
      }

      getAiMenuModel.value = AiMenu.fromJson(responseMap);
      aiController.clear();
    } catch (e) {
      aiMenuError.value = "Failed to fetch AI menu suggestions";
      print("🍽️ Something went wrong in GetAiMenu: $e");
    } finally {
      isAiMenuLoading.value = false;
    }
  }

  void clearEventFields() {
    // ── Text fields ──────────────────────────────────────────────────────
    eventName.clear();
    eventDate.clear();
    eventTime.clear();
    eventType.clear();
    selectedEventType.value = null;
    eventLocation.clear();
    inviteMsg.clear();
    parkingDetails.clear();
    addNote.clear();
    eventReminder.clear();
    otherComfortController.clear();
    itemContainingController.clear();
    guestAwareOthersController.clear();
    guestContactController.clear();
    locationController.addressController.clear();
    selectedReminderTime.value = null;
    guestCount.clear();

    // ── Observables ──────────────────────────────────────────────────────
    profileController.profilePicture.value = null;
    selectedMenus.clear();
    addedAiMenuKeys.clear();
    poolSelection.value = '';
    guestsWelcomeToSwim.value = false;
    profileController.selectedOptions.clear();
    getEventByIdModel.value = null;

    // ── EventComfort booleans ────────────────────────────────────────────
    quietSpace = null;
    largerSeating = null;
    wheelChairAccess = null;
    aslInterpreter = null;
    veganMenu = null;
    restroom = null;

    // ── GuestAware booleans ──────────────────────────────────────────────
    petsPresent = null;
    childrenPresent = null;
    forAdultOnly = null;
    smokePresent = null;
    smokeFree = null;
    alcohol = null;
    alcoholFree = null;
    stepsToClimb = null;
    fireArms = null;
    shellFish = null;
    peanuts = null;
    endsInFirmTime = null;
    mayGuestsContact = null;
    print("✅ clearEventFields: all state reset");
  }

  Future<void> getAllAllergenList({String? eventId}) async {
    // Reset or set loading state at the start
    isLoadingAllerganList.value = true;

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getAllergenList(eventId ?? ''),
      );

      if (response != null && response['success'] == true) {
        // 1. Correctly parse and assign the data to your observable state
        getAllergenList.value = AllAllergen.fromJson(response);

        // Optional: Show a success message if needed
        // Utils.showToast(response['message'] ?? "Allergens fetched successfully", false);
      } else {
        // Handle API level failure safely
        String errorMsg =
            response != null
                ? response['message']
                : "Failed to fetch allergen List";
        Utils.showToast(errorMsg, true);
      }
    } catch (e, stackTrace) {
      Utils.showToast("Something went wrong", true);
      print("Error in getAllAllergenList(): $e");
      print(stackTrace);
    } finally {
      // Always stop loading spinners whether the call succeeded or failed
      isLoadingAllerganList.value = false;
    }
  }

  Future<void> getEventAllergens({String? eventId}) async {
    isLoadingEventAllergens.value = true;

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getEventAllergens(eventId ?? ''),
      );

      if (response != null && response['success'] == true) {
        getEventAllergenData.value = EventAllergenResponse.fromJson(response);
      } else {
        String errorMsg =
            response != null
                ? response['message']
                : "Failed to fetch allergen List";
        Utils.showToast(errorMsg, true);
      }
    } catch (e, stackTrace) {
      Utils.showToast("Something went wrong", true);
      print("Error in getEventAllergens(): $e");
      print(stackTrace);
    } finally {
      isLoadingEventAllergens.value = false;
    }
  }
}
