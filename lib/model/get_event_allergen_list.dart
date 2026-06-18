class EventAllergenResponse {
  final bool? success;
  final int? statusCode;
  final String? message;
  final EventData? data;

  EventAllergenResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EventAllergenResponse.fromJson(Map<String, dynamic> json) {
    return EventAllergenResponse(
      success: json['success'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? EventData.fromJson(json['data'])
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

class EventData {
  final String? eventId;
  final String? eventName;
  final int? totalMembers;
  final int? totalAllergens;
  final List<Allergen>? allergens;

  EventData({
    this.eventId,
    this.eventName,
    this.totalMembers,
    this.totalAllergens,
    this.allergens,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      totalMembers: json['totalMembers'] as int?,
      totalAllergens: json['totalAllergens'] as int?,
      allergens: (json['allergens'] as List?)
          ?.map((e) => Allergen.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'totalMembers': totalMembers,
      'totalAllergens': totalAllergens,
      'allergens': allergens?.map((e) => e.toJson()).toList(),
    };
  }
}

class Allergen {
  final String? label;
  final int? count;
  final int? severe;
  final int? mild;
  final int? avoid;

  Allergen({
    this.label,
    this.count,
    this.severe,
    this.mild,
    this.avoid,
  });

  factory Allergen.fromJson(Map<String, dynamic> json) {
    return Allergen(
      label: json['label'] as String?,
      count: (json['count'] ?? json['total']) as int?,
      severe: json['severe'] as int?,
      mild: json['mild'] as int?,
      avoid: json['avoid'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'count': count,
      'severe': severe,
      'mild': mild,
      'avoid': avoid,
    };
  }
}


