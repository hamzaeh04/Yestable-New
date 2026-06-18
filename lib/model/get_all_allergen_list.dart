class AllAllergen {
  final bool success;
  final int statusCode;
  final String message;
  final AllAllergenData? data;

  AllAllergen({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory AllAllergen.fromJson(Map<String, dynamic> json) {
    return AllAllergen(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AllAllergenData.fromJson(json['data'])
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

class AllAllergenData {
  final String eventId;
  final String eventName;
  final int totalMembers;
  final int totalAllergens;
  final List<AllergenItem> allergens;

  AllAllergenData({
    required this.eventId,
    required this.eventName,
    required this.totalMembers,
    required this.totalAllergens,
    required this.allergens,
  });

  factory AllAllergenData.fromJson(Map<String, dynamic> json) {
    return AllAllergenData(
      eventId: json['eventId'] ?? '',
      eventName: json['eventName'] ?? '',
      totalMembers: json['totalMembers'] ?? 0,
      totalAllergens: json['totalAllergens'] ?? 0,
      allergens: (json['allergens'] as List<dynamic>?)
          ?.map((e) => AllergenItem.fromJson(e))
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
      'allergens': allergens.map((e) => e.toJson()).toList(),
    };
  }
}

class AllergenItem {
  final String label;
  final int count;

  AllergenItem({
    required this.label,
    required this.count,
  });

  factory AllergenItem.fromJson(Map<String, dynamic> json) {
    return AllergenItem(
      label: json['label'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'count': count,
    };
  }
}
