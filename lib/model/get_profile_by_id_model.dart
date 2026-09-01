class GetProfileByIdModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final ProfileData? data;

  GetProfileByIdModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetProfileByIdModel.fromJson(Map<String, dynamic> json) {
    return GetProfileByIdModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? ProfileData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ProfileData {
  final String? id;
  final String? email;
  final String? name;
  final bool? iAmHosting;
  final bool? isProfilePublic;
  final bool? notificationOpen;
  final int? onboardingStep;
  final bool? profileCompleted;
  final bool? isOnboarding;
  final bool? isNotificationAllowed;
  final List<dynamic>? fcmTokens;
  final List<dynamic>? members;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? bio;
  final String? location;
  final String? profilePic;
  final String? pronoun;
  final String? username;
  final Preferences? preferences;

  ProfileData({
    this.id,
    this.email,
    this.name,
    this.iAmHosting,
    this.isProfilePublic,
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
    this.location,
    this.profilePic,
    this.pronoun,
    this.username,
    this.preferences,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      iAmHosting: json['iAmHosting'],
      isProfilePublic: json['isProfilePublic'],
      notificationOpen: json['notificationOpen'],
      onboardingStep: json['onboardingStep'],
      profileCompleted: json['profileCompleted'],
      isOnboarding: json['isOnboarding'],
      isNotificationAllowed: json['isNotificationAllowed'],
      fcmTokens: json['fcmTokens'] != null
          ? List<dynamic>.from(json['fcmTokens'])
          : [],
      members: json['members'] != null
          ? List<dynamic>.from(json['members'])
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      bio: json['bio'],
      location: json['location'],
      profilePic: json['profilePic'],
      pronoun: json['pronoun'],
      username: json['username'],
      preferences: json['preferences'] != null
          ? Preferences.fromJson(json['preferences'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'iAmHosting': iAmHosting,
      'isProfilePublic': isProfilePublic,
      'notificationOpen': notificationOpen,
      'onboardingStep': onboardingStep,
      'profileCompleted': profileCompleted,
      'isOnboarding': isOnboarding,
      'isNotificationAllowed': isNotificationAllowed,
      'fcmTokens': fcmTokens,
      'members': members,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'bio': bio,
      'location': location,
      'profilePic': profilePic,
      'pronoun': pronoun,
      'username': username,
      'preferences': preferences?.toJson(),
    };
  }
}

class Preferences {
  final CommonAllergens? commonAllergens;
  final List<FavMood>? favMood;
  final Plate? plate;
  final ExtraAssistance? extraAssistance;
  final bool? quietArea;
  final SeatingRequirement? seatingRequirement;
  final YumYuck? yumYuck;
  final String? mobilityConcerns;
  final String? needAnythingElse;
  final bool? hostingAnEvent;

  Preferences({
    this.commonAllergens,
    this.favMood,
    this.plate,
    this.extraAssistance,
    this.quietArea,
    this.seatingRequirement,
    this.yumYuck,
    this.mobilityConcerns,
    this.needAnythingElse,
    this.hostingAnEvent,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      commonAllergens: json['commonAllergens'] != null
          ? CommonAllergens.fromJson(json['commonAllergens'])
          : null,
      favMood: json['favMood'] != null
          ? (json['favMood'] as List)
          .map((e) => FavMood.fromJson(e))
          .toList()
          : [],
      plate: json['plate'] != null
          ? Plate.fromJson(json['plate'])
          : null,
      extraAssistance: json['extraAssistance'] != null
          ? ExtraAssistance.fromJson(json['extraAssistance'])
          : null,
      quietArea: json['quietArea'],
      seatingRequirement: json['seatingRequirement'] != null
          ? SeatingRequirement.fromJson(json['seatingRequirement'])
          : null,
      yumYuck: json['yumYuck'] != null
          ? YumYuck.fromJson(json['yumYuck'])
          : null,
      mobilityConcerns: json['mobilityConcerns'],
      needAnythingElse: json['needAnythingElse'],
      hostingAnEvent: json['hostingAnEvent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commonAllergens': commonAllergens?.toJson(),
      'favMood': favMood?.map((e) => e.toJson()).toList(),
      'plate': plate?.toJson(),
      'extraAssistance': extraAssistance?.toJson(),
      'quietArea': quietArea,
      'seatingRequirement': seatingRequirement?.toJson(),
      'yumYuck': yumYuck?.toJson(),
      'mobilityConcerns': mobilityConcerns,
      'needAnythingElse': needAnythingElse,
      'hostingAnEvent': hostingAnEvent,
    };
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
      peanut: json['peanut'],
      treeNuts: json['treeNuts'],
      sesame: json['sesame'],
      gluten: json['gluten'],
      eggs: json['eggs'],
      soy: json['soy'],
      fish: json['fish'],
      shellFish: json['shellFish'],
      dairy: json['dairy'],
      others: json['others'],
    );
  }

  Map<String, dynamic> toJson() {
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
    return FavMood(
      mood: json['mood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
    };
  }
}

class Plate {
  final bool? vegan;
  final bool? vegetarian;
  final bool? halal;
  final bool? kosher;
  final bool? keto;
  final String? other;

  Plate({
    this.vegan,
    this.vegetarian,
    this.halal,
    this.kosher,
    this.keto,
    this.other,
  });

  factory Plate.fromJson(Map<String, dynamic> json) {
    return Plate(
      vegan: json['vegan'],
      vegetarian: json['vegetarian'],
      halal: json['halal'],
      kosher: json['kosher'],
      keto: json['keto'],
      other: json['other'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vegan': vegan,
      'vegetarian': vegetarian,
      'halal': halal,
      'kosher': kosher,
      'keto': keto,
      'other': other,
    };
  }
}

class ExtraAssistance {
  final List<String>? options;

  ExtraAssistance({this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) {
    return ExtraAssistance(
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class SeatingRequirement {
  final List<String>? options;

  SeatingRequirement({this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) {
    return SeatingRequirement(
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class YumYuck {
  final List<String>? yum;
  final List<String>? yuck;

  YumYuck({
    this.yum,
    this.yuck,
  });

  factory YumYuck.fromJson(Map<String, dynamic> json) {
    return YumYuck(
      yum: json['yum'] != null
          ? List<String>.from(json['yum'])
          : [],
      yuck: json['yuck'] != null
          ? List<String>.from(json['yuck'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'yum': yum,
      'yuck': yuck,
    };
  }
}