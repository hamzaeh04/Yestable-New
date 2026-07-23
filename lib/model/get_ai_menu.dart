class AiMenu {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Data? data;

  AiMenu({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory AiMenu.fromJson(Map<String, dynamic> json) {
    return AiMenu(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
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

class Data {
  final List<Suggestion>? suggestions;
  final GuestProfile? guestProfile;

  Data({
    this.suggestions,
    this.guestProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      suggestions: json['suggestions'] != null
          ? List<Suggestion>.from(
              json['suggestions'].map((x) => Suggestion.fromJson(x)),
            )
          : null,
      guestProfile: json['guestProfile'] != null
          ? GuestProfile.fromJson(json['guestProfile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestions': suggestions?.map((e) => e.toJson()).toList(),
      'guestProfile': guestProfile?.toJson(),
    };
  }
}

class GuestProfile {
  final int? totalGuests;
  final PlateCounts? plateCounts;
  final List<dynamic>? severeAllergens;
  final List<dynamic>? mildAllergens;
  final List<dynamic>? dislikedIngredients;
  final List<dynamic>? likedIngredients;
  final List<dynamic>? customNotes;

  GuestProfile({
    this.totalGuests,
    this.plateCounts,
    this.severeAllergens,
    this.mildAllergens,
    this.dislikedIngredients,
    this.likedIngredients,
    this.customNotes,
  });

  factory GuestProfile.fromJson(Map<String, dynamic> json) {
    return GuestProfile(
      totalGuests: json['totalGuests'],
      plateCounts: json['plateCounts'] != null
          ? PlateCounts.fromJson(json['plateCounts'])
          : null,
      severeAllergens: json['severeAllergens'],
      mildAllergens: json['mildAllergens'],
      dislikedIngredients: json['dislikedIngredients'],
      likedIngredients: json['likedIngredients'],
      customNotes: json['customNotes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalGuests': totalGuests,
      'plateCounts': plateCounts?.toJson(),
      'severeAllergens': severeAllergens,
      'mildAllergens': mildAllergens,
      'dislikedIngredients': dislikedIngredients,
      'likedIngredients': likedIngredients,
      'customNotes': customNotes,
    };
  }
}

class PlateCounts {
  final int? vegan;
  final int? vegetarian;
  final int? halal;
  final int? kosher;
  final int? keto;

  PlateCounts({
    this.vegan,
    this.vegetarian,
    this.halal,
    this.kosher,
    this.keto,
  });

  factory PlateCounts.fromJson(Map<String, dynamic> json) {
    return PlateCounts(
      vegan: json['vegan'],
      vegetarian: json['vegetarian'],
      halal: json['halal'],
      kosher: json['kosher'],
      keto: json['keto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vegan': vegan,
      'vegetarian': vegetarian,
      'halal': halal,
      'kosher': kosher,
      'keto': keto,
    };
  }
}

class Suggestion {
  final String? title;
  final String? description;
  final String? type;
  final List<String>? dietaryTags;
  final List<String>? badges;
  final String? whySuitable;

  Suggestion({
    this.title,
    this.description,
    this.type,
    this.dietaryTags,
    this.badges,
    this.whySuitable,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      title: json['title'],
      description: json['description'],
      type: json['type'],
      dietaryTags: json['dietaryTags'] != null
          ? List<String>.from(json['dietaryTags'].map((x) => x.toString()))
          : null,
      badges: json['badges'] != null
          ? List<String>.from(json['badges'].map((x) => x.toString()))
          : null,
      whySuitable: json['whySuitable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'dietaryTags': dietaryTags,
      'badges': badges,
      'whySuitable': whySuitable,
    };
  }
}
