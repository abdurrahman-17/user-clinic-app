// To parse this JSON data, do
//
//     final emailOtp = emailOtpFromJson(jsonString);

import 'dart:convert';

EmailOtp emailOtpFromJson(String str) => EmailOtp.fromJson(json.decode(str));

String emailOtpToJson(EmailOtp data) => json.encode(data.toJson());

class EmailOtp {
  EmailOtp({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory EmailOtp.fromJson(Map<String, dynamic> json) => EmailOtp(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
