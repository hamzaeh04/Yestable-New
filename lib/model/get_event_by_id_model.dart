class EventDetailsResponse {
  final bool? success;
  final int? statusCode;
  final String? message;
  final EventData? data;

  EventDetailsResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EventDetailsResponse.fromJson(Map<String, dynamic> json) {
    return EventDetailsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? EventData.fromJson(json['data']) : null,
    );
  }
}

class EventData {
  final LocationData? location;
  final String? id;
  final String? image;
  final String? eventName;
  final String? address;
  final String? eventTime;
  final String? eventType;
  final String? invitationMessage;
  final String? parkingDetails;
  final String? addNote;
  final bool? reminderNotification;
  final List<dynamic>? members;
  final List<Menu>? menus;
  final Host? host;
  final bool? reminderSent;
  final bool? isDeleted;
  final bool? isCompleted;
  final bool? isCancelled;
  final bool? displayMenu;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final EventComfort? eventComfort;
  final GuestAware? guestAware;

  EventData({
    this.location,
    this.id,
    this.image,
    this.eventName,
    this.address,
    this.eventTime,
    this.eventType,
    this.invitationMessage,
    this.parkingDetails,
    this.addNote,
    this.reminderNotification,
    this.members,
    this.menus,
    this.host,
    this.reminderSent,
    this.isDeleted,
    this.isCompleted,
    this.isCancelled,
    this.displayMenu,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.eventComfort,
    this.guestAware,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      location: json['location'] != null
          ? LocationData.fromJson(json['location'])
          : null,
      id: json['_id'],
      image: json['image'],
      eventName: json['eventName'],
      address: json['address'],
      eventTime: json['eventTime'],
      eventType: json['eventType'],
      invitationMessage: json['invitationMessage'],
      parkingDetails: json['parkingDetails'],
      addNote: json['addNote'],
      reminderNotification: json['reminderNotification'],
      members: json['members'],
      menus: (json['menus'] as List?)
          ?.map((e) => Menu.fromJson(e))
          .toList(),
      host: json['host'] != null ? Host.fromJson(json['host']) : null,
      reminderSent: json['reminderSent'],
      isDeleted: json['isDeleted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      displayMenu: json['displayMenu'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      eventComfort: json['eventComfort'] != null
          ? EventComfort.fromJson(json['eventComfort'])
          : null,
      guestAware: json['guestAware'] != null
          ? GuestAware.fromJson(json['guestAware'])
          : null,
    );
  }
}

class LocationData {
  final String? type;
  final List<double>? coordinates;

  LocationData({
    this.type,
    this.coordinates,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      type: json['type'],
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}

class Menu {
  final String? id;
  final String? type;
  final List<String>? mealCategory;
  final String? menuImage;
  final String? title;
  final String? description;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Menu({
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

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'],
      type: json['type'],
      mealCategory: (json['mealCategory'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      menuImage: json['menuImage'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Host {
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

  Host({
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

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
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
      fcmTokens: json['fcmTokens'],
      members: json['members'],
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
    return Preferences(
      commonAllergens: json['commonAllergens'] != null
          ? CommonAllergens.fromJson(json['commonAllergens'])
          : null,
      favMood: (json['favMood'] as List?)
          ?.map((e) => FavMood.fromJson(e))
          .toList(),
      plate: json['plate'] != null ? Plate.fromJson(json['plate']) : null,
      yumYuck:
      json['yumYuck'] != null ? YumYuck.fromJson(json['yumYuck']) : null,
      extraAssistance: json['extraAssistance'] != null
          ? ExtraAssistance.fromJson(json['extraAssistance'])
          : null,
      mobilityConcerns: json['mobilityConcerns'],
      needAnythingElse: json['needAnythingElse'],
      quietArea: json['quietArea'],
      seatingRequirement: json['seatingRequirement'] != null
          ? SeatingRequirement.fromJson(json['seatingRequirement'])
          : null,
      hostingAnEvent: json['hostingAnEvent'],
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
    );
  }
}

class FavMood {
  final String? mood;

  FavMood({this.mood});

  factory FavMood.fromJson(Map<String, dynamic> json) {
    return FavMood(mood: json['mood']);
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
      yum: (json['yum'] as List?)?.map((e) => e.toString()).toList(),
      yuck: (json['yuck'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class ExtraAssistance {
  final List<String>? options;

  ExtraAssistance({this.options});

  factory ExtraAssistance.fromJson(Map<String, dynamic> json) {
    return ExtraAssistance(
      options:
      (json['options'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class SeatingRequirement {
  final List<String>? options;

  SeatingRequirement({this.options});

  factory SeatingRequirement.fromJson(Map<String, dynamic> json) {
    return SeatingRequirement(
      options:
      (json['options'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class EventComfort {
  final bool? quietSpace;
  final bool? largerSeating;
  final bool? wheelChairAccess;
  final bool? aslInterpreter;
  final bool? veganMenu;
  final bool? restroom;

  EventComfort({
    this.quietSpace,
    this.largerSeating,
    this.wheelChairAccess,
    this.aslInterpreter,
    this.veganMenu,
    this.restroom,
  });

  factory EventComfort.fromJson(Map<String, dynamic> json) {
    return EventComfort(
      quietSpace: json['quietSpace'],
      largerSeating: json['largerSeating'],
      wheelChairAccess: json['wheelChairAccess'],
      aslInterpreter: json['aslInterpreter'],
      veganMenu: json['veganMenu'],
      restroom: json['restroom'],
    );
  }
}

class GuestAware {
  final bool? petsPresent;
  final bool? childrenPresent;
  final bool? forAdultOnly;
  final bool? smokePresent;
  final bool? smokeFree;
  final bool? alcohol;
  final bool? alcoholFree;
  final bool? stepsToClimb;
  final bool? fireArms;
  final bool? shellFish;
  final bool? peanuts;
  final bool? endsInFirmTime;

  GuestAware({
    this.petsPresent,
    this.childrenPresent,
    this.forAdultOnly,
    this.smokePresent,
    this.smokeFree,
    this.alcohol,
    this.alcoholFree,
    this.stepsToClimb,
    this.fireArms,
    this.shellFish,
    this.peanuts,
    this.endsInFirmTime,
  });

  factory GuestAware.fromJson(Map<String, dynamic> json) {
    return GuestAware(
      petsPresent: json['petsPresent'],
      childrenPresent: json['childrenPresent'],
      forAdultOnly: json['forAdultOnly'],
      smokePresent: json['smokePresent'],
      smokeFree: json['smokeFree'],
      alcohol: json['alcohol'],
      alcoholFree: json['alcoholFree'],
      stepsToClimb: json['stepsToClimb'],
      fireArms: json['fireArms'],
      shellFish: json['shellFish'],
      peanuts: json['peanuts'],
      endsInFirmTime: json['endsInFirmTime'],
    );
  }
}