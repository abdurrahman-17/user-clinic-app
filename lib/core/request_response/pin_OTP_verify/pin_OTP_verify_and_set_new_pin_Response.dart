// To parse this JSON data, do
//
//     final pinOtpVerify = pinOtpVerifyFromJson(jsonString);

import 'dart:convert';

PinOtpVerify pinOtpVerifyFromJson(String str) => PinOtpVerify.fromJson(json.decode(str));

String pinOtpVerifyToJson(PinOtpVerify data) => json.encode(data.toJson());

class PinOtpVerify {
  PinOtpVerify({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<pin_OTP_data>? data;

  factory PinOtpVerify.fromJson(Map<String, dynamic> json) => PinOtpVerify(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<pin_OTP_data>.from(json["data"].map((x) => pin_OTP_data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class pin_OTP_data {
  pin_OTP_data({
    this.pinAuthentication,
    this.email,
  });

  String? pinAuthentication;
  String? email;

  factory pin_OTP_data.fromJson(Map<String, dynamic> json) => pin_OTP_data(
    pinAuthentication: json["pin_authentication"] == null ? null : json["pin_authentication"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "pin_authentication": pinAuthentication == null ? null : pinAuthentication,
    "email": email == null ? null : email,
  };
}
