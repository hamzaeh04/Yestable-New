class GetMenuModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Data? data;

  GetMenuModel({this.success, this.statusCode, this.message, this.data});

  factory GetMenuModel.fromJson(Map<String, dynamic> json) => GetMenuModel(
    success: json['success'] as bool?,
    statusCode: json['statusCode'] as int?,
    message: json['message'] as String?,
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  final List<MenuItem>? data;
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  Data({this.data, this.total, this.page, this.limit, this.totalPages});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json['data'] != null
        ? List<MenuItem>.from(
        (json['data'] as List).map((x) => MenuItem.fromJson(x)))
        : null,
    total: json['total'] as int?,
    page: json['page'] as int?,
    limit: json['limit'] as int?,
    totalPages: json['totalPages'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'data': data?.map((x) => x.toJson()).toList(),
    'total': total,
    'page': page,
    'limit': limit,
    'totalPages': totalPages,
  };
}

class MenuItem {
  final String? id;
  final String? type;
  final List<String>? mealCategory;
  final String? menuImage;
  final String? title;
  final String? description;
  final User? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MenuItem({
    this.id,
    this.type,
    this.mealCategory,
    this.menuImage,
    this.title,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    id: json['_id'] as String?,
    type: json['type'] as String?,
    mealCategory: json['mealCategory'] != null
        ? List<String>.from(json['mealCategory'])
        : null,
    menuImage: json['menuImage'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'])
        : null,
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'type': type,
    'mealCategory': mealCategory,
    'menuImage': menuImage,
    'title': title,
    'description': description,
    'userId': userId?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}

class User {
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? bio;
  final bool? isProfilePublic;
  final String? location;
  final String? pronoun;
  final String? username;
  final String? profilePic;
  final Preferences? preferences;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] as String?,
    email: json['email'] as String?,
    name: json['name'] as String?,
    iAmHosting: json['iAmHosting'] as bool?,
    notificationOpen: json['notificationOpen'] as bool?,
    onboardingStep: json['onboardingStep'] as int?,
    profileCompleted: json['profileCompleted'] as bool?,
    isOnboarding: json['isOnboarding'] as bool?,
    isNotificationAllowed: json['isNotificationAllowed'] as bool?,
    fcmTokens: json['fcmTokens'] != null
        ? List<String>.from(json['fcmTokens'])
        : null,
    members: json['members'] != null
        ? List<Member>.from(
        (json['members'] as List).map((x) => Member.fromJson(x)))
        : null,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'])
        : null,
    v: json['__v'] as int?,
    bio: json['bio'] as String?,
    isProfilePublic: json['isProfilePublic'] as bool?,
    location: json['location'] as String?,
    pronoun: json['pronoun'] as String?,
    username: json['username'] as String?,
    profilePic: json['profilePic'] as String?,
    preferences: json['preferences'] != null
        ? Preferences.fromJson(json['preferences'])
        : null,
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
    'members': members?.map((x) => x.toJson()).toList(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'bio': bio,
    'isProfilePublic': isProfilePublic,
    'location': location,
    'pronoun': pronoun,
    'username': username,
    'profilePic': profilePic,
    'preferences': preferences?.toJson(),
  };
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

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    name: json['name'] as String?,
    relation: json['relation'] as String?,
    age: json['age'] as int?,
    preferences: json['preferences'] != null
        ? Preferences.fromJson(json['preferences'])
        : null,
    onboardingStep: json['onboardingStep'] as int?,
    profileCompleted: json['profileCompleted'] as bool?,
    id: json['_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'relation': relation,
    'age': age,
    'preferences': preferences?.toJson(),
    'onboardingStep': onboardingStep,
    'profileCompleted': profileCompleted,
    '_id': id,
  };
}

class Preferences {
  final Plate? plate;
  final bool? quietArea;
  final bool? hostingAnEvent;
  final List<Map<String, dynamic>>? favMood;
  final Map<String, String>? commonAllergens;
  final YumYuck? yumYuck;
  final ExtraAssistance? extraAssistance;
  final String? mobilityConcerns;
  final String? needAnythingElse;
  final SeatingRequirement? seatingRequirement;

  Preferences({
    this.plate,
    this.quietArea,
    this.hostingAnEvent,
    this.favMood,
    this.commonAllergens,
    this.yumYuck,
    this.extraAssistance,
    this.mobilityConcerns,
    this.needAnythingElse,
    this.seatingRequirement,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    plate: json['plate'] != null ? Plate.fromJson(json['plate']) : null,
    quietArea: json['quietArea'] as bool?,
    hostingAnEvent: json['hostingAnEvent'] as bool?,
    favMood: json['favMood'] != null
        ? List<Map<String, dynamic>>.from(json['favMood'])
        : null,
    commonAllergens: json['commonAllergens'] != null
        ? Map<String, String>.from(json['commonAllergens'])
        : null,
    yumYuck: json['yumYuck'] != null ? YumYuck.fromJson(json['yumYuck']) : null,
    extraAssistance: json['extraAssistance'] != null
        ? ExtraAssistance.fromJson(json['extraAssistance'])
        : null,
    mobilityConcerns: json['mobilityConcerns'] as String?,
    needAnythingElse: json['needAnythingElse'] as String?,
    seatingRequirement: json['seatingRequirement'] != null
        ? SeatingRequirement.fromJson(json['seatingRequirement'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'plate': plate?.toJson(),
    'quietArea': quietArea,
    'hostingAnEvent': hostingAnEvent,
    'favMood': favMood,
    'commonAllergens': commonAllergens,
    'yumYuck': yumYuck?.toJson(),
    'extraAssistance': extraAssistance?.toJson(),
    'mobilityConcerns': mobilityConcerns,
    'needAnythingElse': needAnythingElse,
    'seatingRequirement': seatingRequirement?.toJson(),
  };
}

class Plate {
  final bool? vegan;
  final bool? vegetarian;
  final bool? halal;
  final bool? kosher;
  final bool? keto;
  final String? other;

  Plate({this.vegan, this.vegetarian, this.halal, this.kosher, this.keto, this.other});

  factory Plate.fromJson(Map<String, dynamic> json) => Plate(
    vegan: json['vegan'] as bool?,
    vegetarian: json['vegetarian'] as bool?,
    halal: json['halal'] as bool?,
    kosher: json['kosher'] as bool?,
    keto: json['keto'] as bool?,
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
  final List<String>? yum;
  final List<String>? yuck;

  YumYuck({this.yum, this.yuck});

  factory YumYuck.fromJson(Map<String, dynamic> json) => YumYuck(
    yum: json['yum'] != null ? List<String>.from(json['yum']) : null,
    yuck: json['yuck'] != null ? List<String>.from(json['yuck']) : null,
  );

  Map<String, dynamic> toJson() => {
    'yum': yum,
    'yuck': yuck,
  };
}

class ExtraAssistance {
  final List<String>? options;

  ExtraAssistance({this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) => ExtraAssistance(
    options: json['options'] != null ? List<String>.from(json['options']) : null,
  );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}

class SeatingRequirement {
  final List<String>? options;

  SeatingRequirement({this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) => SeatingRequirement(
    options: json['options'] != null ? List<String>.from(json['options']) : null,
  );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}