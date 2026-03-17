import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/location_controller.dart';
import 'package:yestable/core/services/apiendpoints.dart';
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/model/get_menu_model.dart';

import '../core/services/multipart_request.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';

class EventController extends GetxController{
 final LocationController locationController = Get.find<LocationController>();
  BaseService baseService = BaseService();
  final prefs = SharedPreferencesMethod.storage;

  final RxBool isMenusLoading = false.obs;
  final RxString menusError = ''.obs;
  final RxList<MenuItem> menus = <MenuItem>[].obs;
  final RxList<MenuItem> selectedMenus = <MenuItem>[].obs;

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

  var selectedType = RxnString();
  RxList<Map<String, String>> selectedMealCategory = <Map<String, String>>[].obs;  // List of categories
  final type = ["Appetizers", "Main Course", "Drinks"];
  final List<Map<String, String>> mealCategory = [
    {"name": "Vegetarian", "imgPath": "assets/png/event_food_image/brocolli.png"},
    {"name": "Dairy-Free", "imgPath": "assets/png/event_food_image/milk.png"},
    {"name": "Gluten-Free", "imgPath": "assets/png/event_food_image/glutenfree.png"},
    {"name": "Selfish", "imgPath": "assets/png/event_food_image/shell.png"},
    {"name": "Vegan", "imgPath": "assets/png/event_food_image/shell.png"},
    {"name": "Nut-Free", "imgPath": "assets/png/event_food_image/nutfree.png"},
  ];

  Future<void> createEvent() async {
    try {
      final lat = locationController.latitude.value;
      final lng = locationController.longitude.value;

      // Build ISO 8601 event time from separate date & time controllers
      String? isoEventTime;
      final dateStr = eventDate.text.trim();
      final timeStr = eventTime.text.trim();

      if (dateStr.isNotEmpty && timeStr.isNotEmpty) {
        try {
          // Expected formats:
          // date: "dd-MM-yyyy"
          // time: "hh:mm AM/PM"
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

      final body = {
        "image": "",
        "eventName": eventName.text.trim(),
        "eventTime": isoEventTime,
        "eventType": typeValue,
        "location": {
          "type": "Point",
          "coordinates": [lng, lat],
        },
        "invitationMessage": inviteMsg.text.trim(),
        "parkingDetails": parkingDetails.text.trim(),
        "addNote": addNote.text.trim(),
        "reminderNotification": true,
        "members": [],
        "menus": selectedMenus.map((m) => m.id).whereType<String>().toList(),
        "displayMenu": selectedMenus.isNotEmpty,
      };

      final res = await baseService.basePostAPI(
        ApiEndPoints.createEvent,
        body,
        loading: true,
      );

      if (res["success"] == true) {
        Utils.showToast(res["message"] ?? "Event created", false);
        Get.toNamed("eventcomfortone", arguments: res["data"]["_id"]);
      }
    } catch (e) {
      Utils.showToast("Failed to create event", true);
    }
  }

  Future<void> getMenus({bool loading = false}) async {
    isMenusLoading.value = true;
    menusError.value = '';
    try {
      final response = await baseService.baseGetAPI(ApiEndPoints.getMenus, loading: loading);
      if (response["success"] == true) {
        final model = GetMenuModel.fromJson(Map<String, dynamic>.from(response));
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

  // Future<void> uploadMenu() async {
  //
  //   final fields = {
  //     "title": menuTitle.text.trim(),
  //     "type": selectedType.value ?? "", // fallback to empty string
  //     "mealCategory": jsonEncode(
  //         selectedMealCategory.map((e) => e["name"] ?? "").toList()
  //     ),
  //     "description": menuDescription.text.trim(),
  //   };
  //
  //   // Make sure itemPic.value is a File? type
  //   File? menuImageFile = itemPic.value; // itemPic must be a File
  //
  //   await _sendMultipartMenuRequest(
  //     ApiEndPoints.addMenu,
  //     fields,
  //     menuImageFile,
  //   );
  // }
  //
  // Future<void> _sendMultipartMenuRequest(
  //     String endpoint,
  //     Map<String, String> fields,
  //     File? menuImage,
  //     ) async {
  //   try {
  //     print("Meal Category: ${jsonEncode(
  //         selectedMealCategory.map((e) => e["name"] ?? "").toList()
  //     )}");
  //     final url = "${baseService.baseURL}$endpoint";
  //     final uri = Uri.parse(url);
  //
  //     var request = http.MultipartRequest('POST', uri);
  //     final token = prefs.getString(LocalDBKeys.TOKEN);
  //     print("Token: $token");
  //
  //     // Headers
  //     request.headers.addAll({
  //       "Accept": "application/json",
  //       "Authorization": "Bearer $token",
  //     });
  //
  //     // Text fields
  //     request.fields.addAll(fields);
  //     print("📋 Fields: ${request.fields}");
  //
  //     // File
  //     if (menuImage != null) {
  //       print("📸 Adding menuImage: ${menuImage.path}");
  //
  //       String ext = path.extension(menuImage.path).toLowerCase();
  //       String mimeType = 'image/jpeg';
  //       if (ext == '.png') mimeType = 'image/png';
  //       else if (ext == '.jpg' || ext == '.jpeg') mimeType = 'image/jpeg';
  //       else if (ext == '.gif') mimeType = 'image/gif';
  //
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           'menuImage', // must match backend key
  //           menuImage.path,
  //           contentType: MediaType('image', mimeType.split('/')[1]),
  //         ),
  //       );
  //     }
  //
  //     print("⏳ Sending request...");
  //
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     print("📦 Status: ${response.statusCode}");
  //     print("📦 Body: ${response.body}");
  //
  //     final jsonResponse = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Utils.showToast("${jsonResponse['message']}", false);
  //       Get.toNamed('menuSuccessScreen'); // Navigate on success
  //       clearItemFields();
  //     } else {
  //       Utils.showToast(
  //         jsonResponse['message'] ?? "Something went wrong",
  //         false,
  //       );
  //     }
  //   } catch (e) {
  //     print("❌ Error: $e");
  //     Utils.showToast("Check Internet Connection", false);
  //   }
  // }
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
       Get.back();
       clearItemFields();
     } else {
       Utils.showToast(jsonResponse['message'] ?? "Something went wrong", false);
     }
   } catch (e) {
     print("❌ Error: $e");
     Utils.showToast("Check Internet Connection", false);
   }
 }
  void clearItemFields(){
    itemPic.value = null;
    menuTitle.clear();
    menuDescription.clear();
    selectedType.value = null;
    selectedMealCategory.value = [];
  }
}