// To parse this JSON data, do
//
//     final cancelAppointment = cancelAppointmentFromJson(jsonString);

import 'dart:convert';

CancelAppointment cancelAppointmentFromJson(String str) => CancelAppointment.fromJson(json.decode(str));

String cancelAppointmentToJson(CancelAppointment data) => json.encode(data.toJson());

class CancelAppointment {
  CancelAppointment({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory CancelAppointment.fromJson(Map<String, dynamic> json) => CancelAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
