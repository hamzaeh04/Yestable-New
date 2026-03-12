import 'package:flutter/foundation.dart';

class GetMyProfile {
  final bool? success;
  final int? statusCode;
  final String? message;
  final ProfileData? data;

  GetMyProfile({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetMyProfile.fromJson(Map<String, dynamic> json) {
    return GetMyProfile(
      success: json['success'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ProfileData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ProfileData {
  final String? id;
  final String? email;
  final String? name;
  final bool? iAmHosting;
  final bool? notificationOpen;
  final int? onboardingStep;
  final bool? profileCompleted;
  final bool? isOnboarding;
  final bool? isNotificationAllowed;
  final List<String>? fcmTokens;
  final List<Member>? members;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? bio;
  final bool? isProfilePublic;
  final String? location;
  final String? pronoun;
  final String? username;
  final String? profilePic;
  final Preferences? preferences;

  ProfileData({
    this.id,
    this.email,
    this.name,
    this.iAmHosting,
    this.notificationOpen,
    this.onboardingStep,
    this.profileCompleted,
    this.isOnboarding,
    this.isNotificationAllowed,
    this.fcmTokens,
    this.members,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.bio,
    this.isProfilePublic,
    this.location,
    this.pronoun,
    this.username,
    this.profilePic,
    this.preferences,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    var membersJson = json['members'] as List<dynamic>?;
    var fcmTokensJson = json['fcmTokens'] as List<dynamic>?;

    return ProfileData(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      iAmHosting: json['iAmHosting'] as bool?,
      notificationOpen: json['notificationOpen'] as bool?,
      onboardingStep: json['onboardingStep'] as int?,
      profileCompleted: json['profileCompleted'] as bool?,
      isOnboarding: json['isOnboarding'] as bool?,
      isNotificationAllowed: json['isNotificationAllowed'] as bool?,
      fcmTokens: fcmTokensJson != null
          ? fcmTokensJson.map((e) => e.toString()).toList()
          : [],
      members: membersJson != null
          ? membersJson
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      bio: json['bio'] as String?,
      isProfilePublic: json['isProfilePublic'] as bool?,
      location: json['location'] as String?,
      pronoun: json['pronoun'] as String?,
      username: json['username'] as String?,
      profilePic: json['profilePic'] as String?,
      preferences: json['preferences'] != null
          ? Preferences.fromJson(json['preferences'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Member {
  final String? name;
  final String? relation;
  final int? age;
  final Preferences? preferences;
  final int? onboardingStep;
  final bool? profileCompleted;
  final String? id;

  Member({
    this.name,
    this.relation,
    this.age,
    this.preferences,
    this.onboardingStep,
    this.profileCompleted,
    this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] as String?,
      relation: json['relation'] as String?,
      age: json['age'] as int?,
      preferences: json['preferences'] != null
          ? Preferences.fromJson(json['preferences'] as Map<String, dynamic>)
          : null,
      onboardingStep: json['onboardingStep'] as int?,
      profileCompleted: json['profileCompleted'] as bool?,
      id: json['_id'] as String?,
    );
  }
}

class Preferences {
  final CommonAllergens? commonAllergens;
  final List<FavMood>? favMood;
  final Plate? plate;
  final YumYuck? yumYuck;
  final ExtraAssistance? extraAssistance;
  final String? mobilityConcerns;
  final String? needAnythingElse;
  final bool? quietArea;
  final SeatingRequirement? seatingRequirement;
  final bool? hostingAnEvent;

  Preferences({
    this.commonAllergens,
    this.favMood,
    this.plate,
    this.yumYuck,
    this.extraAssistance,
    this.mobilityConcerns,
    this.needAnythingElse,
    this.quietArea,
    this.seatingRequirement,
    this.hostingAnEvent,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    var favMoodJson = json['favMood'] as List<dynamic>?;
    return Preferences(
      commonAllergens: json['commonAllergens'] != null
          ? CommonAllergens.fromJson(
          json['commonAllergens'] as Map<String, dynamic>)
          : null,
      favMood: favMoodJson != null
          ? favMoodJson.map((e) => FavMood.fromJson(e)).toList()
          : [],
      plate:
      json['plate'] != null ? Plate.fromJson(json['plate']) : null,
      yumYuck: json['yumYuck'] != null
          ? YumYuck.fromJson(json['yumYuck'])
          : null,
      extraAssistance: json['extraAssistance'] != null
          ? ExtraAssistance.fromJson(json['extraAssistance'])
          : null,
      mobilityConcerns: json['mobilityConcerns'] as String?,
      needAnythingElse: json['needAnythingElse'] as String?,
      quietArea: json['quietArea'] as bool?,
      seatingRequirement: json['seatingRequirement'] != null
          ? SeatingRequirement.fromJson(json['seatingRequirement'])
          : null,
      hostingAnEvent: json['hostingAnEvent'] as bool?,
    );
  }
}

class CommonAllergens {
  final String? peanut;
  final String? treeNuts;
  final String? sesame;
  final String? gluten;
  final String? eggs;
  final String? soy;
  final String? fish;
  final String? shellFish;
  final String? dairy;
  final String? others;

  CommonAllergens({
    this.peanut,
    this.treeNuts,
    this.sesame,
    this.gluten,
    this.eggs,
    this.soy,
    this.fish,
    this.shellFish,
    this.dairy,
    this.others,
  });

  factory CommonAllergens.fromJson(Map<String, dynamic> json) {
    return CommonAllergens(
      peanut: json['peanut'] as String?,
      treeNuts: json['treeNuts'] as String?,
      sesame: json['sesame'] as String?,
      gluten: json['gluten'] as String?,
      eggs: json['eggs'] as String?,
      soy: json['soy'] as String?,
      fish: json['fish'] as String?,
      shellFish: json['shellFish'] as String?,
      dairy: json['dairy'] as String?,
      others: json['others'] as String?,
    );
  }

  get entries => null;

  /// Converts the class into a Map to easily iterate over in UI
  Map<String, String?> toMap() {
    return {
      'peanut': peanut,
      'treeNuts': treeNuts,
      'sesame': sesame,
      'gluten': gluten,
      'eggs': eggs,
      'soy': soy,
      'fish': fish,
      'shellFish': shellFish,
      'dairy': dairy,
      'others': others,
    };
  }
}
class FavMood {
  final String? mood;

  FavMood({this.mood});

  factory FavMood.fromJson(Map<String, dynamic> json) {
    return FavMood(mood: json['mood'] as String?);
  }
}

class Plate {
  final bool? vegan;
  final bool? vegetarian;
  final bool? halal;
  final bool? kosher;
  final bool? keto;
  final String? other;

  Plate({this.vegan, this.vegetarian, this.halal, this.kosher, this.keto, this.other});

  factory Plate.fromJson(Map<String, dynamic> json) {
    return Plate(
      vegan: json['vegan'] as bool?,
      vegetarian: json['vegetarian'] as bool?,
      halal: json['halal'] as bool?,
      kosher: json['kosher'] as bool?,
      keto: json['keto'] as bool?,
      other: json['other'] as String?,
    );
  }
}

class YumYuck {
  final List<String>? yum;
  final List<String>? yuck;

  YumYuck({this.yum, this.yuck});

  factory YumYuck.fromJson(Map<String, dynamic> json) {
    var yumList = json['yum'] as List<dynamic>?;
    var yuckList = json['yuck'] as List<dynamic>?;
    return YumYuck(
      yum: yumList != null ? yumList.map((e) => e.toString()).toList() : [],
      yuck: yuckList != null ? yuckList.map((e) => e.toString()).toList() : [],
    );
  }
}

class ExtraAssistance {
  final List<String>? options;

  ExtraAssistance({this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List<dynamic>?;
    return ExtraAssistance(
      options: optionsJson != null ? optionsJson.map((e) => e.toString()).toList() : [],
    );
  }
}

class SeatingRequirement {
  final List<String>? options;

  SeatingRequirement({this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List<dynamic>?;
    return SeatingRequirement(
      options: optionsJson != null ? optionsJson.map((e) => e.toString()).toList() : [],
    );
  }
}