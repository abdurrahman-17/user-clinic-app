// To parse this JSON data, do
//
//     final emailChange = emailChangeFromJson(jsonString);

import 'dart:convert';

EmailChange emailChangeFromJson(String str) => EmailChange.fromJson(json.decode(str));

String emailChangeToJson(EmailChange data) => json.encode(data.toJson());

class EmailChange {
  EmailChange({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory EmailChange.fromJson(Map<String, dynamic> json) => EmailChange(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
