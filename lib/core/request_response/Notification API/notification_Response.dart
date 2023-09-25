// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    this.status,
    this.message,
    this.notificationCount,
    this.data,
    this.yearlier,
  });

  bool? status;
  String? message;
  int? notificationCount;
  List<Notification_Response_Data>? data;
  List<Notification_Response_Data>? yearlier;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    notificationCount: json["notification_count"] == null ? null : json["notification_count"],
    data: json["data"] == null ? null : List<Notification_Response_Data>.from(json["data"].map((x) => Notification_Response_Data.fromJson(x))),
    yearlier: json["yearlier"] == null ? null : List<Notification_Response_Data>.from(json["yearlier"].map((x) => Notification_Response_Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "notification_count": notificationCount == null ? null : notificationCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "yearlier": yearlier == null ? null : List<dynamic>.from(yearlier!.map((x) => x.toJson())),
  };
}

class Notification_Response_Data {
  Notification_Response_Data({
    this.id,
    this.userId,
    this.doctorId,
    this.appType,
    this.notificationType,
    this.appointmentId,
    this.title,
    this.body,
    this.image,
    this.date,
    this.readStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? doctorId;
  String? appType;
  String? notificationType;
  int? appointmentId;
  String? title;
  String? body;
  String? image;
  DateTime? date;
  int? readStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Notification_Response_Data.fromJson(Map<String, dynamic> json) => Notification_Response_Data(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    appType: json["app_type"] == null ? null : json["app_type"],
    notificationType: json["notification_type"] == null ? null : json["notification_type"],
    appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    image: json["image"] == null ? null : json["image"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    readStatus: json["read_status"] == null ? null : json["read_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "doctor_id": doctorId == null ? null : doctorId,
    "app_type": appType == null ? null : appType,
    "notification_type": notificationType == null ? null : notificationType,
    "appointment_id": appointmentId == null ? null : appointmentId,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "image": image == null ? null : image,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "read_status": readStatus == null ? null : readStatus,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
