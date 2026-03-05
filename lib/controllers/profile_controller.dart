import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:yestable/core/services/base_services.dart';
import 'package:yestable/core/services/multipart_request.dart';
import 'package:yestable/outh_file/local_db_key.dart';

import '../core/services/apiendpoints.dart';
import '../core/services/multipart_request.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';

class ProfileController extends GetxController {
  // --- Existing Variables (No changes here) ---
  BaseService baseService = BaseService();
  final prefs = SharedPreferencesMethod.storage;


  var profilePicture = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  var switchValue = true.obs;
  var switchValue2 = true.obs;
  RxString selectedValue = ''.obs;
  RxBool isSelected = false.obs;
  RxMap<int, String> selectedOptions = <int, String>{}.obs;
  var selectedAllergens = <int>{}.obs;
  var foodNationality = <int>{}.obs;
  var other = false.obs;
  var other2 = false.obs;
  var other3 = false.obs;
  var isChecked = false.obs;
  var isRadioChecked = false.obs;
  RxBool isYes = false.obs;

  // final RxBool isPlaceExpanded = false.obs;
  RxBool isArrowRotated = false.obs;
  RxBool isExpanded = false.obs;
  RxString selectedOption = "Hearing Loss".obs;
  // final RxList<int> places = <int>[0].obs; // first item permanent

  final RxList<int> places = <int>[0].obs;
  final RxBool isPlaceExpanded = false.obs;
  final RxBool isPreferences = false.obs;
  final RxBool isProfilePublic = true.obs;

  // Set Your Table Controllers
  final TextEditingController otherController = TextEditingController();
  final TextEditingController otherRootRuleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController location  = TextEditingController();
  final TextEditingController customPronoun = TextEditingController();
  RxInt pronounIsSelected = 0.obs;
  String pronounsValue(){
    if(pronounIsSelected.value == 0){
      return "he/him";
    }
    else if(pronounIsSelected.value == 1){
      return "she/her";
    }
    else if(pronounIsSelected.value == 2){
      return "They/them";
    }
    else{
      return customPronoun.text;
    }
  }
  var itemIsSelected = (-1).obs; // if needed
  final selectSeatingRequirements = <String>[].obs;
  final selectExtraAssistance = <String>[].obs;

  List<String> seating = ['largerSeat', 'chairWithArms', 'nearRestroom', 'other'];
  List<String> assistance = [
    'helpCarryingPlate',
    'nearRestroom',
    'nonVerbal',
    'bringingCareAide',
    'hearingLoss',
    'assistanceWalkingIn',
    'other'
  ];

  RxBool showSeatingOther = false.obs;
  RxBool showAssistanceOther = false.obs;

  void toggleSeatingSelection(int index) {
    String value = seating[index];

    if (value == 'other') {
      showSeatingOther.toggle();

      if (!showSeatingOther.value) {
        seatingOther.clear();
        selectSeatingRequirements.remove(seatingOtherValue);
        seatingOtherValue = null;
      }

      return;
    }

    if (selectSeatingRequirements.contains(value)) {
      selectSeatingRequirements.remove(value);
    } else {
      selectSeatingRequirements.add(value);
    }
  }


  void toggleAssistanceSelection(int index) {
    String value = assistance[index - seating.length];

    if (value == 'other') {
      showAssistanceOther.toggle();

      if (!showAssistanceOther.value) {
        assistanceOther.clear();
        selectExtraAssistance.remove(assistanceOtherValue);
        assistanceOtherValue = null;
      }

      return;
    }

    if (selectExtraAssistance.contains(value)) {
      selectExtraAssistance.remove(value);
    } else {
      selectExtraAssistance.add(value);
    }
  }


  final TextEditingController mobilityConcerns  = TextEditingController();
  final TextEditingController anythingElse  = TextEditingController();
  final TextEditingController seatingOther  = TextEditingController();
  final TextEditingController assistanceOther  = TextEditingController();


  String? seatingOtherValue;
  String? assistanceOtherValue;

  void updateOtherFields() {
    // Seating
    String seatingText = seatingOther.text.trim();

    if (seatingText.isNotEmpty) {
      if (seatingOtherValue != null) {
        selectSeatingRequirements.remove(seatingOtherValue);
      }

      selectSeatingRequirements.add(seatingText);
      seatingOtherValue = seatingText;
    }

    // Assistance
    String assistanceText = assistanceOther.text.trim();

    if (assistanceText.isNotEmpty) {
      if (assistanceOtherValue != null) {
        selectExtraAssistance.remove(assistanceOtherValue);
      }

      selectExtraAssistance.add(assistanceText);
      assistanceOtherValue = assistanceText;
    }
  }

