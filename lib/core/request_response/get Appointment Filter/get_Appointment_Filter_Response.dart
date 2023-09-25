// To parse this JSON data, do
//
//     final getAppointmentFilter = getAppointmentFilterFromJson(jsonString);

import 'dart:convert';

GetAppointmentFilter getAppointmentFilterFromJson(String str) => GetAppointmentFilter.fromJson(json.decode(str));

String getAppointmentFilterToJson(GetAppointmentFilter data) => json.encode(data.toJson());

class GetAppointmentFilter {
  GetAppointmentFilter({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<get_Appointment_Filter_class>? data;

  factory GetAppointmentFilter.fromJson(Map<String, dynamic> json) => GetAppointmentFilter(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<get_Appointment_Filter_class>.from(json["data"].map((x) => get_Appointment_Filter_class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class get_Appointment_Filter_class {
  get_Appointment_Filter_class({
    this.date,
    this.doctorName,
    this.specialist,
  });

  String? date;
  String? doctorName;
  String? specialist;

  factory get_Appointment_Filter_class.fromJson(Map<String, dynamic> json) => get_Appointment_Filter_class(
    date: json["date"] == null ? null :json["date"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    specialist: json["specialist"] == null ? null : json["specialist"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "doctor_name": doctorName == null ? null : doctorName,
    "specialist": specialist == null ? null : specialist,
  };
}
