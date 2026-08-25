
class PendingInvitationModel {
  bool? success;
  int? statusCode;
  String? message;
  List<PendingInvitationData>? data;

  PendingInvitationModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  PendingInvitationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];

    if (json['data'] != null) {
      data = <PendingInvitationData>[];
      json['data'].forEach((v) {
        data!.add(PendingInvitationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class PendingInvitationData {
  String? id;
  PendingInvitationEvent? event;
  PendingInvitationUser? invitee;
  PendingInvitationUser? invitedBy;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;

  PendingInvitationData({
    this.id,
    this.event,
    this.invitee,
    this.invitedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PendingInvitationData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    event = json['event'] != null
        ? PendingInvitationEvent.fromJson(json['event'])
        : null;

    invitee = json['invitee'] != null
        ? PendingInvitationUser.fromJson(json['invitee'])
        : null;

    invitedBy = json['invitedBy'] != null
        ? PendingInvitationUser.fromJson(json['invitedBy'])
        : null;

    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'event': event?.toJson(),
      'invitee': invitee?.toJson(),
      'invitedBy': invitedBy?.toJson(),
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class PendingInvitationEvent {
  PendingInvitationLocation? location;
  String? id;
  String? image;
  int? estimatedGuests;
  String? eventName;
  String? address;
  String? eventTime;
  String? eventType;
  String? invitationMessage;
  String? parkingDetails;
  String? addNote;
  bool? reminderNotification;
  List<dynamic>? members;
  List<dynamic>? menus;
  String? host;
  bool? reminderSent;
  bool? isDeleted;
  bool? isCompleted;
  bool? isCancelled;
  bool? displayMenu;
  String? createdAt;
  String? updatedAt;
  int? v;
  PendingInvitationEventComfort? eventComfort;
  PendingInvitationGuestAware? guestAware;
  int? dietaryCompatibilityScore;

  PendingInvitationEvent({
    this.location,
    this.id,
    this.image,
    this.estimatedGuests,
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
    this.dietaryCompatibilityScore,
  });

  PendingInvitationEvent.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? PendingInvitationLocation.fromJson(json['location'])
        : null;

    id = json['_id'];
    image = json['image'];
    estimatedGuests = json['estimatedGuests'];
    eventName = json['eventName'];
    address = json['address'];
    eventTime = json['eventTime'];
    eventType = json['eventType'];
    invitationMessage = json['invitationMessage'];
    parkingDetails = json['parkingDetails'];
    addNote = json['addNote'];
    reminderNotification = json['reminderNotification'];

    if (json['members'] != null) {
      members = List<dynamic>.from(json['members']);
    }

    if (json['menus'] != null) {
      menus = List<dynamic>.from(json['menus']);
    }

    host = json['host'] is Map<String, dynamic>
        ? json['host']['_id'] as String?
        : json['host'] as String?;
    reminderSent = json['reminderSent'];
    isDeleted = json['isDeleted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    displayMenu = json['displayMenu'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];

    eventComfort = json['eventComfort'] != null
        ? PendingInvitationEventComfort.fromJson(json['eventComfort'])
        : null;

    guestAware = json['guestAware'] != null
        ? PendingInvitationGuestAware.fromJson(json['guestAware'])
        : null;
    dietaryCompatibilityScore = json['dietaryCompatibilityScore'];
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      '_id': id,
      'image': image,
      'estimatedGuests': estimatedGuests,
      'eventName': eventName,
      'address': address,
      'eventTime': eventTime,
      'eventType': eventType,
      'invitationMessage': invitationMessage,
      'parkingDetails': parkingDetails,
      'addNote': addNote,
      'reminderNotification': reminderNotification,
      'members': members,
      'menus': menus,
      'host': host,
      'reminderSent': reminderSent,
      'isDeleted': isDeleted,
      'isCompleted': isCompleted,
      'isCancelled': isCancelled,
      'displayMenu': displayMenu,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'eventComfort': eventComfort?.toJson(),
      'guestAware': guestAware?.toJson(),
      'dietaryCompatibilityScore': dietaryCompatibilityScore,
    };
  }
}

class PendingInvitationLocation {
  String? type;
  List<double>? coordinates;

  PendingInvitationLocation({
    this.type,
    this.coordinates,
  });

  PendingInvitationLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];

    if (json['coordinates'] != null) {
      coordinates = List<double>.from(
        json['coordinates'].map(
              (x) => (x as num).toDouble(),
        ),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class PendingInvitationEventComfort {
  bool? quietSpace;
  bool? largerSeating;
  bool? wheelChairAccess;
  bool? aslInterpreter;
  bool? veganMenu;
  bool? restroom;

  PendingInvitationEventComfort({
    this.quietSpace,
    this.largerSeating,
    this.wheelChairAccess,
    this.aslInterpreter,
    this.veganMenu,
    this.restroom,
  });

  PendingInvitationEventComfort.fromJson(Map<String, dynamic> json) {
    quietSpace = json['quietSpace'];
    largerSeating = json['largerSeating'];
    wheelChairAccess = json['wheelChairAccess'];
    aslInterpreter = json['aslInterpreter'];
    veganMenu = json['veganMenu'];
    restroom = json['restroom'];
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

class PendingInvitationGuestAware {
  bool? petsPresent;
  bool? childrenPresent;
  bool? forAdultOnly;
  bool? smokePresent;
  bool? smokeFree;
  bool? alcohol;
  bool? alcoholFree;
  bool? stepsToClimb;
  bool? fireArms;
  bool? shellFish;
  bool? peanuts;
  bool? endsInFirmTime;
  bool? guestContact;

  PendingInvitationGuestAware({
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
    this.guestContact,
  });

  PendingInvitationGuestAware.fromJson(Map<String, dynamic> json) {
    petsPresent = json['petsPresent'];
    childrenPresent = json['childrenPresent'];
    forAdultOnly = json['forAdultOnly'];
    smokePresent = json['smokePresent'];
    smokeFree = json['smokeFree'];
    alcohol = json['alcohol'];
    alcoholFree = json['alcoholFree'];
    stepsToClimb = json['stepsToClimb'];
    fireArms = json['fireArms'];
    shellFish = json['shellFish'];
    peanuts = json['peanuts'];
    endsInFirmTime = json['endsInFirmTime'];
    guestContact = json['guestContact'];
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
      'guestContact': guestContact,
    };
  }
}

class PendingInvitationUser {
  String? id;
  String? email;
  String? name;
  bool? iAmHosting;
  bool? isProfilePublic;
  bool? notificationOpen;
  int? onboardingStep;
  bool? profileCompleted;
  bool? isOnboarding;
  bool? isNotificationAllowed;
  List<dynamic>? fcmTokens;
  List<PendingInvitationMember>? members;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? bio;
  String? location;
  String? profilePic;
  String? pronoun;
  String? username;
  PendingInvitationPreferences? preferences;

  PendingInvitationUser({
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

  PendingInvitationUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    name = json['name'];
    iAmHosting = json['iAmHosting'];
    isProfilePublic = json['isProfilePublic'];
    notificationOpen = json['notificationOpen'];
    onboardingStep = json['onboardingStep'];
    profileCompleted = json['profileCompleted'];
    isOnboarding = json['isOnboarding'];
    isNotificationAllowed = json['isNotificationAllowed'];

    if (json['fcmTokens'] != null) {
      fcmTokens = List<dynamic>.from(json['fcmTokens']);
    }

    if (json['members'] != null) {
      members = <PendingInvitationMember>[];

      json['members'].forEach((v) {
        members!.add(
          PendingInvitationMember.fromJson(v),
        );
      });
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    bio = json['bio'];
    location = json['location'];
    profilePic = json['profilePic'];
    pronoun = json['pronoun'];
    username = json['username'];

    preferences = json['preferences'] != null
        ? PendingInvitationPreferences.fromJson(
      json['preferences'],
    )
        : null;
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
      'members': members?.map((v) => v.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'bio': bio,
      'location': location,
      'profilePic': profilePic,
      'pronoun': pronoun,
      'username': username,
      'preferences': preferences?.toJson(),
    };
  }
}

class PendingInvitationMember {
  String? name;
  String? relation;
  int? age;
  PendingInvitationPreferences? preferences;
  int? onboardingStep;
  bool? profileCompleted;
  String? id;

  PendingInvitationMember({
    this.name,
    this.relation,
    this.age,
    this.preferences,
    this.onboardingStep,
    this.profileCompleted,
    this.id,
  });

  PendingInvitationMember.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relation = json['relation'];
    age = json['age'];

    preferences = json['preferences'] != null
        ? PendingInvitationPreferences.fromJson(
      json['preferences'],
    )
        : null;

    onboardingStep = json['onboardingStep'];
    profileCompleted = json['profileCompleted'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relation': relation,
      'age': age,
      'preferences': preferences?.toJson(),
      'onboardingStep': onboardingStep,
      'profileCompleted': profileCompleted,
      '_id': id,
    };
  }
}

class PendingInvitationPreferences {
  PendingInvitationCommonAllergens? commonAllergens;
  List<PendingInvitationMood>? favMood;
  PendingInvitationPlate? plate;
  PendingInvitationExtraAssistance? extraAssistance;
  bool? quietArea;
  PendingInvitationSeatingRequirement? seatingRequirement;
  PendingInvitationYumYuck? yumYuck;
  String? mobilityConcerns;
  String? needAnythingElse;
  bool? hostingAnEvent;

  PendingInvitationPreferences({
    this.commonAllergens,
    this.favMood,
    this.plate,
    this.extraAssistance,
    this.quietArea,
    this.seatingRequirement,
    this.yumYuck,
    this.mobilityConcerns,
    this.needAnythingElse,
    this.hostingAnEvent,
  });

  PendingInvitationPreferences.fromJson(
      Map<String, dynamic> json,
      ) {
    commonAllergens = json['commonAllergens'] != null
        ? PendingInvitationCommonAllergens.fromJson(
      json['commonAllergens'],
    )
        : null;

    if (json['favMood'] != null) {
      favMood = <PendingInvitationMood>[];

      json['favMood'].forEach((v) {
        favMood!.add(
          PendingInvitationMood.fromJson(v),
        );
      });
    }

    plate = json['plate'] != null
        ? PendingInvitationPlate.fromJson(json['plate'])
        : null;

    extraAssistance = json['extraAssistance'] != null
        ? PendingInvitationExtraAssistance.fromJson(
      json['extraAssistance'],
    )
        : null;

    quietArea = json['quietArea'];

    seatingRequirement = json['seatingRequirement'] != null
        ? PendingInvitationSeatingRequirement.fromJson(
      json['seatingRequirement'],
    )
        : null;

    yumYuck = json['yumYuck'] != null
        ? PendingInvitationYumYuck.fromJson(
      json['yumYuck'],
    )
        : null;

    mobilityConcerns = json['mobilityConcerns'];
    needAnythingElse = json['needAnythingElse'];
    hostingAnEvent = json['hostingAnEvent'];
  }

  Map<String, dynamic> toJson() {
    return {
      'commonAllergens': commonAllergens?.toJson(),
      'favMood': favMood?.map((v) => v.toJson()).toList(),
      'plate': plate?.toJson(),
      'extraAssistance': extraAssistance?.toJson(),
      'quietArea': quietArea,
      'seatingRequirement': seatingRequirement?.toJson(),
      'yumYuck': yumYuck?.toJson(),
      'mobilityConcerns': mobilityConcerns,
      'needAnythingElse': needAnythingElse,
      'hostingAnEvent': hostingAnEvent,
    };
  }
}

class PendingInvitationCommonAllergens {
  String? peanut;
  String? treeNuts;
  String? sesame;
  String? gluten;
  String? eggs;
  String? soy;
  String? fish;
  String? shellFish;
  String? dairy;
  String? others;

  PendingInvitationCommonAllergens({
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

  PendingInvitationCommonAllergens.fromJson(
      Map<String, dynamic> json,
      ) {
    peanut = json['peanut'];
    treeNuts = json['treeNuts'];
    sesame = json['sesame'];
    gluten = json['gluten'];
    eggs = json['eggs'];
    soy = json['soy'];
    fish = json['fish'];
    shellFish = json['shellFish'];
    dairy = json['dairy'];
    others = json['others'];
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
      'others': others,
    };
  }
}

class PendingInvitationMood {
  String? mood;

  PendingInvitationMood({
    this.mood,
  });

  PendingInvitationMood.fromJson(
      Map<String, dynamic> json,
      ) {
    mood = json['mood'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
    };
  }
}

class PendingInvitationPlate {
  bool? vegan;
  bool? vegetarian;
  bool? halal;
  bool? kosher;
  bool? keto;
  String? other;

  PendingInvitationPlate({
    this.vegan,
    this.vegetarian,
    this.halal,
    this.kosher,
    this.keto,
    this.other,
  });

  PendingInvitationPlate.fromJson(
      Map<String, dynamic> json,
      ) {
    vegan = json['vegan'];
    vegetarian = json['vegetarian'];
    halal = json['halal'];
    kosher = json['kosher'];
    keto = json['keto'];
    other = json['other'];
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

class PendingInvitationExtraAssistance {
  List<String>? options;

  PendingInvitationExtraAssistance({
    this.options,
  });

  PendingInvitationExtraAssistance.fromJson(
      Map<String, dynamic> json,
      ) {
    if (json['options'] != null) {
      options = List<String>.from(json['options']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class PendingInvitationSeatingRequirement {
  List<String>? options;

  PendingInvitationSeatingRequirement({
    this.options,
  });

  PendingInvitationSeatingRequirement.fromJson(
      Map<String, dynamic> json,
      ) {
    if (json['options'] != null) {
      options = List<String>.from(json['options']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class PendingInvitationYumYuck {
  List<String>? yum;
  List<String>? yuck;

  PendingInvitationYumYuck({
    this.yum,
    this.yuck,
  });

  PendingInvitationYumYuck.fromJson(
      Map<String, dynamic> json,
      ) {
    if (json['yum'] != null) {
      yum = List<String>.from(json['yum']);
    }

    if (json['yuck'] != null) {
      yuck = List<String>.from(json['yuck']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'yum': yum,
      'yuck': yuck,
    };
  }
}
