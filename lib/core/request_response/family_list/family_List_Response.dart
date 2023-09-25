// To parse this JSON data, do
//
//     final familyFilter = familyFilterFromJson(jsonString);

import 'dart:convert';

FamilyFilter familyFilterFromJson(String str) => FamilyFilter.fromJson(json.decode(str));

String familyFilterToJson(FamilyFilter data) => json.encode(data.toJson());

class FamilyFilter {
  FamilyFilter({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Family_list>? data;

  factory FamilyFilter.fromJson(Map<String, dynamic> json) => FamilyFilter(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Family_list>.from(json["data"].map((x) => Family_list.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Family_list {
  Family_list({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Family_list.fromJson(Map<String, dynamic> json) => Family_list(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
