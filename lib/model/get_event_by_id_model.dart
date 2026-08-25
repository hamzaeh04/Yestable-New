class EventDetailsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final EventDetailsData? data;

  EventDetailsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory EventDetailsResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailsResponse(
      success: json['success'] as bool? ?? false,
      statusCode: json['statusCode'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: json['data'] is Map<String, dynamic>
          ? EventDetailsData.fromJson(
        json['data'] as Map<String, dynamic>,
      )
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

class EventDetailsData {
  final EventLocation? location;
  final String id;
  final int estimatedGuests;
  final String eventName;
  final String address;
  final DateTime? eventTime;
  final String eventType;
  final String invitationMessage;
  final String parkingDetails;
  final String addNote;
  final bool reminderNotification;
  final List<dynamic> members;
  final List<dynamic> menus;
  final EventHost? host;
  final bool reminderSent;
  final bool isDeleted;
  final bool isCompleted;
  final bool isCancelled;
  final bool displayMenu;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;
  final EventComfort? eventComfort;
  final GuestAware? guestAware;
  final String image;
  final int numGuests;
  final int dietaryCompatibilityScore;

  EventDetailsData({
    this.location,
    required this.id,
    required this.estimatedGuests,
    required this.eventName,
    required this.address,
    this.eventTime,
    required this.eventType,
    required this.invitationMessage,
    required this.parkingDetails,
    required this.addNote,
    required this.reminderNotification,
    required this.members,
    required this.menus,
    this.host,
    required this.reminderSent,
    required this.isDeleted,
    required this.isCompleted,
    required this.isCancelled,
    required this.displayMenu,
    this.createdAt,
    this.updatedAt,
    required this.version,
    this.eventComfort,
    this.guestAware,
    required this.image,
    required this.numGuests,
    required this.dietaryCompatibilityScore,
  });

  factory EventDetailsData.fromJson(Map<String, dynamic> json) {
    return EventDetailsData(
      location: json['location'] is Map<String, dynamic>
          ? EventLocation.fromJson(
        json['location'] as Map<String, dynamic>,
      )
          : null,
      id: json['_id'] as String? ?? '',
      estimatedGuests: json['estimatedGuests'] as int? ?? 0,
      eventName: json['eventName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      eventTime: DateTime.tryParse(
        json['eventTime'] as String? ?? '',
      ),
      eventType: json['eventType'] as String? ?? '',
      invitationMessage:
      json['invitationMessage'] as String? ?? '',
      parkingDetails: json['parkingDetails'] as String? ?? '',
      addNote: json['addNote'] as String? ?? '',
      reminderNotification:
      json['reminderNotification'] as bool? ?? false,
      members: json['members'] is List
          ? List<dynamic>.from(json['members'] as List)
          : [],
      menus: json['menus'] is List
          ? List<dynamic>.from(json['menus'] as List)
          : [],
      host: json['host'] is Map<String, dynamic>
          ? EventHost.fromJson(
        json['host'] as Map<String, dynamic>,
      )
          : null,
      reminderSent: json['reminderSent'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isCancelled: json['isCancelled'] as bool? ?? false,
      displayMenu: json['displayMenu'] as bool? ?? false,
      createdAt: DateTime.tryParse(
        json['createdAt'] as String? ?? '',
      ),
      updatedAt: DateTime.tryParse(
        json['updatedAt'] as String? ?? '',
      ),
      version: json['__v'] as int? ?? 0,
      eventComfort: json['eventComfort'] is Map<String, dynamic>
          ? EventComfort.fromJson(
        json['eventComfort'] as Map<String, dynamic>,
      )
          : null,
      guestAware: json['guestAware'] is Map<String, dynamic>
          ? GuestAware.fromJson(
        json['guestAware'] as Map<String, dynamic>,
      )
          : null,
      image: json['image'] as String? ?? '',
      numGuests: json['numGuests'] as int? ?? 0,
      dietaryCompatibilityScore:
      json['dietaryCompatibilityScore'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      '_id': id,
      'estimatedGuests': estimatedGuests,
      'eventName': eventName,
      'address': address,
      'eventTime': eventTime?.toIso8601String(),
      'eventType': eventType,
      'invitationMessage': invitationMessage,
      'parkingDetails': parkingDetails,
      'addNote': addNote,
      'reminderNotification': reminderNotification,
      'members': members,
      'menus': menus,
      'host': host?.toJson(),
      'reminderSent': reminderSent,
      'isDeleted': isDeleted,
      'isCompleted': isCompleted,
      'isCancelled': isCancelled,
      'displayMenu': displayMenu,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
      'eventComfort': eventComfort?.toJson(),
      'guestAware': guestAware?.toJson(),
      'image': image,
      'numGuests': numGuests,
      'dietaryCompatibilityScore': dietaryCompatibilityScore,
    };
  }
}

class EventLocation {
  final String type;
  final List<double> coordinates;

  EventLocation({
    required this.type,
    required this.coordinates,
  });

  factory EventLocation.fromJson(Map<String, dynamic> json) {
    return EventLocation(
      type: json['type'] as String? ?? '',
      coordinates: json['coordinates'] is List
          ? (json['coordinates'] as List)
          .map(
            (item) =>
        (item as num?)?.toDouble() ?? 0.0,
      )
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class EventHost {
  final String id;
  final String email;
  final String name;
  final bool iAmHosting;
  final bool isProfilePublic;
  final bool notificationOpen;
  final int onboardingStep;
  final bool profileCompleted;
  final bool isOnboarding;
  final bool isNotificationAllowed;
  final List<dynamic> fcmTokens;
  final List<dynamic> members;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;
  final String bio;
  final String location;
  final String pronoun;
  final String username;
  final HostPreferences? preferences;
  final String profilePic;

  EventHost({
    required this.id,
    required this.email,
    required this.name,
    required this.iAmHosting,
    required this.isProfilePublic,
    required this.notificationOpen,
    required this.onboardingStep,
    required this.profileCompleted,
    required this.isOnboarding,
    required this.isNotificationAllowed,
    required this.fcmTokens,
    required this.members,
    this.createdAt,
    this.updatedAt,
    required this.version,
    required this.bio,
    required this.location,
    required this.pronoun,
    required this.username,
    this.preferences,
    required this.profilePic,
  });

  factory EventHost.fromJson(Map<String, dynamic> json) {
    return EventHost(
      id: json['_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iAmHosting: json['iAmHosting'] as bool? ?? false,
      isProfilePublic:
      json['isProfilePublic'] as bool? ?? false,
      notificationOpen:
      json['notificationOpen'] as bool? ?? false,
      onboardingStep: json['onboardingStep'] as int? ?? 0,
      profileCompleted:
      json['profileCompleted'] as bool? ?? false,
      isOnboarding: json['isOnboarding'] as bool? ?? false,
      isNotificationAllowed:
      json['isNotificationAllowed'] as bool? ?? false,
      fcmTokens: json['fcmTokens'] is List
          ? List<dynamic>.from(json['fcmTokens'] as List)
          : [],
      members: json['members'] is List
          ? List<dynamic>.from(json['members'] as List)
          : [],
      createdAt: DateTime.tryParse(
        json['createdAt'] as String? ?? '',
      ),
      updatedAt: DateTime.tryParse(
        json['updatedAt'] as String? ?? '',
      ),
      version: json['__v'] as int? ?? 0,
      bio: json['bio'] as String? ?? '',
      location: json['location'] as String? ?? '',
      pronoun: json['pronoun'] as String? ?? '',
      username: json['username'] as String? ?? '',
      preferences: json['preferences'] is Map<String, dynamic>
          ? HostPreferences.fromJson(
        json['preferences'] as Map<String, dynamic>,
      )
          : null,
      profilePic: json['profilePic'] as String? ?? '',
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
      'bio': bio,
      'location': location,
      'pronoun': pronoun,
      'username': username,
      'preferences': preferences?.toJson(),
      'profilePic': profilePic,
    };
  }
}

class HostPreferences {
  final CommonAllergens? commonAllergens;
  final FavoritePlate? plate;
  final YumYuck? yumYuck;
  final ExtraAssistance? extraAssistance;
  final String mobilityConcerns;
  final String needAnythingElse;
  final bool quietArea;
  final SeatingRequirement? seatingRequirement;
  final bool hostingAnEvent;
  final List<dynamic> favMood;

  HostPreferences({
    this.commonAllergens,
    this.plate,
    this.yumYuck,
    this.extraAssistance,
    required this.mobilityConcerns,
    required this.needAnythingElse,
    required this.quietArea,
    this.seatingRequirement,
    required this.hostingAnEvent,
    required this.favMood,
  });

  factory HostPreferences.fromJson(Map<String, dynamic> json) {
    return HostPreferences(
      commonAllergens:
      json['commonAllergens'] is Map<String, dynamic>
          ? CommonAllergens.fromJson(
        json['commonAllergens']
        as Map<String, dynamic>,
      )
          : null,
      plate: json['plate'] is Map<String, dynamic>
          ? FavoritePlate.fromJson(
        json['plate'] as Map<String, dynamic>,
      )
          : null,
      yumYuck: json['yumYuck'] is Map<String, dynamic>
          ? YumYuck.fromJson(
        json['yumYuck'] as Map<String, dynamic>,
      )
          : null,
      extraAssistance:
      json['extraAssistance'] is Map<String, dynamic>
          ? ExtraAssistance.fromJson(
        json['extraAssistance']
        as Map<String, dynamic>,
      )
          : null,
      mobilityConcerns:
      json['mobilityConcerns'] as String? ?? '',
      needAnythingElse:
      json['needAnythingElse'] as String? ?? '',
      quietArea: json['quietArea'] as bool? ?? false,
      seatingRequirement:
      json['seatingRequirement'] is Map<String, dynamic>
          ? SeatingRequirement.fromJson(
        json['seatingRequirement']
        as Map<String, dynamic>,
      )
          : null,
      hostingAnEvent:
      json['hostingAnEvent'] as bool? ?? false,
      favMood: json['favMood'] is List
          ? List<dynamic>.from(json['favMood'] as List)
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commonAllergens': commonAllergens?.toJson(),
      'favMood': favMood,
      'plate': plate?.toJson(),
      'yumYuck': yumYuck?.toJson(),
      'extraAssistance': extraAssistance?.toJson(),
      'mobilityConcerns': mobilityConcerns,
      'needAnythingElse': needAnythingElse,
      'quietArea': quietArea,
      'seatingRequirement': seatingRequirement?.toJson(),
      'hostingAnEvent': hostingAnEvent,
    };
  }
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
  });

  factory CommonAllergens.fromJson(
      Map<String, dynamic> json,
      ) {
    return CommonAllergens(
      peanut: json['peanut'] as String? ?? '',
      treeNuts: json['treeNuts'] as String? ?? '',
      sesame: json['sesame'] as String? ?? '',
      gluten: json['gluten'] as String? ?? '',
      eggs: json['eggs'] as String? ?? '',
      soy: json['soy'] as String? ?? '',
      fish: json['fish'] as String? ?? '',
      shellFish: json['shellFish'] as String? ?? '',
      dairy: json['dairy'] as String? ?? '',
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
    };
  }
}

class FavoritePlate {
  final bool vegan;
  final bool vegetarian;
  final bool halal;
  final bool kosher;
  final bool keto;
  final String other;

  FavoritePlate({
    required this.vegan,
    required this.vegetarian,
    required this.halal,
    required this.kosher,
    required this.keto,
    required this.other,
  });

  factory FavoritePlate.fromJson(
      Map<String, dynamic> json,
      ) {
    return FavoritePlate(
      vegan: json['vegan'] as bool? ?? false,
      vegetarian:
      json['vegetarian'] as bool? ?? false,
      halal: json['halal'] as bool? ?? false,
      kosher: json['kosher'] as bool? ?? false,
      keto: json['keto'] as bool? ?? false,
      other: json['other'] as String? ?? '',
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

class YumYuck {
  final List<String> yum;
  final List<String> yuck;

  YumYuck({
    required this.yum,
    required this.yuck,
  });

  factory YumYuck.fromJson(
      Map<String, dynamic> json,
      ) {
    return YumYuck(
      yum: json['yum'] is List
          ? (json['yum'] as List)
          .map((item) => item.toString())
          .toList()
          : [],
      yuck: json['yuck'] is List
          ? (json['yuck'] as List)
          .map((item) => item.toString())
          .toList()
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

class ExtraAssistance {
  final List<String> options;

  ExtraAssistance({
    required this.options,
  });

  factory ExtraAssistance.fromJson(
      Map<String, dynamic> json,
      ) {
    return ExtraAssistance(
      options: json['options'] is List
          ? (json['options'] as List)
          .map((item) => item.toString())
          .toList()
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
  final List<String> options;

  SeatingRequirement({
    required this.options,
  });

  factory SeatingRequirement.fromJson(
      Map<String, dynamic> json,
      ) {
    return SeatingRequirement(
      options: json['options'] is List
          ? (json['options'] as List)
          .map((item) => item.toString())
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class EventComfort {
  final bool quietSpace;
  final bool largerSeating;
  final bool wheelChairAccess;
  final bool aslInterpreter;
  final bool veganMenu;
  final bool restroom;

  EventComfort({
    required this.quietSpace,
    required this.largerSeating,
    required this.wheelChairAccess,
    required this.aslInterpreter,
    required this.veganMenu,
    required this.restroom,
  });

  factory EventComfort.fromJson(
      Map<String, dynamic> json,
      ) {
    return EventComfort(
      quietSpace:
      json['quietSpace'] as bool? ?? false,
      largerSeating:
      json['largerSeating'] as bool? ?? false,
      wheelChairAccess:
      json['wheelChairAccess'] as bool? ?? false,
      aslInterpreter:
      json['aslInterpreter'] as bool? ?? false,
      veganMenu:
      json['veganMenu'] as bool? ?? false,
      restroom: json['restroom'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quietSpace': quietSpace,
      'largerSeating': largerSeating,
      'wheelChairAccess': wheelChairAccess,
      'aslInterpreter': aslInterpreter,
      'veganMenu': veganMenu,
      'restroom': restroom,
    };
  }
}

class GuestAware {
  final bool petsPresent;
  final bool childrenPresent;
  final bool forAdultOnly;
  final bool smokePresent;
  final bool smokeFree;
  final bool alcohol;
  final bool alcoholFree;
  final bool stepsToClimb;
  final bool fireArms;
  final bool shellFish;
  final bool peanuts;
  final bool endsInFirmTime;
  final bool mayGuestsContact;
  final String? itemContaining;
  final String? others;
  final bool? guestContact;

  GuestAware({
    required this.petsPresent,
    required this.childrenPresent,
    required this.forAdultOnly,
    required this.smokePresent,
    required this.smokeFree,
    required this.alcohol,
    required this.alcoholFree,
    required this.stepsToClimb,
    required this.fireArms,
    required this.shellFish,
    required this.peanuts,
    required this.endsInFirmTime,
    required this.mayGuestsContact,
    this.itemContaining,
    this.others,
    this.guestContact,
  });

  factory GuestAware.fromJson(
      Map<String, dynamic> json,
      ) {
    return GuestAware(
      petsPresent:
      json['petsPresent'] as bool? ?? false,
      childrenPresent:
      json['childrenPresent'] as bool? ?? false,
      forAdultOnly:
      json['forAdultOnly'] as bool? ?? false,
      smokePresent:
      json['smokePresent'] as bool? ?? false,
      smokeFree:
      json['smokeFree'] as bool? ?? false,
      alcohol: json['alcohol'] as bool? ?? false,
      alcoholFree:
      json['alcoholFree'] as bool? ?? false,
      stepsToClimb:
      json['stepsToClimb'] as bool? ?? false,
      fireArms:
      json['fireArms'] as bool? ?? false,
      shellFish:
      json['shellFish'] as bool? ?? false,
      peanuts: json['peanuts'] as bool? ?? false,
      endsInFirmTime:
      json['endsInFirmTime'] as bool? ?? false,
      mayGuestsContact:
      json['mayGuestsContact'] as bool? ?? false,
      itemContaining: json['itemContaining'] is String ? json['itemContaining'] as String : null,
      others: json['others'] is String ? json['others'] as String : null,
      guestContact: json['guestContact'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petsPresent': petsPresent,
      'childrenPresent': childrenPresent,
      'forAdultOnly': forAdultOnly,
      'smokePresent': smokePresent,
      'smokeFree': smokeFree,
      'alcohol': alcohol,
      'alcoholFree': alcoholFree,
      'stepsToClimb': stepsToClimb,
      'fireArms': fireArms,
      'shellFish': shellFish,
      'peanuts': peanuts,
      'endsInFirmTime': endsInFirmTime,
      'mayGuestsContact': mayGuestsContact,
      if (itemContaining != null) 'itemContaining': itemContaining,
      if (others != null) 'others': others,
      if (guestContact != null) 'guestContact': guestContact,
    };
  }
}


// class EventDetailsResponse {
//   final bool? success;
//   final int? statusCode;
//   final String? message;
//   final EventData? data;
//
//   EventDetailsResponse({
//     this.success,
//     this.statusCode,
//     this.message,
//     this.data,
//   });
//
//   factory EventDetailsResponse.fromJson(Map<String, dynamic> json) {
//     return EventDetailsResponse(
//       success: json['success'],
//       statusCode: json['statusCode'],
//       message: json['message'],
//       data: json['data'] != null ? EventData.fromJson(json['data']) : null,
//     );
//   }
// }
//
// class EventData {
//   final LocationData? location;
//   final String? id;
//   final String? image;
//   final String? eventName;
//   final String? address;
//   final String? eventTime;
//   final String? eventType;
//   final String? invitationMessage;
//   final String? parkingDetails;
//   final String? addNote;
//   final bool? reminderNotification;
//   final List<dynamic>? members;
//   final List<Menu>? menus;
//   final Host? host;
//   final bool? reminderSent;
//   final bool? isDeleted;
//   final bool? isCompleted;
//   final bool? isCancelled;
//   final bool? displayMenu;
//   final String? createdAt;
//   final String? updatedAt;
//   final int? v;
//   final EventComfort? eventComfort;
//   final GuestAware? guestAware;
//
//   EventData({
//     this.location,
//     this.id,
//     this.image,
//     this.eventName,
//     this.address,
//     this.eventTime,
//     this.eventType,
//     this.invitationMessage,
//     this.parkingDetails,
//     this.addNote,
//     this.reminderNotification,
//     this.members,
//     this.menus,
//     this.host,
//     this.reminderSent,
//     this.isDeleted,
//     this.isCompleted,
//     this.isCancelled,
//     this.displayMenu,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.eventComfort,
//     this.guestAware,
//   });
//
//   factory EventData.fromJson(Map<String, dynamic> json) {
//     return EventData(
//       location: json['location'] != null
//           ? LocationData.fromJson(json['location'])
//           : null,
//       id: json['_id'],
//       image: json['image'],
//       eventName: json['eventName'],
//       address: json['address'],
//       eventTime: json['eventTime'],
//       eventType: json['eventType'],
//       invitationMessage: json['invitationMessage'],
//       parkingDetails: json['parkingDetails'],
//       addNote: json['addNote'],
//       reminderNotification: json['reminderNotification'],
//       members: json['members'],
//       menus: (json['menus'] as List?)
//           ?.map((e) => Menu.fromJson(e))
//           .toList(),
//       host: json['host'] != null ? Host.fromJson(json['host']) : null,
//       reminderSent: json['reminderSent'],
//       isDeleted: json['isDeleted'],
//       isCompleted: json['isCompleted'],
//       isCancelled: json['isCancelled'],
//       displayMenu: json['displayMenu'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       v: json['__v'],
//       eventComfort: json['eventComfort'] != null
//           ? EventComfort.fromJson(json['eventComfort'])
//           : null,
//       guestAware: json['guestAware'] != null
//           ? GuestAware.fromJson(json['guestAware'])
//           : null,
//     );
//   }
// }
//
// class LocationData {
//   final String? type;
//   final List<double>? coordinates;
//
//   LocationData({
//     this.type,
//     this.coordinates,
//   });
//
//   factory LocationData.fromJson(Map<String, dynamic> json) {
//     return LocationData(
//       type: json['type'],
//       coordinates: (json['coordinates'] as List?)
//           ?.map((e) => (e as num).toDouble())
//           .toList(),
//     );
//   }
// }
//
// class Menu {
//   final String? id;
//   final String? type;
//   final List<String>? mealCategory;
//   final String? menuImage;
//   final String? title;
//   final String? description;
//   final String? userId;
//   final String? createdAt;
//   final String? updatedAt;
//   final int? v;
//
//   Menu({
//     this.id,
//     this.type,
//     this.mealCategory,
//     this.menuImage,
//     this.title,
//     this.description,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Menu.fromJson(Map<String, dynamic> json) {
//     return Menu(
//       id: json['_id'],
//       type: json['type'],
//       mealCategory: (json['mealCategory'] as List?)
//           ?.map((e) => e.toString())
//           .toList(),
//       menuImage: json['menuImage'],
//       title: json['title'],
//       description: json['description'],
//       userId: json['userId'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       v: json['__v'],
//     );
//   }
// }
//
// class Host {
//   final String? id;
//   final String? email;
//   final String? name;
//   final bool? iAmHosting;
//   final bool? isProfilePublic;
//   final bool? notificationOpen;
//   final int? onboardingStep;
//   final bool? profileCompleted;
//   final bool? isOnboarding;
//   final bool? isNotificationAllowed;
//   final List<dynamic>? fcmTokens;
//   final List<dynamic>? members;
//   final String? createdAt;
//   final String? updatedAt;
//   final int? v;
//   final String? bio;
//   final String? location;
//   final String? profilePic;
//   final String? pronoun;
//   final String? username;
//   final Preferences? preferences;
//
//   Host({
//     this.id,
//     this.email,
//     this.name,
//     this.iAmHosting,
//     this.isProfilePublic,
//     this.notificationOpen,
//     this.onboardingStep,
//     this.profileCompleted,
//     this.isOnboarding,
//     this.isNotificationAllowed,
//     this.fcmTokens,
//     this.members,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.bio,
//     this.location,
//     this.profilePic,
//     this.pronoun,
//     this.username,
//     this.preferences,
//   });
//
//   factory Host.fromJson(Map<String, dynamic> json) {
//     return Host(
//       id: json['_id'],
//       email: json['email'],
//       name: json['name'],
//       iAmHosting: json['iAmHosting'],
//       isProfilePublic: json['isProfilePublic'],
//       notificationOpen: json['notificationOpen'],
//       onboardingStep: json['onboardingStep'],
//       profileCompleted: json['profileCompleted'],
//       isOnboarding: json['isOnboarding'],
//       isNotificationAllowed: json['isNotificationAllowed'],
//       fcmTokens: json['fcmTokens'],
//       members: json['members'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       v: json['__v'],
//       bio: json['bio'],
//       location: json['location'],
//       profilePic: json['profilePic'],
//       pronoun: json['pronoun'],
//       username: json['username'],
//       preferences: json['preferences'] != null
//           ? Preferences.fromJson(json['preferences'])
//           : null,
//     );
//   }
// }
//
// class Preferences {
//   final CommonAllergens? commonAllergens;
//   final List<FavMood>? favMood;
//   final Plate? plate;
//   final YumYuck? yumYuck;
//   final ExtraAssistance? extraAssistance;
//   final String? mobilityConcerns;
//   final String? needAnythingElse;
//   final bool? quietArea;
//   final SeatingRequirement? seatingRequirement;
//   final bool? hostingAnEvent;
//
//   Preferences({
//     this.commonAllergens,
//     this.favMood,
//     this.plate,
//     this.yumYuck,
//     this.extraAssistance,
//     this.mobilityConcerns,
//     this.needAnythingElse,
//     this.quietArea,
//     this.seatingRequirement,
//     this.hostingAnEvent,
//   });
//
//   factory Preferences.fromJson(Map<String, dynamic> json) {
//     return Preferences(
//       commonAllergens: json['commonAllergens'] != null
//           ? CommonAllergens.fromJson(json['commonAllergens'])
//           : null,
//       favMood: (json['favMood'] as List?)
//           ?.map((e) => FavMood.fromJson(e))
//           .toList(),
//       plate: json['plate'] != null ? Plate.fromJson(json['plate']) : null,
//       yumYuck:
//       json['yumYuck'] != null ? YumYuck.fromJson(json['yumYuck']) : null,
//       extraAssistance: json['extraAssistance'] != null
//           ? ExtraAssistance.fromJson(json['extraAssistance'])
//           : null,
//       mobilityConcerns: json['mobilityConcerns'],
//       needAnythingElse: json['needAnythingElse'],
//       quietArea: json['quietArea'],
//       seatingRequirement: json['seatingRequirement'] != null
//           ? SeatingRequirement.fromJson(json['seatingRequirement'])
//           : null,
//       hostingAnEvent: json['hostingAnEvent'],
//     );
//   }
// }
//
// class CommonAllergens {
//   final String? peanut;
//   final String? treeNuts;
//   final String? sesame;
//   final String? gluten;
//   final String? eggs;
//   final String? soy;
//   final String? fish;
//   final String? shellFish;
//   final String? dairy;
//
//   CommonAllergens({
//     this.peanut,
//     this.treeNuts,
//     this.sesame,
//     this.gluten,
//     this.eggs,
//     this.soy,
//     this.fish,
//     this.shellFish,
//     this.dairy,
//   });
//
//   factory CommonAllergens.fromJson(Map<String, dynamic> json) {
//     return CommonAllergens(
//       peanut: json['peanut'],
//       treeNuts: json['treeNuts'],
//       sesame: json['sesame'],
//       gluten: json['gluten'],
//       eggs: json['eggs'],
//       soy: json['soy'],
//       fish: json['fish'],
//       shellFish: json['shellFish'],
//       dairy: json['dairy'],
//     );
//   }
// }
//
// class FavMood {
//   final String? mood;
//
//   FavMood({this.mood});
//
//   factory FavMood.fromJson(Map<String, dynamic> json) {
//     return FavMood(mood: json['mood']);
//   }
// }
//
// class Plate {
//   final bool? vegan;
//   final bool? vegetarian;
//   final bool? halal;
//   final bool? kosher;
//   final bool? keto;
//   final String? other;
//
//   Plate({
//     this.vegan,
//     this.vegetarian,
//     this.halal,
//     this.kosher,
//     this.keto,
//     this.other,
//   });
//
//   factory Plate.fromJson(Map<String, dynamic> json) {
//     return Plate(
//       vegan: json['vegan'],
//       vegetarian: json['vegetarian'],
//       halal: json['halal'],
//       kosher: json['kosher'],
//       keto: json['keto'],
//       other: json['other'],
//     );
//   }
// }
//
// class YumYuck {
//   final List<String>? yum;
//   final List<String>? yuck;
//
//   YumYuck({
//     this.yum,
//     this.yuck,
//   });
//
//   factory YumYuck.fromJson(Map<String, dynamic> json) {
//     return YumYuck(
//       yum: (json['yum'] as List?)?.map((e) => e.toString()).toList(),
//       yuck: (json['yuck'] as List?)?.map((e) => e.toString()).toList(),
//     );
//   }
// }
//
// class ExtraAssistance {
//   final List<String>? options;
//
//   ExtraAssistance({this.options});
//
//   factory ExtraAssistance.fromJson(Map<String, dynamic> json) {
//     return ExtraAssistance(
//       options:
//       (json['options'] as List?)?.map((e) => e.toString()).toList(),
//     );
//   }
// }
//
// class SeatingRequirement {
//   final List<String>? options;
//
//   SeatingRequirement({this.options});
//
//   factory SeatingRequirement.fromJson(Map<String, dynamic> json) {
//     return SeatingRequirement(
//       options:
//       (json['options'] as List?)?.map((e) => e.toString()).toList(),
//     );
//   }
// }
//
// class EventComfort {
//   final bool? quietSpace;
//   final bool? largerSeating;
//   final bool? wheelChairAccess;
//   final bool? aslInterpreter;
//   final bool? veganMenu;
//   final bool? restroom;
//
//   EventComfort({
//     this.quietSpace,
//     this.largerSeating,
//     this.wheelChairAccess,
//     this.aslInterpreter,
//     this.veganMenu,
//     this.restroom,
//   });
//
//   factory EventComfort.fromJson(Map<String, dynamic> json) {
//     return EventComfort(
//       quietSpace: json['quietSpace'],
//       largerSeating: json['largerSeating'],
//       wheelChairAccess: json['wheelChairAccess'],
//       aslInterpreter: json['aslInterpreter'],
//       veganMenu: json['veganMenu'],
//       restroom: json['restroom'],
//     );
//   }
// }
//
// class GuestAware {
//   final bool? petsPresent;
//   final bool? childrenPresent;
//   final bool? forAdultOnly;
//   final bool? smokePresent;
//   final bool? smokeFree;
//   final bool? alcohol;
//   final bool? alcoholFree;
//   final bool? stepsToClimb;
//   final bool? fireArms;
//   final bool? shellFish;
//   final bool? peanuts;
//   final bool? endsInFirmTime;
//
//   GuestAware({
//     this.petsPresent,
//     this.childrenPresent,
//     this.forAdultOnly,
//     this.smokePresent,
//     this.smokeFree,
//     this.alcohol,
//     this.alcoholFree,
//     this.stepsToClimb,
//     this.fireArms,
//     this.shellFish,
//     this.peanuts,
//     this.endsInFirmTime,
//   });
//
//   factory GuestAware.fromJson(Map<String, dynamic> json) {
//     return GuestAware(
//       petsPresent: json['petsPresent'],
//       childrenPresent: json['childrenPresent'],
//       forAdultOnly: json['forAdultOnly'],
//       smokePresent: json['smokePresent'],
//       smokeFree: json['smokeFree'],
//       alcohol: json['alcohol'],
//       alcoholFree: json['alcoholFree'],
//       stepsToClimb: json['stepsToClimb'],
//       fireArms: json['fireArms'],
//       shellFish: json['shellFish'],
//       peanuts: json['peanuts'],
//       endsInFirmTime: json['endsInFirmTime'],
//     );
//   }
// }
