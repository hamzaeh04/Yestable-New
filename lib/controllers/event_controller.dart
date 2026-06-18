import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/model/get_event_review_model.dart';
import 'package:yestable/model/get_my_event_model.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/base_services.dart';
import '../core/services/firebase_messaging/messaging_service.dart';
import '../model/get_all_event_model.dart';
import '../model/get_allergen_list.dart';
import '../model/get_menu_model.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../widget/event_posted_dialog.dart';
import '../widget/showShareDialogBox_widget.dart';
import 'location_controller.dart';
import 'navigation_controller.dart';

class EventController extends GetxController{
  ProfileController profileController = Get.find<ProfileController>();

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

  var selectedEventType = RxnString();
  var selectedReminderTime = RxnString();
  Rxn<EventReviewModel> eventReviewModel = Rxn<EventReviewModel>();
  Rxn<GetAllEventsModel> getAllEventsModel = Rxn<GetAllEventsModel>();
  Rxn<GetMyEventModel> myEventsModel = Rxn<GetMyEventModel>();
  Rxn<GetMenuModel> getMenuModel = Rxn<GetMenuModel>();
  Rxn<EventAllergenResponse> getAllergenList = Rxn<EventAllergenResponse>();
  Rxn<EventAllergenResponse> getEventAllergenData = Rxn<EventAllergenResponse>();

  // Guest Aware Controllers
  final TextEditingController swimmingPoolController = TextEditingController();
  final TextEditingController itemContainingController = TextEditingController();
  final TextEditingController guestAwareOthersController = TextEditingController();
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
  final RxBool isLoadingAllerganList = false.obs;
  final RxBool isLoadingEventAllergens = false.obs;
  final RxBool isLoadingCreateEvent = false.obs;
  final RxString menusError = ''.obs;
  final RxList<MenuItem> menus = <MenuItem>[].obs;
  final RxList<MenuItem> selectedMenus = <MenuItem>[].obs;

  final TextEditingController menuTitle = TextEditingController();
  final TextEditingController menuDescription = TextEditingController();

  var itemPic = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  Future<void> pickFromGallery() async {
    final XFile? file =
    await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    itemPic.value = File(file.path);
    print(itemPic.value);
  }

  void removeImage() {
    itemPic.value = null;
  }
  final List<String> eventMenuList = ["Vegetarian", "Contain Dairy","Gluten-Free","Shelfish","Vegan","Nut-Free"];

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
  RxList<Map<String, String>> selectedMealCategory = <Map<String, String>>[].obs;  // List of categories
  final type = ["Appetizers", "Main Course", "Drinks"];
  final List<Map<String, String>> mealCategory = [
    {"name": "Vegetarian", "imgPath": "assets/png/event_food_image/brocolli.png"},
    {"name": "Dairy-Free", "imgPath": "assets/png/event_food_image/milk.png"},
    {"name": "Gluten-Free", "imgPath": "assets/png/event_food_image/glutenfree.png"},
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
          final period = timeParts.length > 1 ? timeParts[1].toUpperCase() : 'AM';

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

      final typeValue = eventType.text.trim().isEmpty
          ? "Private"
          : eventType.text.trim();

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

        // ✅ Proper nested object format
        "location[type]": "Point",
        "location[coordinates][0]": lng.toString(),
        "location[coordinates][1]": lat.toString(),
      };


      // menus array
      List<String> menus = selectedMenus
          .map((m) => m.id)
          .whereType<String>()
          .toList();

