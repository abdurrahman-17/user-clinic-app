// To parse this JSON data, do
//
//     final pastAppointment = pastAppointmentFromJson(jsonString);

import 'dart:convert';

PastAppointment pastAppointmentFromJson(String str) => PastAppointment.fromJson(json.decode(str));

String pastAppointmentToJson(PastAppointment data) => json.encode(data.toJson());

class PastAppointment {
  PastAppointment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<past_App>? data;

  factory PastAppointment.fromJson(Map<String, dynamic> json) => PastAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<past_App>.from(json["data"].map((x) => past_App.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class past_App {
  past_App({
    this.id,
    this.patientId,
    this.doctorId,
    this.date,
    this.day,
    this.appointmentTime,
    this.tokenNo,
    this.patientName,
    this.description,
    this.age,
    this.type,
    this.gender,
    this.mobileNumber,
    this.height,
    this.weight,
    this.temperature,
    this.bloodPressure,
    this.heartBeat,
    this.diabetes,
    this.consultation,
    this.prescription,
    this.status,
    this.clinicAddress,
    this.doctorName,
    this.specialist,
    this.phone,
    this.newAppointmentTime,
  });

  int? id;
  int? patientId;
  int? doctorId;
  DateTime? date;
  String? day;
  String? appointmentTime;
  dynamic tokenNo;
  String? patientName;
  String? description;
  int? age;
  int? type;
  String? gender;
  String? mobileNumber;
  dynamic height;
  dynamic weight;
  dynamic temperature;
  dynamic bloodPressure;
  dynamic heartBeat;
  dynamic diabetes;
  int? consultation;
  String? prescription;
  int? status;
  String? clinicAddress;
  String? doctorName;
  String? specialist;
  String? phone;
  String? newAppointmentTime;

  factory past_App.fromJson(Map<String, dynamic> json) => past_App(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    tokenNo: json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    height: json["height"],
    weight: json["weight"],
    temperature: json["temperature"],
    bloodPressure: json["blood_pressure"],
    heartBeat: json["heart_beat"],
    diabetes: json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"] == null ? null : json["prescription"],
    status: json["status"] == null ? null : json["status"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    phone: json["phone"] == null ? null : json["phone"],
    newAppointmentTime: json["new_appointment_time"] == null ? null : json["new_appointment_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "token_no": tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "height": height,
    "weight": weight,
    "temperature": temperature,
    "blood_pressure": bloodPressure,
    "heart_beat": heartBeat,
    "diabetes": diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription == null ? null : prescription,
    "status": status == null ? null : status,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
    "doctor_name": doctorName == null ? null : doctorName,
    "specialist": specialist == null ? null : specialist,
    "phone": phone == null ? null : phone,
    "new_appointment_time": newAppointmentTime == null ? null : newAppointmentTime,
  };
}
