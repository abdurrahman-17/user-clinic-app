// To parse this JSON data, do
//
//     final pinOtp = pinOtpFromJson(jsonString);

import 'dart:convert';

PinOtp pinOtpFromJson(String str) => PinOtp.fromJson(json.decode(str));

String pinOtpToJson(PinOtp data) => json.encode(data.toJson());

class PinOtp {
  PinOtp({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory PinOtp.fromJson(Map<String, dynamic> json) => PinOtp(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