  void removeOtherIfEmpty() {
    if (seatingOther.text.trim().isEmpty && seatingOtherValue != null) {
      selectSeatingRequirements.remove(seatingOtherValue);
      seatingOtherValue = null;
    }

    if (assistanceOther.text.trim().isEmpty && assistanceOtherValue != null) {
      selectExtraAssistance.remove(assistanceOtherValue);
      assistanceOtherValue = null;
    }
  }

  final TextEditingController bio  = TextEditingController();
  TextEditingController otherMoodController = TextEditingController();
  RxBool shareToggle = false.obs;


  final List<Map<String, String>> foodOptions = [
    {"name": "Italian", "imgPath": "assets/png/profile_food_images/pizza.png"},
    {"name": "American Comfort", "imgPath": "assets/png/profile_food_images/burger.png"},
    {"name": "Mexican", "imgPath": "assets/png/profile_food_images/mexican.png"},
    {"name": "Mediterranean", "imgPath": "assets/png/profile_food_images/meditrain.png"},
    {"name": "Japanese", "imgPath": "assets/png/profile_food_images/sushi.png"},
    {"name": "Indian", "imgPath": "assets/png/profile_food_images/indian.png"},
    {"name": "Thai", "imgPath": "assets/png/profile_food_images/thai.png"},
  ];

  var foodMoodOptionList = <Map<String, String>>[].obs; // reactive list
// ✅ Call this after every select/deselect
  void updateFoodMoodList() {
    foodMoodOptionList.value =
        foodNationality.map((i) => {"mood": foodOptions[i]["name"]!}).toList();

    print("🔥 Selected FoodMoodOptionList: $foodMoodOptionList");
  }


  // More About Your Plates
  String getSelectedPlateString() {
    List<String> values = [];

    for (var index in selectedAllergens) {
      switch (index) {
        case 1:
          values.add("vegan");
          break;
        case 2:
          values.add("vegetarian");
          break;
        case 3:
          values.add("halal");
          break;
        case 4:
          values.add("kosher");
          break;
        case 5:
          values.add("keto");
          break;
      }
    }

    // Add "Other" text if not empty
    String otherText = otherRootRuleController.text.trim();
    if (otherText.isNotEmpty) {
      values.add(otherText);
    }

    return values.join(',');
  }

  final List<String> more = [
    "🍀 Vegan",
    "🥬 Vegetarian",
    "Halal",
    "Kosher",
    "Keto",
  ];

  final List<Map<String, String>> yuckList = [
    {"name": "Cilantro", "imgPath": "assets/png/profile_food_images/dhaniya.png"},
    {"name": "Mushrooms", "imgPath": "assets/png/profile_food_images/mushroom_new.png"},
    {"name": "Mayonnaise", "imgPath": "assets/png/profile_food_images/mayonise.png"},
    {"name": "Olives", "imgPath": "assets/png/profile_food_images/olive.png"},
    {"name": "Blue Cheese", "imgPath": "assets/png/profile_food_images/bluecheese.png"},
    {"name": "Raw Onions", "imgPath": "assets/png/profile_food_images/onion.png"},
    {"name": "Spicy Heat", "imgPath": "assets/png/profile_food_images/spicyfood.png"},
  ];



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

  final yuck = <String>[].obs;
  final yum = <String>[].obs;

  void updateYumYuck() {
    yuck.clear();
    yum.clear();

    for (int i = 0; i < foodSelections.length; i++) {
      int selection = foodSelections[i]; // 0, 1, or 2 (your logic)
      String title = yuckOrYumList[i];   // <-- use i as index to get title
      String cleanTitle = title.split(' ').sublist(1).join(' ').toLowerCase();

      if (selection == 1) {
        yum.add(cleanTitle);
      } else if (selection == 2) {
        yuck.add(cleanTitle);
      }
    }
  }

// Example JSON
  Map<String, dynamic> getYumYuckJson() {
    return {
      "yumYuck": {
        "yum": yum.toList(),
        "yuck": yuck.toList(),
      }
    };
  }


  // --- Existing Methods (No changes here) ---
  void checkBox() {
    isSelected.value = !isSelected.value;
  }

  void select(String value) {
    selectedValue.value = value;
  }

