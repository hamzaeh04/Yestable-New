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

  factory EventReviewModel.fromJson(Map<String, dynamic> json) {
    return EventReviewModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? EventData.fromJson(json['data']) : null,
    );
  }
}

class EventData {
  final Location? location;
  final String? id;
  final String? image;
  final String? eventName;
  final String? address;
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
  final int? dietaryCompatibilityScore;
  final int? numGuests;
  final int? estimatedGuests;

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
    this.eventComfort,
    this.guestAware,
    this.dietaryCompatibilityScore,
    this.numGuests,
    this.estimatedGuests,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'],
      image: json['image'],
      eventName: json['eventName'],
      address: json['address'],
      eventTime: json['eventTime'] != null ? DateTime.tryParse(json['eventTime']) : null,
      eventType: json['eventType'],
      invitationMessage: json['invitationMessage'],
      parkingDetails: json['parkingDetails'],
      addNote: json['addNote'],
      reminderNotification: json['reminderNotification'],
      members: json['members'],
      menus: (json['menus'] as List?)?.map((e) => Menu.fromJson(e)).toList(),
      host: json['host'] != null ? Host.fromJson(json['host']) : null,
      reminderSent: json['reminderSent'],
      isDeleted: json['isDeleted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      displayMenu: json['displayMenu'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      eventComfort: json['eventComfort'] != null ? EventComfort.fromJson(json['eventComfort']) : null,
      guestAware: json['guestAware'] != null ? GuestAware.fromJson(json['guestAware']) : null,
      dietaryCompatibilityScore: json['dietaryCompatibilityScore'],
      numGuests: json['numGuests'],
      estimatedGuests: json['estimatedGuests'],
    );
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'],
      type: json['type'],
      mealCategory: (json['mealCategory'] as List?)?.map((e) => e.toString()).toList(),
      menuImage: json['menuImage'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}

class Host {
  final String? id;
  final String? email;
  final String? name;
  final String? username;
  final String? profilePic;
  final String? location;
  final String? bio;
  final List<dynamic>? members;
  final HostPreferences? preferences;

  Host({
    this.id,
    this.email,
    this.name,
    this.username,
    this.profilePic,
    this.location,
    this.bio,
    this.members,
    this.preferences,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profilePic: json['profilePic'],
      location: json['location'],
      bio: json['bio'],
      members: json['members'],
      preferences: json['preferences'] != null
          ? HostPreferences.fromJson(json['preferences'])
          : null,
    );
  }
}

class HostPreferences {
  final HostCommonAllergens? commonAllergens;
  final List<HostFavMood>? favMood;
  final HostPlate? plate;
  final HostYumYuck? yumYuck;

  HostPreferences({
    this.commonAllergens,
    this.favMood,
    this.plate,
    this.yumYuck,
  });

  factory HostPreferences.fromJson(Map<String, dynamic> json) {
    return HostPreferences(
      commonAllergens: json['commonAllergens'] != null
          ? HostCommonAllergens.fromJson(json['commonAllergens'])
          : null,
      favMood: (json['favMood'] as List?)
          ?.map((e) => HostFavMood.fromJson(e))
          .toList(),
      plate: json['plate'] != null ? HostPlate.fromJson(json['plate']) : null,
      yumYuck: json['yumYuck'] != null
          ? HostYumYuck.fromJson(json['yumYuck'])
          : null,
    );
  }
}

class HostCommonAllergens {
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

  HostCommonAllergens({
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

  factory HostCommonAllergens.fromJson(Map<String, dynamic> json) {
    return HostCommonAllergens(
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

class HostFavMood {
  final String? mood;

  HostFavMood({this.mood});

  factory HostFavMood.fromJson(Map<String, dynamic> json) {
    return HostFavMood(mood: json['mood']);
  }
}

class HostPlate {
  final bool? vegan;
  final bool? vegetarian;
  final bool? halal;
  final bool? kosher;
  final bool? keto;
  final String? other;

  HostPlate({
    this.vegan,
    this.vegetarian,
    this.halal,
    this.kosher,
    this.keto,
    this.other,
  });

  factory HostPlate.fromJson(Map<String, dynamic> json) {
    return HostPlate(
      vegan: json['vegan'],
      vegetarian: json['vegetarian'],
      halal: json['halal'],
      kosher: json['kosher'],
      keto: json['keto'],
      other: json['other'],
    );
  }
}

class HostYumYuck {
  final List<String>? yum;
  final List<String>? yuck;

  HostYumYuck({this.yum, this.yuck});

  factory HostYumYuck.fromJson(Map<String, dynamic> json) {
    return HostYumYuck(
      yum: (json['yum'] as List?)?.map((e) => e.toString()).toList(),
      yuck: (json['yuck'] as List?)?.map((e) => e.toString()).toList(),
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

  factory EventComfort.fromJson(Map<String, dynamic> json) {
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
      swimmingPool: json['swimmingPool'],
      fireArms: json['fireArms'],
      shellFish: json['shellFish'],
      peanuts: json['peanuts'],
      endsInFirmTime: json['endsInFirmTime'],
      itemContaining: json['itemContaining'],
    );
  }
}
