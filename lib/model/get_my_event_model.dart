class GetMyEventModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final EventPaginationData? data;

  GetMyEventModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetMyEventModel.fromJson(Map<String, dynamic> json) {
    return GetMyEventModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? EventPaginationData.fromJson(json['data'])
          : null,
    );
  }
}

class EventPaginationData {
  final List<EventData>? data;
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  EventPaginationData({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory EventPaginationData.fromJson(Map<String, dynamic> json) {
    return EventPaginationData(
      data: json['data'] != null
          ? List<EventData>.from(
          json['data'].map((x) => EventData.fromJson(x)))
          : [],
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class EventData {
  final String? id;
  final String? image;
  final String? eventName;
  final DateTime? eventTime;
  final String? eventType;
  final String? invitationMessage;
  final String? parkingDetails;
  final String? addNote;
  final bool? reminderNotification;
  final LocationModel? location;
  final List<MenuModel>? menus;
  final HostModel? host;
  final bool? reminderSent;
  final bool? isDeleted;
  final bool? isCompleted;
  final bool? isCancelled;
  final bool? displayMenu;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventData({
    this.id,
    this.image,
    this.eventName,
    this.eventTime,
    this.eventType,
    this.invitationMessage,
    this.parkingDetails,
    this.addNote,
    this.reminderNotification,
    this.location,
    this.menus,
    this.host,
    this.reminderSent,
    this.isDeleted,
    this.isCompleted,
    this.isCancelled,
    this.displayMenu,
    this.createdAt,
    this.updatedAt,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['_id'],
      image: json['image'],
      eventName: json['eventName'],
      eventTime: json['eventTime'] != null
          ? DateTime.parse(json['eventTime'])
          : null,
      eventType: json['eventType'],
      invitationMessage: json['invitationMessage'],
      parkingDetails: json['parkingDetails'],
      addNote: json['addNote'],
      reminderNotification: json['reminderNotification'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      menus: json['menus'] != null
          ? List<MenuModel>.from(
          json['menus'].map((x) => MenuModel.fromJson(x)))
          : [],
      host: json['host'] != null
          ? HostModel.fromJson(json['host'])
          : null,
      reminderSent: json['reminderSent'],
      isDeleted: json['isDeleted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      displayMenu: json['displayMenu'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

class LocationModel {
  final String? type;
  final List<double>? coordinates;

  LocationModel({
    this.type,
    this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(
          json['coordinates'].map((x) => x.toDouble()))
          : [],
    );
  }
}

class MenuModel {
  final String? id;
  final String? type;
  final List<String>? mealCategory;
  final String? menuImage;
  final String? title;
  final String? description;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MenuModel({
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

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['_id'],
      type: json['type'],
      mealCategory: json['mealCategory'] != null
          ? List<String>.from(json['mealCategory'])
          : [],
      menuImage: json['menuImage'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

class HostModel {
  final String? id;
  final String? email;
  final String? name;
  final String? username;
  final String? profilePic;
  final bool? profileCompleted;

  HostModel({
    this.id,
    this.email,
    this.name,
    this.username,
    this.profilePic,
    this.profileCompleted,
  });

  factory HostModel.fromJson(Map<String, dynamic> json) {
    return HostModel(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profilePic: json['profilePic'],
      profileCompleted: json['profileCompleted'],
    );
  }
}