      await _sendMultipartEventRequest(
        ApiEndPoints.createEvent,
        fields,
        menus,
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
      List<String> menus,
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
      for (var menu in menus) {
        request.fields['menus[]'] = menu;
      }

      // Add image
      if (image != null) {
        String ext = path.extension(image.path).toLowerCase();
        String mimeType = 'image/jpeg';

        if (ext == '.png') mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg') mimeType = 'image/jpeg';
        else if (ext == '.gif') mimeType = 'image/gif';

        request.files.add(await http.MultipartFile.fromPath(
          'image', // make sure backend expects this key
          image.path,
          contentType: MediaType('image', mimeType.split('/')[1]),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast(jsonResponse['message'] ?? "Event created", false);

        String eventId = jsonResponse["data"]["_id"];
        String eventImage = jsonResponse["data"]["image"] ?? "";
        String link = generateEventLink(eventId);
        final adminName = pref.getString(LocalDBKeys.USERFULLNAME);
        final adminId = pref.getString(LocalDBKeys.USERID);
        print("sjkfghigshdsdsasdbv : ${adminId}");
        print("sjkfghigshdsdsasdbv : ${eventImage}");
        messagingService.createGroup(imagePath: eventImage, name: eventName.text, createdBy: adminName ?? '', enableGroup: switchValue3.value,eventId:eventId.toString(),adminId: adminId!,invitationMsg: inviteMsg.text,adminProfilePic: profileController.getMyProfileModel.value?.data?.profilePic ?? "");
        showShareProfileDialog(
          context,
          title: "Share Event Link",
          link: link,
          onTap: () {
            Clipboard.setData(ClipboardData(text: link));
            Utils.showToast("Link copied!", false);
          },
          onCancel: () {
            Navigator.pop(context);
            Get.toNamed("eventcomfortone", arguments: eventId);
          },
        );
      } else {
        Utils.showToast(jsonResponse['message'] ?? "Something went wrong", false);
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", false);
    } finally{
      EasyLoading.dismiss(); // ✅ MUST
    }
  }


  Future<void> editEvent({
    required String eventId,
    File? image,
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
      eventType.text.trim().isEmpty ? "Private" : eventType.text.trim();

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
      };
      print("📤 API Fields: $fields");
      // menus array
      List<String> menus = selectedMenus
          .map((m) => m.id)
          .whereType<String>()
          .toList();

      await _sendMultipartEditRequest(
        ApiEndPoints.editEvent(eventId),
        fields,
        menus,
        image,
        eventId,
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

      // Add menus array
      for (var menu in menus) {
        request.fields.addAll({'menus[]': menu});
      }

      // Add image
      if (image != null) {
        String ext = path.extension(image.path).toLowerCase();
        String mimeType = 'image/jpeg';

        if (ext == '.png') mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg') mimeType = 'image/jpeg';
        else if (ext == '.gif') mimeType = 'image/gif';

        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', mimeType.split('/')[1]),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast(jsonResponse['message'] ?? "Event updated", false);
        eventReviewModel.refresh();
        // Get.toNamed('eventdetailsscreen', arguments: eventId);
        Get.toNamed("eventcomfortone", arguments: eventId);

      } else {
        Utils.showToast(
            jsonResponse['message'] ?? "Something went wrong", false);
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
      final response = await baseService.baseGetAPI(ApiEndPoints.getMenus);
      if (response["success"] == true) {
        final model = GetMenuModel.fromJson(Map<String, dynamic>.from(response));
        getMenuModel.value = model;
        menus.assignAll(model.data?.data ?? <MenuItem>[]);
      } else {
        menus.clear();
        menusError.value = (response["message"] ?? "Failed to fetch menus").toString();
      }
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

  bool removeSelectedMenuById(String? id) {
    if (id == null || id.isEmpty) return false;
    final before = selectedMenus.length;
    selectedMenus.removeWhere((m) => m.id == id);
    return selectedMenus.length != before;
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
                onSurface: blackColor,  // dates text color
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
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: whiteColor,
                hourMinuteColor: primaryColor,
                hourMinuteTextColor: whiteColor,
                dayPeriodTextColor: accentColor,       // 👈 AM/PM text color
                dayPeriodColor: accentColor.withOpacity(0.2), // 👈 AM/PM selected bg
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

  Future<void> uploadMenu() async {
    // Remove jsonEncode
    final fields = {
      "title": menuTitle.text.trim(),
      "type": selectedType.value ?? "",
      "description": menuDescription.text.trim(),
    };

    // Prepare list of meal categories
    List<String> mealCategories =
    selectedMealCategory.map((e) => e["name"] ?? "").toList();

    // Send request
    await _sendMultipartMenuRequest(
      ApiEndPoints.addMenu,
      fields,
      mealCategories,
      itemPic.value,
    );
  }

  Future<void> _sendMultipartMenuRequest(
      String endpoint,
      Map<String, String> fields,
      List<String> mealCategories,
      File? menuImage,
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

      // Add mealCategory as array
      for (var category in mealCategories) {
        request.fields['mealCategory[]'] = category;
      }

      // Add image
      if (menuImage != null) {
        String ext = path.extension(menuImage.path).toLowerCase();
        String mimeType = 'image/jpeg';
        if (ext == '.png') mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg') mimeType = 'image/jpeg';
        else if (ext == '.gif') mimeType = 'image/gif';

        request.files.add(await http.MultipartFile.fromPath(
          'menuImage',
          menuImage.path,
          contentType: MediaType('image', mimeType.split('/')[1]),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast("${jsonResponse['message']}", false);
        // Get.toNamed('menuSuccessScreen');
        clearItemFields();
        getMenus();
        Get.back();
      } else {
        Utils.showToast(jsonResponse['message'] ?? "Something went wrong", false);
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", false);
    } finally{
      getMenuModel.refresh();
      menus.refresh();
      EasyLoading.dismiss();
    }
  }
  void clearItemFields(){
    itemPic.value = null;
    menuTitle.clear();
    menuDescription.clear();
    selectedType.value = null;
    selectedMealCategory.value = [];
  }

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
        Get.toNamed("eventcomforttwo", arguments: eventId);
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
    bool? mayGuestsContact = getBoolOption(profileController, 14);

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

      Utils.showToast(
        "Something went wrong: $e",
        true,
      );

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

        mapEventComfortAccessibility(
          data?.eventComfort,
          data?.guestAware,
        );

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
    } finally{
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
        eventPostedDialog(context);
        clearEventFields();
        // Optional: navigate or refresh
        // Get.back();
        // eventReview(eventId);

      } else {
        // API returned failure
        Utils.showToast(
            response?['message'], true
        );
      }
    } catch (e) {
      Utils.showToast(
        "Error ${e}", true
      );
    } finally {
      isMenusLoading.value = false;
    }
  }

  Future<void> getAllEvents({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= totalPages) return; // no more pages
      isLoadingMore.value = true;
      currentPage += 1;
    } else {
      currentPage = 1;
      isLoadingAllEvents.value = true;
    }

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.getAllEvent(currentPage),
      );

      if (response != null && response['success'] == true) {
        final newData = GetAllEventsModel.fromJson(response);

        totalPages = newData.data?.totalPages ?? 1;

        if (loadMore) {
          // Append new events
          getAllEventsModel.update((val) {
            val?.data?.data?.addAll(newData.data?.data ?? []);
          });
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

  var isLoadingMore = false.obs;
  int currentPage = 1;
  int totalPages = 1; // Update after API response

  Future<void> getMyEvents({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= totalPages) return; // No more pages
      isLoadingMore.value = true;
      currentPage += 1;
    } else {
      currentPage = 1; // Reset for fresh load
      isLoadingMyEvents.value = true;
    }

    try {
      final response = await baseService.baseGetAPI(
        ApiEndPoints.myEvents(currentPage),
        loading: true,
      );

      if (response != null && response['success'] == true) {
        final newData = GetMyEventModel.fromJson(response);

        totalPages = newData.data?.totalPages ?? 1;

        if (loadMore) {
          // Append new events to existing list
          myEventsModel.update((val) {
            val?.data?.data?.addAll(newData.data?.data ?? []);
          });
        } else {
          myEventsModel.value = newData;
        }

        // Utils.showToast(response['message'] ?? "Events fetched successfully", false);
      } else {
        Utils.showToast(response['message'] ?? "Failed to fetch events", true);
      }
    } catch (e, stackTrace) {
      Utils.showToast("Something went wrong: $e", true);
      print("Error in getMyEvents(): $e");
      print(stackTrace);
    } finally {
      isLoadingMyEvents.value = false;
      isLoadingMore.value = false;
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

    final data = responseMap["data"]; // user object
    final msg = responseMap["message"];

    if (data == null) return responseMap;

    return responseMap; // ✅ full response return
  }

  void clearEventFields(){
    eventName.clear();
    eventDate.clear();
    eventTime.clear();
    eventType.clear();
    eventLocation.clear();
    inviteMsg.clear();
    parkingDetails.clear();
    addNote.clear();
    eventReminder.clear();
    otherComfortController.clear();
    locationController.addressController.clear();
    itemContainingController.clear();
    guestAwareOthersController.clear();
    profileController.profilePicture.value = null;
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
        getAllergenList.value = EventAllergenResponse.fromJson(response);

        // Optional: Show a success message if needed
        // Utils.showToast(response['message'] ?? "Allergens fetched successfully", false);
      } else {
        // Handle API level failure safely
        String errorMsg = response != null ? response['message'] : "Failed to fetch allergen List";
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
        String errorMsg = response != null ? response['message'] : "Failed to fetch allergen List";
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
