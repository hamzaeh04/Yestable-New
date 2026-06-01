class GetAllNotificationsModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final NotificationPaginationData? data;

  GetAllNotificationsModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationPaginationData.fromJson(json['data'])
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

class NotificationPaginationData {
  final List<NotificationItem>? data;
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  NotificationPaginationData({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory NotificationPaginationData.fromJson(Map<String, dynamic> json) {
    return NotificationPaginationData(
      data: json['data'] != null
          ? List<NotificationItem>.from(
        json['data'].map((x) => NotificationItem.fromJson(x)),
      )
          : [],
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}

class NotificationItem {
  final String? id;
  final String? user;
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final String? imageUrl;
  final bool? isRead;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  NotificationItem({
    this.id,
    this.user,
    this.title,
    this.body,
    this.data,
    this.imageUrl,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'],
      user: json['user'],
      title: json['title'],
      body: json['body'],
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'title': title,
      'body': body,
      'data': data,
      'imageUrl': imageUrl,
      'isRead': isRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}