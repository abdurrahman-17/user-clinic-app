// To parse this JSON data, do
//
//     final addFamilyMember = addFamilyMemberFromJson(jsonString);

import 'dart:convert';

AddFamilyMember addFamilyMemberFromJson(String str) => AddFamilyMember.fromJson(json.decode(str));

String addFamilyMemberToJson(AddFamilyMember data) => json.encode(data.toJson());

class AddFamilyMember {
  AddFamilyMember({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddFamilyMember.fromJson(Map<String, dynamic> json) => AddFamilyMember(
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
    this.name,
    this.androidToken,
    this.age,
    this.gender,
    this.issue,
    this.parent,
    this.id,
  });

  String? name;
  dynamic androidToken;
  String? age;
  String? gender;
  dynamic issue;
  String? parent;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    androidToken: json["android_token"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    issue: json["issue"],
    parent: json["parent"] == null ? null : json["parent"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "android_token": androidToken,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "issue": issue,
    "parent": parent == null ? null : parent,
    "id": id == null ? null : id,
  };
}
