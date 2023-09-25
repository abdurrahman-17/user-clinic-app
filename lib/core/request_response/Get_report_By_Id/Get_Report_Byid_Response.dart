// To parse this JSON data, do
//
//     final getReportById = getReportByIdFromJson(jsonString);

import 'dart:convert';

GetReportById getReportByIdFromJson(String str) => GetReportById.fromJson(json.decode(str));

String getReportByIdToJson(GetReportById data) => json.encode(data.toJson());

class GetReportById {
  GetReportById({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Get_Report_Id>? data;

  factory GetReportById.fromJson(Map<String, dynamic> json) => GetReportById(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Get_Report_Id>.from(json["data"].map((x) => Get_Report_Id.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Get_Report_Id {
  Get_Report_Id({
    this.appointmentId,
    this.date,
    this.prescription,
    this.description,
    this.doctorName,
    this.yourAppointmentOn,
  });

  int? appointmentId;
  DateTime? date;
  String? prescription;
  dynamic description;
  String? doctorName;
  String? yourAppointmentOn;

  factory Get_Report_Id.fromJson(Map<String, dynamic> json) => Get_Report_Id(
    appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    prescription: json["prescription"] == null ? null : json["prescription"],
    description: json["description"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    yourAppointmentOn: json["your appointment on"] == null ? null : json["your appointment on"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId == null ? null : appointmentId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "prescription": prescription == null ? null : prescription,
    "description": description,
    "doctor_name": doctorName == null ? null : doctorName,
    "your appointment on": yourAppointmentOn == null ? null : yourAppointmentOn,
  };
}
