// To parse this JSON data, do
//
//     final passwordChange = passwordChangeFromJson(jsonString);

import 'dart:convert';

PasswordChange passwordChangeFromJson(String str) => PasswordChange.fromJson(json.decode(str));

String passwordChangeToJson(PasswordChange data) => json.encode(data.toJson());

class PasswordChange {
  PasswordChange({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory PasswordChange.fromJson(Map<String, dynamic> json) => PasswordChange(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
