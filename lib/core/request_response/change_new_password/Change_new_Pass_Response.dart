// To parse this JSON data, do
//
//     final changeNewPasswrod = changeNewPasswrodFromJson(jsonString);

import 'dart:convert';

ChangeNewPasswrod changeNewPasswrodFromJson(String str) => ChangeNewPasswrod.fromJson(json.decode(str));

String changeNewPasswrodToJson(ChangeNewPasswrod data) => json.encode(data.toJson());

class ChangeNewPasswrod {
  ChangeNewPasswrod({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ChangeNewPasswrod.fromJson(Map<String, dynamic> json) => ChangeNewPasswrod(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
