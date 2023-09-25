// To parse this JSON data, do
//
//     final getReportFilter = getReportFilterFromJson(jsonString);

import 'dart:convert';

GetReportFilter getReportFilterFromJson(String str) => GetReportFilter.fromJson(json.decode(str));

String getReportFilterToJson(GetReportFilter data) => json.encode(data.toJson());

class GetReportFilter {
  GetReportFilter({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<get_Report_Filter_class>? data;

  factory GetReportFilter.fromJson(Map<String, dynamic> json) => GetReportFilter(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<get_Report_Filter_class>.from(json["data"].map((x) => get_Report_Filter_class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class get_Report_Filter_class {
  get_Report_Filter_class({
    this.appointmentId,
    this.bookedDate,
    this.bokedTime,
    this.doctorName,
    this.patientName,
    this.address,
    this.prescription,
    this.description,
    this.healthIssue,
  });

  int? appointmentId;
  DateTime? bookedDate;
  String? bokedTime;
  String? doctorName;
  String? patientName;
  String? address;
  String? prescription;
  String? description;
  String? healthIssue;

  factory get_Report_Filter_class.fromJson(Map<String, dynamic> json) => get_Report_Filter_class(
    appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
    bookedDate: json["booked_date"] == null ? null : DateTime.parse(json["booked_date"]),
    bokedTime: json["boked_time"] == null ? null : json["boked_time"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    address: json["address"] == null ? null : json["address"],
    prescription: json["prescription"] == null ? null : json["prescription"],
    description: json["description"] == null ? null : json["description"],
    healthIssue: json["health_issue"] == null ? null : json["health_issue"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId == null ? null : appointmentId,
    "booked_date": bookedDate == null ? null : "${bookedDate!.year.toString().padLeft(4, '0')}-${bookedDate!.month.toString().padLeft(2, '0')}-${bookedDate!.day.toString().padLeft(2, '0')}",
    "boked_time": bokedTime == null ? null : bokedTime,
    "doctor_name": doctorName == null ? null : doctorName,
    "patient_name": patientName == null ? null : patientName,
    "address": address == null ? null : address,
    "prescription": prescription == null ? null : prescription,
    "description": description == null ? null : description,
    "health_issue": healthIssue == null ? null : healthIssue,
  };
}
