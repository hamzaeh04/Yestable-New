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

  Host({
    this.id,
    this.email,
    this.name,
    this.username,
    this.profilePic,
    this.location
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profilePic: json['profilePic'],
      location: json['location'],
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
