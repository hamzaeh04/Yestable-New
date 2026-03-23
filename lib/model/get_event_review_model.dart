class EventReviewModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final EventData? data;

  EventReviewModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EventReviewModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return EventReviewModel();

    return EventReviewModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: EventData.fromJson(json['data']),
    );
  }
}

class EventData {
  final Location? location;
  final String? id;
  final String? image;
  final String? eventName;
  final DateTime? eventTime;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final EventComfort? eventComfort;
  final GuestAware? guestAware;

  EventData({
    this.location,
    this.id,
    this.image,
    this.eventName,
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
    this.eventComfort,
    this.guestAware,
  });

  factory EventData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return EventData();

    return EventData(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      image: json['image'],
      eventName: json['eventName'],
      eventTime: DateTime.tryParse(json['eventTime'] ?? ""),
      eventType: json['eventType'],
      invitationMessage: json['invitationMessage'],
      parkingDetails: json['parkingDetails'],
      addNote: json['addNote'],
      reminderNotification: json['reminderNotification'],
      members: json['members'] ?? [],
      menus: (json['menus'] as List?)
          ?.map((e) => Menu.fromJson(e))
          .toList() ??
          [],
      host: Host.fromJson(json['host']),
      reminderSent: json['reminderSent'],
      isDeleted: json['isDeleted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      displayMenu: json['displayMenu'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ""),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ""),
      eventComfort: EventComfort.fromJson(json['eventComfort']),
      guestAware: GuestAware.fromJson(json['guestAware']),
    );
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Location();

    return Location(
      type: json['type'],
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
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

  Menu({
    this.id,
    this.type,
    this.mealCategory,
    this.menuImage,
    this.title,
    this.description,
  });

  factory Menu.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Menu();

    return Menu(
      id: json['_id'],
      type: json['type'],
      mealCategory:
      (json['mealCategory'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      menuImage: json['menuImage'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class Host {
  final String? id;
  final String? email;
  final String? name;
  final String? profilePic;
  final String? username;
  final String? bio;
  final String? location;
  final String? pronoun;

  final bool? iAmHosting;
  final bool? notificationOpen;
  final bool? profileCompleted;
  final bool? isOnboarding;
  final bool? isNotificationAllowed;

  final int? onboardingStep;

  final List<Member>? members;
  final Preferences? preferences;

  Host({
    this.id,
    this.email,
    this.name,
    this.profilePic,
    this.username,
    this.bio,
    this.location,
    this.pronoun,
    this.iAmHosting,
    this.notificationOpen,
    this.profileCompleted,
    this.isOnboarding,
    this.isNotificationAllowed,
    this.onboardingStep,
    this.members,
    this.preferences,
  });

  factory Host.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Host();

    return Host(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      profilePic: json['profilePic'],
      username: json['username'],
      bio: json['bio'],
      location: json['location'],
      pronoun: json['pronoun'],
      iAmHosting: json['iAmHosting'],
      notificationOpen: json['notificationOpen'],
      profileCompleted: json['profileCompleted'],
      isOnboarding: json['isOnboarding'],
      isNotificationAllowed: json['isNotificationAllowed'],
      onboardingStep: json['onboardingStep'],
      members: (json['members'] as List?)
          ?.map((e) => Member.fromJson(e))
          .toList() ??
          [],
      preferences: Preferences.fromJson(json['preferences']),
    );
  }
}

class Member {
  final String? id;
  final String? name;
  final String? relation;
  final int? age;
  final Preferences? preferences;

  Member({
    this.id,
    this.name,
    this.relation,
    this.age,
    this.preferences,
  });

  factory Member.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Member();

    return Member(
      id: json['_id'],
      name: json['name'],
      relation: json['relation'],
      age: json['age'],
      preferences: Preferences.fromJson(json['preferences']),
    );
  }
}

class Preferences {
  final Plate? plate;
  final bool? quietArea;
  final bool? hostingAnEvent;
  final CommonAllergens? commonAllergens;
  final YumYuck? yumYuck;

  Preferences({
    this.plate,
    this.quietArea,
    this.hostingAnEvent,
    this.commonAllergens,
    this.yumYuck,
  });

  factory Preferences.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Preferences();

    return Preferences(
      plate: Plate.fromJson(json['plate']),
      quietArea: json['quietArea'],
      hostingAnEvent: json['hostingAnEvent'],
      commonAllergens:
      CommonAllergens.fromJson(json['commonAllergens']),
      yumYuck: YumYuck.fromJson(json['yumYuck']),
    );
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

  factory Plate.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Plate();

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

  factory CommonAllergens.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CommonAllergens();

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

class YumYuck {
  final List<String>? yum;
  final List<String>? yuck;

  YumYuck({this.yum, this.yuck});

  factory YumYuck.fromJson(Map<String, dynamic>? json) {
    if (json == null) return YumYuck();

    return YumYuck(
      yum: (json['yum'] as List?)?.map((e) => e.toString()).toList() ?? [],
      yuck: (json['yuck'] as List?)?.map((e) => e.toString()).toList() ?? [],
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
  final String? other;

  EventComfort({
    this.quietSpace,
    this.largerSeating,
    this.wheelChairAccess,
    this.aslInterpreter,
    this.veganMenu,
    this.restroom,
    this.other,
  });

  factory EventComfort.fromJson(Map<String, dynamic>? json) {
    if (json == null) return EventComfort();

    return EventComfort(
      quietSpace: json['quietSpace'],
      largerSeating: json['largerSeating'],
      wheelChairAccess: json['wheelChairAccess'],
      aslInterpreter: json['aslInterpreter'],
      veganMenu: json['veganMenu'],
      restroom: json['restroom'],
      other: json['other'],
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
  final String? swimmingPool;
  final bool? fireArms;
  final bool? shellFish;
  final bool? peanuts;
  final bool? endsInFirmTime;
  final String? itemContaining;
  final String? others;
  final String? guestContact;

  GuestAware({
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
    this.guestContact,
  });

  factory GuestAware.fromJson(Map<String, dynamic>? json) {
    if (json == null) return GuestAware();

    return GuestAware(
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
      guestContact: json['guestContact'],
    );
  }
}
