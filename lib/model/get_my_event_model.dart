class GetMyEventModel {
  final bool success;
  final int statusCode;
  final String message;
  final EventData data;

  GetMyEventModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetMyEventModel.fromJson(Map<String, dynamic> json) {
    return GetMyEventModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: EventData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class EventData {
  final List<Event> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  EventData({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      data: (json['data'] as List? ?? [])
          .map((e) => Event.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}

class Event {
  final String id;
  // ✅ NEW FIELD ADDED
  final int estimatedGuests;
  final String eventName;
  final String address;
  final DateTime eventTime;
  final String eventType;
  final String invitationMessage;
  final String parkingDetails;
  final String addNote;

  final bool reminderNotification;
  final List<dynamic> members;
  final List<Menu> menus;

  final Host host;

  final bool reminderSent;
  final bool isDeleted;
  final bool isCompleted;
  final bool isCancelled;
  final bool displayMenu;

  final DateTime createdAt;
  final DateTime updatedAt;

  final int numGuests;

  // NEW FIELD
  final int dietaryCompatibilityScore;

  final Location location;

  final EventComfort1 eventComfort1;
  final GuestAware1 guestAware1;

  Event({
    required this.id,
    required this.estimatedGuests,
    required this.eventName,
    required this.address,
    required this.eventTime,
    required this.eventType,
    required this.invitationMessage,
    required this.parkingDetails,
    required this.addNote,
    required this.reminderNotification,
    required this.members,
    required this.menus,
    required this.host,
    required this.reminderSent,
    required this.isDeleted,
    required this.isCompleted,
    required this.isCancelled,
    required this.displayMenu,
    required this.createdAt,
    required this.updatedAt,
    required this.numGuests,
    required this.dietaryCompatibilityScore,
    required this.location,
    required this.eventComfort1,
    required this.guestAware1,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] ?? '',
      estimatedGuests: json['estimatedGuests'] ?? 0,
      eventName: json['eventName'] ?? '',
      address: json['address'] ?? '',
      eventTime: DateTime.tryParse(json['eventTime'] ?? '') ?? DateTime.now(),
      eventType: json['eventType'] ?? '',
      invitationMessage: json['invitationMessage'] ?? '',
      parkingDetails: json['parkingDetails'] ?? '',
      addNote: json['addNote'] ?? '',
      reminderNotification: json['reminderNotification'] ?? false,
      members: json['members'] ?? [],
      menus: (json['menus'] as List? ?? [])
          .map((e) => Menu.fromJson(e))
          .toList(),
      host: Host.fromJson(json['host'] ?? {}),
      reminderSent: json['reminderSent'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isCancelled: json['isCancelled'] ?? false,
      displayMenu: json['displayMenu'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      numGuests: json['numGuests'] ?? 0,

      // NEW FIELD
      dietaryCompatibilityScore: json['dietaryCompatibilityScore'] ?? 0,

      location: Location.fromJson(json['location'] ?? {}),

      eventComfort1: EventComfort1.fromJson(json['eventComfort'] ?? {}),
      guestAware1: GuestAware1.fromJson(json['guestAware'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'estimatedGuests': estimatedGuests,
      'eventName': eventName,
      'address': address,
      'eventTime': eventTime.toIso8601String(),
      'eventType': eventType,
      'invitationMessage': invitationMessage,
      'parkingDetails': parkingDetails,
      'addNote': addNote,
      'reminderNotification': reminderNotification,
      'members': members,
      'menus': menus.map((e) => e.toJson()).toList(),
      'host': host.toJson(),
      'reminderSent': reminderSent,
      'isDeleted': isDeleted,
      'isCompleted': isCompleted,
      'isCancelled': isCancelled,
      'displayMenu': displayMenu,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'numGuests': numGuests,

      // NEW FIELD
      'dietaryCompatibilityScore': dietaryCompatibilityScore,

      'location': location.toJson(),
      'eventComfort': eventComfort1.toJson(),
      'guestAware': guestAware1.toJson(),
    };
  }
}

/* ========================= LOCATION ========================= */

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

/* ========================= HOST ========================= */

class Host {
  final String id;
  final String email;
  final String name;
  final String username;
  final String profilePic;
  final Preferences preferences;

  Host({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.profilePic,
    required this.preferences,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      profilePic: json['profilePic'] ?? '',
      preferences: Preferences.fromJson(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'username': username,
      'profilePic': profilePic,
      'preferences': preferences.toJson(),
    };
  }
}

/* ========================= MENU ========================= */

class Menu {
  final String id;
  final String type;
  final List<String> mealCategory;
  final String title;
  final String description;
  final String menuImage;

  Menu({
    required this.id,
    required this.type,
    required this.mealCategory,
    required this.title,
    required this.description,
    required this.menuImage,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'] ?? '',
      type: json['type'] ?? '',
      mealCategory: List<String>.from(json['mealCategory'] ?? []),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      menuImage: json['menuImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'mealCategory': mealCategory,
      'title': title,
      'description': description,
      'menuImage': menuImage,
    };
  }
}

/* ========================= EVENT COMFORT 1 ========================= */

class EventComfort1 {
  final bool quietSpace;
  final bool largerSeating;
  final bool wheelChairAccess;
  final bool aslInterpreter;
  final bool veganMenu;
  final bool restroom;

  EventComfort1({
    required this.quietSpace,
    required this.largerSeating,
    required this.wheelChairAccess,
    required this.aslInterpreter,
    required this.veganMenu,
    required this.restroom,
  });

  factory EventComfort1.fromJson(Map<String, dynamic> json) {
    return EventComfort1(
      quietSpace: json['quietSpace'] ?? false,
      largerSeating: json['largerSeating'] ?? false,
      wheelChairAccess: json['wheelChairAccess'] ?? false,
      aslInterpreter: json['aslInterpreter'] ?? false,
      veganMenu: json['veganMenu'] ?? false,
      restroom: json['restroom'] ?? false,
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

/* ========================= GUEST AWARE 1 ========================= */

class GuestAware1 {
  final bool petsPresent;
  final bool childrenPresent;
  final bool forAdultOnly;
  final bool smokePresent;
  final bool smokeFree;
  final bool alcohol;
  final bool alcoholFree;
  final bool stepsToClimb;
  final dynamic swimmingPool;
  final bool fireArms;
  final bool shellFish;
  final bool peanuts;
  final bool endsInFirmTime;
  final String? itemContaining;
  final String? others;

  GuestAware1({
    required this.petsPresent,
    required this.childrenPresent,
    required this.forAdultOnly,
    required this.smokePresent,
    required this.smokeFree,
    required this.alcohol,
    required this.alcoholFree,
    required this.stepsToClimb,
    required this.swimmingPool,
    required this.fireArms,
    required this.shellFish,
    required this.peanuts,
    required this.endsInFirmTime,
    this.itemContaining,
    this.others,
  });

  factory GuestAware1.fromJson(Map<String, dynamic> json) {
    return GuestAware1(
      petsPresent: json['petsPresent'] ?? false,
      childrenPresent: json['childrenPresent'] ?? false,
      forAdultOnly: json['forAdultOnly'] ?? false,
      smokePresent: json['smokePresent'] ?? false,
      smokeFree: json['smokeFree'] ?? false,
      alcohol: json['alcohol'] ?? false,
      alcoholFree: json['alcoholFree'] ?? false,
      stepsToClimb: json['stepsToClimb'] ?? false,
      swimmingPool: json['swimmingPool'],
      fireArms: json['fireArms'] ?? false,
      shellFish: json['shellFish'] ?? false,
      peanuts: json['peanuts'] ?? false,
      endsInFirmTime: json['endsInFirmTime'] ?? false,
      itemContaining: json['itemContaining'],
      others: json['others'],
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
      'swimmingPool': swimmingPool,
      'fireArms': fireArms,
      'shellFish': shellFish,
      'peanuts': peanuts,
      'endsInFirmTime': endsInFirmTime,
      'itemContaining': itemContaining,
      'others': others,
    };
  }
}

/* ========================= PREFERENCES ========================= */

class Preferences {
  final Map<String, String> commonAllergens;
  final List<Mood> favMood;

  Preferences({
    required this.commonAllergens,
    required this.favMood,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      commonAllergens: Map<String, String>.from(json['commonAllergens'] ?? {}),
      favMood: (json['favMood'] as List? ?? [])
          .map((e) => Mood.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commonAllergens': commonAllergens,
      'favMood': favMood.map((e) => e.toJson()).toList(),
    };
  }
}

class Mood {
  final String mood;

  Mood({required this.mood});

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(mood: json['mood'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'mood': mood};
  }
}
