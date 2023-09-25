// To parse this JSON data, do
//
//     final noOfAppointment = noOfAppointmentFromJson(jsonString);

import 'dart:convert';

NoOfAppointment noOfAppointmentFromJson(String str) => NoOfAppointment.fromJson(json.decode(str));

String noOfAppointmentToJson(NoOfAppointment data) => json.encode(data.toJson());

class NoOfAppointment {
  NoOfAppointment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<No_of_appo>? data;

  factory NoOfAppointment.fromJson(Map<String, dynamic> json) => NoOfAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<No_of_appo>.from(json["data"].map((x) => No_of_appo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class No_of_appo {
  No_of_appo({
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
    this.status,
    this.clinicAddress,
    this.doctorName,
    this.specialist,
    this.phone,
  });

  int? id;
  int? patientId;
  int? doctorId;
  String? date;
  String? day;
  dynamic appointmentTime;
  int? tokenNo;
  String? patientName;
  dynamic description;
  int? age;
  int? type;
  String? gender;
  int? mobileNumber;
  double? height;
  int? weight;
  double? temperature;
  int? bloodPressure;
  int? heartBeat;
  int? diabetes;
  int? consultation;
  int? status;
  String? clinicAddress;
  String? doctorName;
  String? specialist;
  String? phone;

  factory No_of_appo.fromJson(Map<String, dynamic> json) => No_of_appo(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : json["date"],
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"],
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    height: json["height"] == null ? null : json["height"].toDouble(),
    weight: json["weight"] == null ? null : json["weight"],
    temperature: json["temperature"] == null ? null : json["temperature"].toDouble(),
    bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
    heartBeat: json["heart_beat"] == null ? null : json["heart_beat"],
    diabetes: json["diabetes"] == null ? null : json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    status: json["status"] == null ? null : json["status"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : date,
    "day": day == null ? null : day,
    "appointment_time": appointmentTime,
    "token_no": tokenNo == null ? null : tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "description": description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "temperature": temperature == null ? null : temperature,
    "blood_pressure": bloodPressure == null ? null : bloodPressure,
    "heart_beat": heartBeat == null ? null : heartBeat,
    "diabetes": diabetes == null ? null : diabetes,
    "consultation": consultation == null ? null : consultation,
    "status": status == null ? null : status,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
    "doctor_name": doctorName == null ? null : doctorName,
    "specialist": specialist == null ? null : specialist,
    "phone": phone == null ? null : phone,
  };
}
