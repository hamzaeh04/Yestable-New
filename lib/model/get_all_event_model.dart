class GetAllEventsModel {
  final bool success;
  final int statusCode;
  final String message;
  final Data? data;

  GetAllEventsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory GetAllEventsModel.fromJson(Map<String, dynamic> json) {
    return GetAllEventsModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  final List<Event>? data;
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;
  final bool? fromCache;
  final CalendarData? calendar;
  final List<dynamic>? invitations;
  final List<Event>? upcomingEvents;

  Data({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.fromCache,
    this.calendar,
    this.invitations,
    this.upcomingEvents,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['upcomingEvents'] != null
          ? List<Event>.from(json['upcomingEvents'].map((x) => Event.fromJson(x)))
          : (json['data'] != null
              ? List<Event>.from(json['data'].map((x) => Event.fromJson(x)))
              : null),
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      fromCache: json['fromCache'],
      calendar: json['calendar'] != null
          ? CalendarData.fromJson(json['calendar'])
          : null,
      invitations: json['invitations'] != null
          ? List<dynamic>.from(json['invitations'])
          : [],
      upcomingEvents: json['upcomingEvents'] != null
          ? List<Event>.from(json['upcomingEvents'].map((x) => Event.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((x) => x.toJson()).toList(),
    'total': total,
    'page': page,
    'limit': limit,
    'totalPages': totalPages,
    'fromCache': fromCache,
    'calendar': calendar?.toJson(),
    'invitations': invitations,
    'upcomingEvents': upcomingEvents?.map((x) => x.toJson()).toList(),
  };
}

class CalendarData {
  final String? month;
  final Map<String, CalendarDateInfo>? dates;
  final int? totalEventsThisMonth;

  CalendarData({this.month, this.dates, this.totalEventsThisMonth});

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    final Map<String, CalendarDateInfo> parsedDates = {};
    if (json['dates'] != null && json['dates'] is Map) {
      json['dates'].forEach((key, value) {
        if (value is Map) {
          parsedDates[key.toString()] = CalendarDateInfo.fromJson(Map<String, dynamic>.from(value));
        }
      });
    }
    return CalendarData(
      month: json['month'],
      dates: parsedDates,
      totalEventsThisMonth: json['totalEventsThisMonth'],
    );
  }

  Map<String, dynamic> toJson() => {
    'month': month,
    'dates': dates?.map((key, value) => MapEntry(key, value.toJson())),
    'totalEventsThisMonth': totalEventsThisMonth,
  };
}

class CalendarDateInfo {
  final List<String>? eventIds;
  final int? eventCount;

  CalendarDateInfo({this.eventIds, this.eventCount});

  factory CalendarDateInfo.fromJson(Map<String, dynamic> json) {
    return CalendarDateInfo(
      eventIds: json['eventIds'] != null ? List<String>.from(json['eventIds']) : [],
      eventCount: json['eventCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'eventIds': eventIds,
    'eventCount': eventCount,
  };
}

class Event {
  final String? id;
  final Location? location;
  final String? image;
  final String? address;
  final String? eventName;
  final DateTime? eventTime;
  final String? eventType;
  final String? invitationMessage;
  final String? parkingDetails;
  final String? addNote;
  final bool? reminderNotification;
  final bool? reminderSent;
  final bool? isDeleted;
  final bool? isCompleted;
  final bool? isCancelled;
  final bool? displayMenu;
  final Host? host;
  final List<dynamic>? members;
  final List<dynamic>? menus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  // ✅ NEW FIELDS ADDED
  final EventComfort2? eventComfort;
  final GuestAware2? guestAware;
  final int? dietaryCompatibilityScore;
  final int? numGuests;
  final int? estimatedGuests;

  Event({
    this.id,
    this.location,
    this.image,
    this.address,
    this.eventName,
    this.eventTime,
    this.eventType,
    this.invitationMessage,
    this.parkingDetails,
    this.addNote,
    this.reminderNotification,
    this.reminderSent,
    this.isDeleted,
    this.isCompleted,
    this.isCancelled,
    this.displayMenu,
    this.host,
    this.members,
    this.menus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.eventComfort,
    this.guestAware,
    this.dietaryCompatibilityScore,
    this.numGuests,
    this.estimatedGuests,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      image: json['image'],
      address: json['address'],
      eventName: json['eventName'],
      eventTime: json['eventTime'] != null
          ? DateTime.parse(json['eventTime'])
          : null,
      eventType: json['eventType'],
      invitationMessage: json['invitationMessage'],
      parkingDetails: json['parkingDetails'],
      addNote: json['addNote'],
      reminderNotification: json['reminderNotification'],
      reminderSent: json['reminderSent'],
      isDeleted: json['isDeleted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      displayMenu: json['displayMenu'],
      host: json['host'] != null ? Host.fromJson(json['host']) : null,
      members: json['members'] != null
          ? List<dynamic>.from(json['members'])
          : [],
      menus:
      json['menus'] != null ? List<dynamic>.from(json['menus']) : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      v: json['__v'],

      // ✅ NEW FIELDS PARSED
      eventComfort: json['eventComfort'] != null
          ? EventComfort2.fromJson(json['eventComfort'])
          : null,
      guestAware: json['guestAware'] != null
          ? GuestAware2.fromJson(json['guestAware'])
          : null,
      dietaryCompatibilityScore: json['dietaryCompatibilityScore'],
      numGuests: json['numGuests'],
      estimatedGuests: json['estimatedGuests'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'location': location?.toJson(),
    'image': image,
    'address': address,
    'eventName': eventName,
    'eventTime': eventTime?.toIso8601String(),
    'eventType': eventType,
    'invitationMessage': invitationMessage,
    'parkingDetails': parkingDetails,
    'addNote': addNote,
    'reminderNotification': reminderNotification,
    'reminderSent': reminderSent,
    'isDeleted': isDeleted,
    'isCompleted': isCompleted,
    'isCancelled': isCancelled,
    'displayMenu': displayMenu,
    'host': host?.toJson(),
    'members': members,
    'menus': menus,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,

    // ✅ NEW TO JSON
    'eventComfort': eventComfort?.toJson(),
    'guestAware': guestAware?.toJson(),
    'dietaryCompatibilityScore': dietaryCompatibilityScore,
    'numGuests': numGuests,
    'estimatedGuests': estimatedGuests,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };
}

class Host {
  final String? id;
  final String? email;
  final String? name;
  final bool? iAmHosting;
  final bool? notificationOpen;
  final int? onboardingStep;
  final bool? profileCompleted;
  final bool? isOnboarding;
  final bool? isNotificationAllowed;
  final List<dynamic>? fcmTokens;
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

  Host({
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

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      iAmHosting: json['iAmHosting'],
      notificationOpen: json['notificationOpen'],
      onboardingStep: json['onboardingStep'],
      profileCompleted: json['profileCompleted'],
      isOnboarding: json['isOnboarding'],
      isNotificationAllowed: json['isNotificationAllowed'],
      fcmTokens: json['fcmTokens'] != null
          ? List<dynamic>.from(json['fcmTokens'])
          : [],
      members: json['members'] != null
          ? List<Member>.from(
          json['members'].map((x) => Member.fromJson(x)))
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      bio: json['bio'],
      isProfilePublic: json['isProfilePublic'],
      location: json['location'],
      pronoun: json['pronoun'],
      username: json['username'],
      profilePic: json['profilePic'],
      preferences: json['preferences'] != null
          ? Preferences.fromJson(json['preferences'])
          : null,
    );
  }

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
    'createdAt': createdAt,
    'updatedAt': updatedAt,
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
  final String? id;
  final String? name;
  final String? relation;
  final int? age;
  final Preferences? preferences;
  final int? onboardingStep;
  final bool? profileCompleted;

  Member({
    this.id,
    this.name,
    this.relation,
    this.age,
    this.preferences,
    this.onboardingStep,
    this.profileCompleted,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      name: json['name'],
      relation: json['relation'],
      age: json['age'],
      preferences: json['preferences'] != null
          ? Preferences.fromJson(json['preferences'])
          : null,
      onboardingStep: json['onboardingStep'],
      profileCompleted: json['profileCompleted'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'relation': relation,
    'age': age,
    'preferences': preferences?.toJson(),
    'onboardingStep': onboardingStep,
    'profileCompleted': profileCompleted,
  };
}

class Preferences {
  final Plate? plate;
  final bool? quietArea;
  final bool? hostingAnEvent;
  final List<FavMood>? favMood;
  final CommonAllergens? commonAllergens;
  final YumYuck? yumYuck;
  final ExtraAssistance? extraAssistance;
  final SeatingRequirement? seatingRequirement;
  final String? mobilityConcerns;
  final String? needAnythingElse;

  Preferences({
    this.plate,
    this.quietArea,
    this.hostingAnEvent,
    this.favMood,
    this.commonAllergens,
    this.yumYuck,
    this.extraAssistance,
    this.seatingRequirement,
    this.mobilityConcerns,
    this.needAnythingElse,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      plate: json['plate'] != null ? Plate.fromJson(json['plate']) : null,
      quietArea: json['quietArea'],
      hostingAnEvent: json['hostingAnEvent'],
      favMood: json['favMood'] != null
          ? List<FavMood>.from(
          json['favMood'].map((x) => FavMood.fromJson(x)))
          : [],
      commonAllergens: json['commonAllergens'] != null
          ? CommonAllergens.fromJson(json['commonAllergens'])
          : null,
      yumYuck:
      json['yumYuck'] != null ? YumYuck.fromJson(json['yumYuck']) : null,
      extraAssistance: json['extraAssistance'] != null
          ? ExtraAssistance.fromJson(json['extraAssistance'])
          : null,
      seatingRequirement: json['seatingRequirement'] != null
          ? SeatingRequirement.fromJson(json['seatingRequirement'])
          : null,
      mobilityConcerns: json['mobilityConcerns'],
      needAnythingElse: json['needAnythingElse'],
    );
  }

  Map<String, dynamic> toJson() => {
    'plate': plate?.toJson(),
    'quietArea': quietArea,
    'hostingAnEvent': hostingAnEvent,
    'favMood': favMood?.map((x) => x.toJson()).toList(),
    'commonAllergens': commonAllergens?.toJson(),
    'yumYuck': yumYuck?.toJson(),
    'extraAssistance': extraAssistance?.toJson(),
    'seatingRequirement': seatingRequirement?.toJson(),
    'mobilityConcerns': mobilityConcerns,
    'needAnythingElse': needAnythingElse,
  };
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

  Map<String, dynamic> toJson() => {
    'vegan': vegan,
    'vegetarian': vegetarian,
    'halal': halal,
    'kosher': kosher,
    'keto': keto,
    'other': other,
  };
}

class FavMood {
  final String? mood;

  FavMood({this.mood});

  factory FavMood.fromJson(Map<String, dynamic> json) =>
      FavMood(mood: json['mood']);

  Map<String, dynamic> toJson() => {'mood': mood};
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
  });

  factory CommonAllergens.fromJson(Map<String, dynamic> json) =>
      CommonAllergens(
        peanut: json['peanut'],
        treeNuts: json['treeNuts'],
        sesame: json['sesame'],
        gluten: json['gluten'],
        eggs: json['eggs'],
        soy: json['soy'],
        fish: json['fish'],
        shellFish: json['shellFish'],
        dairy: json['dairy'],
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
  };
}

class YumYuck {
  final List<String>? yum;
  final List<String>? yuck;

  YumYuck({this.yum, this.yuck});

  factory YumYuck.fromJson(Map<String, dynamic> json) => YumYuck(
    yum: json['yum'] != null ? List<String>.from(json['yum']) : [],
    yuck: json['yuck'] != null ? List<String>.from(json['yuck']) : [],
  );

  Map<String, dynamic> toJson() => {
    'yum': yum,
    'yuck': yuck,
  };
}

class ExtraAssistance {
  final List<String>? options;

  ExtraAssistance({this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) =>
      ExtraAssistance(
        options:
        json['options'] != null ? List<String>.from(json['options']) : [],
      );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}

class SeatingRequirement {
  final List<String>? options;

  SeatingRequirement({this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) =>
      SeatingRequirement(
        options:
        json['options'] != null ? List<String>.from(json['options']) : [],
      );

  Map<String, dynamic> toJson() => {
    'options': options,
  };
}

/// ================= NEW MODELS =================

class EventComfort2 {
  final bool? quietSpace;
  final bool? largerSeating;
  final bool? wheelChairAccess;
  final bool? aslInterpreter;
  final bool? veganMenu;
  final bool? restroom;
  final String? other;

  EventComfort2({
    this.quietSpace,
    this.largerSeating,
    this.wheelChairAccess,
    this.aslInterpreter,
    this.veganMenu,
    this.restroom,
    this.other,
  });

  factory EventComfort2.fromJson(Map<String, dynamic> json) {
    return EventComfort2(
      quietSpace: json['quietSpace'],
      largerSeating: json['largerSeating'],
      wheelChairAccess: json['wheelChairAccess'],
      aslInterpreter: json['aslInterpreter'],
      veganMenu: json['veganMenu'],
      restroom: json['restroom'],
      other: json['other'],
    );
  }

  Map<String, dynamic> toJson() => {
    'quietSpace': quietSpace,
    'largerSeating': largerSeating,
    'wheelChairAccess': wheelChairAccess,
    'aslInterpreter': aslInterpreter,
    'veganMenu': veganMenu,
    'restroom': restroom,
    'other': other,
  };
}

class GuestAware2 {
  final bool? petsPresent;
  final bool? childrenPresent;
  final bool? forAdultOnly;
  final bool? smokePresent;
  final bool? smokeFree;
  final bool? alcohol;
  final bool? alcoholFree;
  final bool? stepsToClimb;
  final String? swimmingPool;
  final bool? fireArms;
  final bool? shellFish;
  final bool? peanuts;
  final bool? endsInFirmTime;
  final String? itemContaining;
  final String? others;

  GuestAware2({
    this.petsPresent,
    this.childrenPresent,
    this.forAdultOnly,
    this.smokePresent,
    this.smokeFree,
    this.alcohol,
    this.alcoholFree,
    this.stepsToClimb,
    this.swimmingPool,
    this.fireArms,
    this.shellFish,
    this.peanuts,
    this.endsInFirmTime,
    this.itemContaining,
    this.others,
  });

  factory GuestAware2.fromJson(Map<String, dynamic> json) {
    return GuestAware2(
      petsPresent: json['petsPresent'],
      childrenPresent: json['childrenPresent'],
      forAdultOnly: json['forAdultOnly'],
      smokePresent: json['smokePresent'],
      smokeFree: json['smokeFree'],
      alcohol: json['alcohol'],
      alcoholFree: json['alcoholFree'],
      stepsToClimb: json['stepsToClimb'],
      swimmingPool: json['swimmingPool'],
      fireArms: json['fireArms'],
      shellFish: json['shellFish'],
      peanuts: json['peanuts'],
      endsInFirmTime: json['endsInFirmTime'],
      itemContaining: json['itemContaining'],
      others: json['others'],
    );
  }

  Map<String, dynamic> toJson() => {
    'petsPresent': petsPresent,
    'childrenPresent': childrenPresent,
    'forAdultOnly': forAdultOnly,
    'smokePresent': smokePresent,
    'smokeFree': smokeFree,
    'alcohol': alcohol,
    'alcoholFree': alcoholFree,
    'stepsToClimb': stepsToClimb,
    'swimmingPool': swimmingPool,
    'fireArms': fireArms,
    'shellFish': shellFish,
    'peanuts': peanuts,
    'endsInFirmTime': endsInFirmTime,
    'itemContaining': itemContaining,
    'others': others,
  };
}
