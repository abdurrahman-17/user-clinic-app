// To parse this JSON data, do
//
//     final mobileUpdate = mobileUpdateFromJson(jsonString);

import 'dart:convert';

MobileUpdate mobileUpdateFromJson(String str) => MobileUpdate.fromJson(json.decode(str));

String mobileUpdateToJson(MobileUpdate data) => json.encode(data.toJson());

class MobileUpdate {
  MobileUpdate({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory MobileUpdate.fromJson(Map<String, dynamic> json) => MobileUpdate(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