  RxBool IsYes(){
    if(selectedValue.value == 'Yes'){
      isYes.value = true;
    } else {
      isYes.value = false;
    }
    return isYes;
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

  void otherToggleSwitch2() {
    other2.value = !other2.value;
  }

  void otherToggleSwitch3() {
    other3.value = !other3.value;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }



  // Pick from camera
  Future<void> pickFromCamera() async {
    final XFile? file =
    await _picker.pickImage(source: ImageSource.camera);

    if (file == null) return;
    profilePicture.value = File(file.path);
    print(profilePicture.value);
  }

  // Pick from gallery
  Future<void> pickFromGallery() async {
    final XFile? file =
    await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    profilePicture.value = File(file.path);
    print(profilePicture.value);
  }

  /// Allergens
  final RxMap<String, String> commanAllergens = <String, String>{}.obs;
  final List<String> levels = [
    "🚨 Severe Allergy",
    "🤧 Mild Or Digestive Reaction",
    "🙏🏼 Avoid For Belief Or Culture",
    "👋 No Allergy Just A Preference",
  ];
  // final List<String> more = [
  //   "🍀 Vegan",
  //   "🥬 Vegetarian",
  //   "Halal",
  //   "Kosher",
  //   "Keto",
  // ];
  final List<String> allergenKeys = [
    "peanut",
    "dairy",
    "gluten",
    "eggs",
    "soy",
    "fish",
    "shellFish",
    "treeNuts",
    "sesame",
    "others",
  ];
  final List<Map<String, dynamic>> allergens = [
    {
      "progress": 0.3.obs,
      "title": "🥜 Peanuts",
      "desc": "Severe Allergy (Anaphylaxis)",
      "circleImg": "🥜",
      "isEmoji" : false,
    },
    {
      "progress": 0.0.obs,
      "title": "Tree Nuts",
      "desc": "No Allergy",
      "circleImg": "🤗",
      "isEmoji" : true,
      "path" : "assets/png/profile_food_images/tree_nut.png",
    },
    {
      "progress": 0.0.obs,
      "title": "Sesame",
      "desc": "No Allergy",
      "circleImg": "🤗",
      "isEmoji" : true,
      "path" : "assets/png/profile_food_images/sesame.png",
    },
    {
      "progress": 0.0.obs,
      "title": "🌾 Gluten",
      "desc": "Severe Allergy",
      "circleImg": "🌾",
      "isEmoji" : false
    },
    {
      "progress": 0.8.obs,
      "title": "🥚 Eggs",
      "desc": "Avoid for Beliefs or Culture",
      "circleImg": "🥚",
      "isEmoji" : false
    },
    {
      "progress": 0.7.obs,
      "title": "🫘 Soy",
      "desc": "Mild or Digestive Reaction",
      "circleImg": "🫘",
      "isEmoji" : false
    },
    {
      "progress": 0.6.obs,
      "title": " Fish",
      "desc": "Severe Allergy (Anaphylaxis)",
      "circleImg": "📷",
      "isEmoji" : true,
      "path" : "assets/png/profile_food_images/gold_fish.png",
    },
    {
      "progress": 0.0.obs,
      "title": "🦐 Shellfish",
      "desc": "No Allergy",
      "circleImg": "🦐",
      "isEmoji" : false
    },
    {
      "progress": 0.0.obs,
      "title": "🥛 Dairy",
      "desc": "No Allergy",
      "circleImg": "🥛",
      "isEmoji" : false,


    },
  ];
  String getAllergyType(double progress) {
    double percentage = progress * 100;

    if (percentage <= 30) {
      return "No Allergy";
    } else if (percentage < 60) {
      return "Mild or Digestive Reaction";
    } else if (percentage < 80) {
      return "Avoid for belief or Culture";
    } else {
      return "Severe Allergy (Anaphylaxis)";
    }
  }
  void updateProgress(int index, double newProgress) {
    allergens[index]['progress'].value = newProgress;

    allergens[index]['desc'] =
        getAllergyType(newProgress);
  }

  Future<void> setupProfile({File? profilePic}) async {
    final fields = {
      "name": nameController.text.trim(),
      "username": userName.text.trim(),
      "pronoun": pronounsValue(),
      "location": location.text.trim(),
      "bio": bio.text.trim(),
      "isProfilePublic": switchValue.value.toString(), // MUST be string
    };

    await _sendMultipartRequest(
      ApiEndPoints.setupProfile,
      fields,
      profilePic,
    );
  }

  Future<void> _sendMultipartRequest(
      String endpoint,
      Map<String, String> fields,
      File? profilePic,
      ) async {
    try {
      final url = "${baseService.baseURL}$endpoint";
      final uri = Uri.parse(url);

      var request = http.MultipartRequest('POST', uri);
      final token = prefs.getString(LocalDBKeys.TOKEN);
      print("Token: $token");

      /// Add Headers if required
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",  // if needed
      });

      /// Add text fields
      request.fields.addAll(fields);
      print("📋 Fields: ${request.fields}");

      /// Add profile image dynamically
      if (profilePic != null) {
        print("📸 Adding profilePic: ${profilePic.path}");

        // Detect MIME type from file extension
        String ext = path.extension(profilePic.path).toLowerCase(); // .jpg, .png, etc.
        String mimeType = 'image/jpeg'; // default
        if (ext == '.png') mimeType = 'image/png';
        else if (ext == '.jpg' || ext == '.jpeg') mimeType = 'image/jpeg';
        else if (ext == '.gif') mimeType = 'image/gif';

        request.files.add(
          await http.MultipartFile.fromPath(
            'profilePic', // ✅ MUST match Postman key
            profilePic.path,
            contentType: MediaType('image', mimeType.split('/')[1]),
          ),
        );
      }

      print("⏳ Sending request...");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.showToast("Profile setup successfully", false);

        // Example if backend returns user data
        // final userId = jsonResponse['data']['user']['id'];
        Get.toNamed('allergiesdietryscreen');
      } else {
        Utils.showToast(
          jsonResponse['message'] ?? "Something went wrong",
          false,
        );
      }
    } catch (e) {
      print("❌ Error: $e");
      Utils.showToast("Check Internet Connection", false);
    }
  }

  Future<void> UpdateAllergensPlate() async {
    List<String> platesList = getSelectedPlateString()
        .split(',')               // ["vegan", "other"]
        .map((e) => e.trim())     // trim spaces
        .toList();
    print("formatteddddd: ${platesList}");
    try {
      // Construct your API body
      Map<String, dynamic> body = {
        "commonAllergens": commanAllergens,
        "plate": platesList,
        "favMood": foodMoodOptionList
      };
      // Make PATCH API call
      final response = await baseService.basePatchAPI(
        ApiEndPoints.updateAllergensPlate,
        body: body,
        loading: true, // show loading if needed
      );

      if (response["success"] == true) {
        Utils.showToast("Preferences updated successfully", false);
        print("Response: $response");
        Get.toNamed('foodpreferencesone');
        otherToggleSwitch();
        otherToggleSwitch2();
        otherToggleSwitch3();
      } else {
        // API returned error
        print("Error: ${response["message"]}");
        Utils.showToast('${response['message']}', true);
      }
    } catch (e) {
      print("Unexpected error: $e");
      Utils.showToast("Something went wrong", true);
    }
  }

  Future<void> UpdateYumYuckAPI() async {
    try {
      updateYumYuck();

      // Get the JSON body
      final body = getYumYuckJson();

      // Make the PATCH request
      final response = await baseService.basePatchAPI(
        ApiEndPoints.updateYumYuck,
        body: body, // pass your JSON here
      );

      if (response != null && response['success'] == true) {
        print('YumYuck updated successfully');
        Get.toNamed("foodpreferencestwo");
        Utils.showToast('${response['message']}', false);
        print("yum: ${yum}");
        print("yuck: ${yuck}");
      } else {
        print('Failed to update YumYuck: ${response?['message']}');
        Utils.showToast('${response?['message']}', true);
      }
    } catch (e) {
      print('Error updating YumYuck: $e');
      Utils.showToast("Something went wrong", true);
    }
  }

  Future<void> UpdateSeatingAssistance() async {
    try {
      final body = {
        "seatingRequirement": {
          "options": selectSeatingRequirements.toList(),
        },
        "extraAssistance": {
          "options": selectExtraAssistance.toList(),
        },
        "quietArea": isYes.value,
        "mobilityConcerns": mobilityConcerns.text.trim(),
        "needAnythingElse": anythingElse.text.trim(),
      };

      final response = await baseService.basePatchAPI(
        ApiEndPoints.seatingAssistance,
        body: body,
      );

      if (response != null && response['success'] == true) {
        Utils.showToast("${response['message']}", false);
        print("Success: $response");
        print("seating: ${selectSeatingRequirements}",);
        print("assistance: ${selectExtraAssistance}");
        print("mobility: ${mobilityConcerns.text.trim()}",);
        print("else: ${anythingElse.text.trim()}");
        print("seating: ${seatingOther.text.trim()}");
        print("assistance: ${assistanceOther.text.trim()}",);
        print("isQuite: ${IsYes()}",);
        showSeatingOther.value = !showSeatingOther.value;
        showAssistanceOther.value = !showAssistanceOther.value;
        Get.toNamed("allownotificationscreen");
      } else {
        print("Failed: ${response?['message']}");
        Utils.showToast(response?['message'] ?? "Update failed", true);
      }
    } catch (e) {
      print("Error updating seating assistance: $e");
      Utils.showToast("Something went wrong", true);
    }
  }
}
