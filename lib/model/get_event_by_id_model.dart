class GetEventById {
  final bool success;
  final int statusCode;
  final String message;
  final EventData data;

  GetEventById({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetEventById.fromJson(Map<String, dynamic> json) {
    return GetEventById(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: EventData.fromJson(json['data']),
    );
  }
}

class EventData {
  final String id;
  final EventLocation location;
  final String image;
  final String eventName;
  final String address;
  final DateTime eventTime;
  final String eventType;
  final String invitationMessage;
  final String parkingDetails;
  final String addNote;
  final bool reminderNotification;
  final List<dynamic> members;
  final List<dynamic> menus;
  final Host host;
  final bool reminderSent;
  final bool isDeleted;
  final bool isCompleted;
  final bool isCancelled;
  final bool displayMenu;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EventComfort eventComfort;
  final GuestAware guestAware;

  EventData({
    required this.id,
    required this.location,
    required this.image,
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
    required this.eventComfort,
    required this.guestAware,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['_id'],
      location: EventLocation.fromJson(json['location']),
      image: json['image'] ?? '',
      eventName: json['eventName'] ?? '',
      address: json['address'] ?? '',
      eventTime: DateTime.parse(json['eventTime']),
      eventType: json['eventType'] ?? '',
      invitationMessage: json['invitationMessage'] ?? '',
      parkingDetails: json['parkingDetails'] ?? '',
      addNote: json['addNote'] ?? '',
      reminderNotification: json['reminderNotification'] ?? false,
      members: json['members'] ?? [],
      menus: json['menus'] ?? [],
      host: Host.fromJson(json['host']),
      reminderSent: json['reminderSent'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
      isCancelled: json['isCancelled'] ?? false,
      displayMenu: json['displayMenu'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      eventComfort: EventComfort.fromJson(json['eventComfort']),
      guestAware: GuestAware.fromJson(json['guestAware']),
    );
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
      type: json['type'] ?? '',
      coordinates: List<double>.from(
        (json['coordinates'] ?? []).map((e) => (e as num).toDouble()),
      ),
    );
  }
}

class Host {
  final String id;
  final String email;
  final String name;
  final String username;
  final String bio;
  final String location;
  final String profilePic;
  final String pronoun;
  final Preferences preferences;

  Host({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.bio,
    required this.location,
    required this.profilePic,
    required this.pronoun,
    required this.preferences,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
      profilePic: json['profilePic'] ?? '',
      pronoun: json['pronoun'] ?? '',
      preferences: Preferences.fromJson(json['preferences'] ?? {}),
    );
  }
}

class Preferences {
  final CommonAllergens commonAllergens;
  final Plate plate;
  final YumYuck yumYuck;

  Preferences({
    required this.commonAllergens,
    required this.plate,
    required this.yumYuck,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      commonAllergens:
      CommonAllergens.fromJson(json['commonAllergens'] ?? {}),
      plate: Plate.fromJson(json['plate'] ?? {}),
      yumYuck: YumYuck.fromJson(json['yumYuck'] ?? {}),
    );
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

  factory CommonAllergens.fromJson(Map<String, dynamic> json) {
    return CommonAllergens(
      peanut: json['peanut'] ?? '',
      treeNuts: json['treeNuts'] ?? '',
      sesame: json['sesame'] ?? '',
      gluten: json['gluten'] ?? '',
      eggs: json['eggs'] ?? '',
      soy: json['soy'] ?? '',
      fish: json['fish'] ?? '',
      shellFish: json['shellFish'] ?? '',
      dairy: json['dairy'] ?? '',
    );
  }
}

class Plate {
  final bool vegan;
  final bool vegetarian;
  final bool halal;
  final bool kosher;
  final bool keto;
  final String other;

  Plate({
    required this.vegan,
    required this.vegetarian,
    required this.halal,
    required this.kosher,
    required this.keto,
    required this.other,
  });

  factory Plate.fromJson(Map<String, dynamic> json) {
    return Plate(
      vegan: json['vegan'] ?? false,
      vegetarian: json['vegetarian'] ?? false,
      halal: json['halal'] ?? false,
      kosher: json['kosher'] ?? false,
      keto: json['keto'] ?? false,
      other: json['other'] ?? '',
    );
  }
}

class YumYuck {
  final List<String> yum;
  final List<String> yuck;

  YumYuck({
    required this.yum,
    required this.yuck,
  });

  factory YumYuck.fromJson(Map<String, dynamic> json) {
    return YumYuck(
      yum: List<String>.from(json['yum'] ?? []),
      yuck: List<String>.from(json['yuck'] ?? []),
    );
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

  factory EventComfort.fromJson(Map<String, dynamic> json) {
    return EventComfort(
      quietSpace: json['quietSpace'] ?? false,
      largerSeating: json['largerSeating'] ?? false,
      wheelChairAccess: json['wheelChairAccess'] ?? false,
      aslInterpreter: json['aslInterpreter'] ?? false,
      veganMenu: json['veganMenu'] ?? false,
      restroom: json['restroom'] ?? false,
    );
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
  });

  factory GuestAware.fromJson(Map<String, dynamic> json) {
    return GuestAware(
      petsPresent: json['petsPresent'] ?? false,
      childrenPresent: json['childrenPresent'] ?? false,
      forAdultOnly: json['forAdultOnly'] ?? false,
      smokePresent: json['smokePresent'] ?? false,
      smokeFree: json['smokeFree'] ?? false,
      alcohol: json['alcohol'] ?? false,
      alcoholFree: json['alcoholFree'] ?? false,
      stepsToClimb: json['stepsToClimb'] ?? false,
      fireArms: json['fireArms'] ?? false,
      shellFish: json['shellFish'] ?? false,
      peanuts: json['peanuts'] ?? false,
      endsInFirmTime: json['endsInFirmTime'] ?? false,
    );
  }
}