// To parse this JSON data, do
//
//     final otpVerify = otpVerifyFromJson(jsonString);

import 'dart:convert';

OtpVerify otpVerifyFromJson(String str) => OtpVerify.fromJson(json.decode(str));

String otpVerifyToJson(OtpVerify data) => json.encode(data.toJson());

class OtpVerify {
  OtpVerify({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory OtpVerify.fromJson(Map<String, dynamic> json) => OtpVerify(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
