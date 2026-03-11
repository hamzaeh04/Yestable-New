class GetMyProfile {
  final bool success;
  final int statusCode;
  final String message;
  final UserData data;

  GetMyProfile({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetMyProfile.fromJson(Map<String, dynamic> json) => GetMyProfile(
    success: json['success'] as bool,
    statusCode: json['statusCode'] as int,
    message: json['message'] as String,
    data: UserData.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data.toJson(),
  };
}

class UserData {
  final String id;
  final String email;
  final String name;
  final bool iAmHosting;
  final bool notificationOpen;
  final int onboardingStep;
  final bool profileCompleted;
  final bool isOnboarding;
  final bool isNotificationAllowed;
  final List<String> fcmTokens;
  final List<Member> members;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String bio;
  final bool isProfilePublic;
  final String location;
  final String pronoun;
  final String username;
  final String profilePic;
  final Preferences preferences;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.iAmHosting,
    required this.notificationOpen,
    required this.onboardingStep,
    required this.profileCompleted,
    required this.isOnboarding,
    required this.isNotificationAllowed,
    required this.fcmTokens,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.bio,
    required this.isProfilePublic,
    required this.location,
    required this.pronoun,
    required this.username,
    required this.profilePic,
    required this.preferences,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['_id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    iAmHosting: json['iAmHosting'] as bool,
    notificationOpen: json['notificationOpen'] as bool,
    onboardingStep: json['onboardingStep'] as int,
    profileCompleted: json['profileCompleted'] as bool,
    isOnboarding: json['isOnboarding'] as bool,
    isNotificationAllowed: json['isNotificationAllowed'] as bool,
    fcmTokens: List<String>.from(json['fcmTokens'] ?? []),
    members: (json['members'] as List<dynamic>)
        .map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    v: json['__v'] as int,
    bio: json['bio'] as String,
    isProfilePublic: json['isProfilePublic'] as bool,
    location: json['location'] as String,
    pronoun: json['pronoun'] as String,
    username: json['username'] as String,
    profilePic: json['profilePic'] as String,
    preferences: Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'email': email,
    'name': name,
    'iAmHosting': iAmHosting,
    'notificationOpen': notificationOpen,
    'onboardingStep': onboardingStep,
    'profileCompleted': profileCompleted,
    'isOnboarding': isOnboarding,
    'isNotificationAllowed': isNotificationAllowed,
    'fcmTokens': fcmTokens,
    'members': members.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'bio': bio,
    'isProfilePublic': isProfilePublic,
    'location': location,
    'pronoun': pronoun,
    'username': username,
    'profilePic': profilePic,
    'preferences': preferences.toJson(),
  };
}

class Member {
  final String name;
  final String relation;
  final int age;
  final MemberPreferences preferences;
  final int onboardingStep;
  final bool profileCompleted;
  final String id;

  Member({
    required this.name,
    required this.relation,
    required this.age,
    required this.preferences,
    required this.onboardingStep,
    required this.profileCompleted,
    required this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    name: json['name'] as String,
    relation: json['relation'] as String,
    age: json['age'] as int,
    preferences: MemberPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
    onboardingStep: json['onboardingStep'] as int,
    profileCompleted: json['profileCompleted'] as bool,
    id: json['_id'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'relation': relation,
    'age': age,
    'preferences': preferences.toJson(),
    'onboardingStep': onboardingStep,
    'profileCompleted': profileCompleted,
    '_id': id,
  };
}

class MemberPreferences {
  final bool quietArea;
  final bool hostingAnEvent;
  final List<String> favMood;
  final Plate plate;

  MemberPreferences({
    required this.quietArea,
    required this.hostingAnEvent,
    required this.favMood,
    required this.plate,
  });

  factory MemberPreferences.fromJson(Map<String, dynamic> json) => MemberPreferences(
    quietArea: json['quietArea'] as bool,
    hostingAnEvent: json['hostingAnEvent'] as bool,
    favMood: List<String>.from(json['favMood'] ?? []),
    plate: Plate.fromJson(json['plate'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'quietArea': quietArea,
    'hostingAnEvent': hostingAnEvent,
    'favMood': favMood,
    'plate': plate.toJson(),
  };
}

class Preferences {
  final CommonAllergens commonAllergens;
  final List<FavMood> favMood;
  final Plate plate;
  final YumYuck yumYuck;
  final ExtraAssistance extraAssistance;
  final String mobilityConcerns;
  final String needAnythingElse;
  final bool quietArea;
  final SeatingRequirement seatingRequirement;
  final bool hostingAnEvent;

  Preferences({
    required this.commonAllergens,
    required this.favMood,
    required this.plate,
    required this.yumYuck,
    required this.extraAssistance,
    required this.mobilityConcerns,
    required this.needAnythingElse,
    required this.quietArea,
    required this.seatingRequirement,
    required this.hostingAnEvent,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    commonAllergens: CommonAllergens.fromJson(json['commonAllergens'] as Map<String, dynamic>),
    favMood: (json['favMood'] as List<dynamic>)
        .map((e) => FavMood.fromJson(e as Map<String, dynamic>))
        .toList(),
    plate: Plate.fromJson(json['plate'] as Map<String, dynamic>),
    yumYuck: YumYuck.fromJson(json['yumYuck'] as Map<String, dynamic>),
    extraAssistance: ExtraAssistance.fromJson(json['extraAssistance'] as Map<String, dynamic>),
    mobilityConcerns: json['mobilityConcerns'] as String,
    needAnythingElse: json['needAnythingElse'] as String,
    quietArea: json['quietArea'] as bool,
    seatingRequirement: SeatingRequirement.fromJson(json['seatingRequirement'] as Map<String, dynamic>),
    hostingAnEvent: json['hostingAnEvent'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'commonAllergens': commonAllergens.toJson(),
    'favMood': favMood.map((e) => e.toJson()).toList(),
    'plate': plate.toJson(),
    'yumYuck': yumYuck.toJson(),
    'extraAssistance': extraAssistance.toJson(),
    'mobilityConcerns': mobilityConcerns,
    'needAnythingElse': needAnythingElse,
    'quietArea': quietArea,
    'seatingRequirement': seatingRequirement.toJson(),
    'hostingAnEvent': hostingAnEvent,
  };
}

class CommonAllergens {
  final String peanut;
  final String treeNuts;
  final String sesame;
  final String gluten;
  final String eggs;
  final String soy;
  final String fish;
  final String shellFish;
  final String dairy;
  final String others;

  CommonAllergens({
    required this.peanut,
    required this.treeNuts,
    required this.sesame,
    required this.gluten,
    required this.eggs,
    required this.soy,
    required this.fish,
    required this.shellFish,
    required this.dairy,
    required this.others,
  });

  factory CommonAllergens.fromJson(Map<String, dynamic> json) => CommonAllergens(
    peanut: json['peanut'] as String,
    treeNuts: json['treeNuts'] as String,
    sesame: json['sesame'] as String,
    gluten: json['gluten'] as String,
    eggs: json['eggs'] as String,
    soy: json['soy'] as String,
    fish: json['fish'] as String,
    shellFish: json['shellFish'] as String,
    dairy: json['dairy'] as String,
    others: json['others'] as String,
  );

  Map<String, dynamic> toJson() => {
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

class FavMood {
  final String mood;

  FavMood({required this.mood});

  factory FavMood.fromJson(Map<String, dynamic> json) => FavMood(mood: json['mood'] as String);

  Map<String, dynamic> toJson() => {
    'mood': mood,
  };
}

class Plate {
  final bool vegan;
  final bool vegetarian;
  final bool halal;
  final bool kosher;
  final bool keto;
  final String? other;

  Plate({
    required this.vegan,
    required this.vegetarian,
    required this.halal,
    required this.kosher,
    required this.keto,
    this.other,
  });

  factory Plate.fromJson(Map<String, dynamic> json) => Plate(
    vegan: json['vegan'] as bool,
    vegetarian: json['vegetarian'] as bool,
    halal: json['halal'] as bool,
    kosher: json['kosher'] as bool,
    keto: json['keto'] as bool,
    other: json['other'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'vegan': vegan,
    'vegetarian': vegetarian,
    'halal': halal,
    'kosher': kosher,
    'keto': keto,
    'other': other,
  };
}

class YumYuck {
  final List<String> yum;
  final List<String> yuck;

  YumYuck({required this.yum, required this.yuck});

  factory YumYuck.fromJson(Map<String, dynamic> json) => YumYuck(
    yum: List<String>.from(json['yum'] ?? []),
    yuck: List<String>.from(json['yuck'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'yum': yum,
    'yuck': yuck,
  };
}

class ExtraAssistance {
  final List<String> options;

  ExtraAssistance({required this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) => ExtraAssistance(
    options: List<String>.from(json['options'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}

class SeatingRequirement {
  final List<String> options;

  SeatingRequirement({required this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) => SeatingRequirement(
    options: List<String>.from(json['options'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}