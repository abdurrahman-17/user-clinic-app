// To parse this JSON data, do
//
//     final addTokenAppointment = addTokenAppointmentFromJson(jsonString);

import 'dart:convert';

AddTokenAppointment addTokenAppointmentFromJson(String str) => AddTokenAppointment.fromJson(json.decode(str));

String addTokenAppointmentToJson(AddTokenAppointment data) => json.encode(data.toJson());

class AddTokenAppointment {
  AddTokenAppointment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddTokenAppointment.fromJson(Map<String, dynamic> json) => AddTokenAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.patientId,
    this.doctorId,
    this.date,
    this.day,
    this.tokenNo,
    this.patientName,
    this.age,
    this.type,
    this.gender,
    this.id,
    this.doctorInfo,
  });

  String? patientId;
  String? doctorId;
  DateTime? date;
  String? day;
  String? tokenNo;
  String? patientName;
  dynamic age;
  String? type;
  dynamic gender;
  int? id;
  DoctorInfo? doctorInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    age: json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"],
    id: json["id"] == null ? null : json["id"],
    doctorInfo: json["doctor_info"] == null ? null : DoctorInfo.fromJson(json["doctor_info"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "token_no": tokenNo == null ? null : tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "age": age,
    "type": type == null ? null : type,
    "gender": gender,
    "id": id == null ? null : id,
    "doctor_info": doctorInfo == null ? null : doctorInfo!.toJson(),
  };
}

class DoctorInfo {
  DoctorInfo({
    this.name,
    this.image,
    this.specialist,
    this.clinicAddress,
  });

  String? name;
  dynamic image;
  String? specialist;
  String? clinicAddress;

  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
    name: json["name"] == null ? null : json["name"],
    image: json["image"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "image": image,
    "specialist": specialist == null ? null : specialist,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
  };
}
