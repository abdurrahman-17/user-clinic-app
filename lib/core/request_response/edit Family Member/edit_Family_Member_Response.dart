// To parse this JSON data, do
//
//     final editFamilyMember = editFamilyMemberFromJson(jsonString);

import 'dart:convert';

EditFamilyMember editFamilyMemberFromJson(String str) => EditFamilyMember.fromJson(json.decode(str));

String editFamilyMemberToJson(EditFamilyMember data) => json.encode(data.toJson());

class EditFamilyMember {
  EditFamilyMember({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory EditFamilyMember.fromJson(Map<String, dynamic> json) => EditFamilyMember(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.name,
    this.image,
    this.gender,
    this.age,
    this.parent,
    this.apiToken,
    this.notificationStatus,
    this.deviceType,
    this.androidToken,
    this.iosToken,
    this.status,
  });

  int? id;
  dynamic email;
  String? name;
  String? image;
  String? gender;
  String? age;
  int? parent;
  dynamic apiToken;
  int? notificationStatus;
  dynamic deviceType;
  dynamic androidToken;
  dynamic iosToken;
  int? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    email: json["email"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    parent: json["parent"] == null ? null : json["parent"],
    apiToken: json["api_token"],
    notificationStatus: json["notification_status"] == null ? null : json["notification_status"],
    deviceType: json["device_type"],
    androidToken: json["android_token"],
    iosToken: json["ios_token"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "parent": parent == null ? null : parent,
    "api_token": apiToken,
    "notification_status": notificationStatus == null ? null : notificationStatus,
    "device_type": deviceType,
    "android_token": androidToken,
    "ios_token": iosToken,
    "status": status == null ? null : status,
  };
}
