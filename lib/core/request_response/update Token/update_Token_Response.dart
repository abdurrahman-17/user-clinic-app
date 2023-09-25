// To parse this JSON data, do
//
//     final updateToken = updateTokenFromJson(jsonString);

import 'dart:convert';

UpdateToken updateTokenFromJson(String str) => UpdateToken.fromJson(json.decode(str));

String updateTokenToJson(UpdateToken data) => json.encode(data.toJson());

class UpdateToken {
  UpdateToken({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Update_Token_Data? data;

  factory UpdateToken.fromJson(Map<String, dynamic> json) => UpdateToken(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Update_Token_Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Update_Token_Data {
  Update_Token_Data({
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
    this.pulseRate,
    this.spo2,
    this.temperature,
    this.bloodPressure,
    this.heartBeat,
    this.diabetes,
    this.consultation,
    this.prescription,
    this.feedback,
    this.status,
    this.parentId,
    this.doctorInfo,
  });

  int? id;
  int? patientId;
  int? doctorId;
  String? date;
  String? day;
  dynamic appointmentTime;
  int? tokenNo;
  String? patientName;
  String? description;
  int? age;
  int? type;
  String? gender;
  dynamic mobileNumber;
  dynamic height;
  dynamic weight;
  dynamic pulseRate;
  dynamic spo2;
  dynamic temperature;
  dynamic bloodPressure;
  dynamic heartBeat;
  dynamic diabetes;
  int? consultation;
  dynamic prescription;
  dynamic feedback;
  int? status;
  int? parentId;
  DoctorInfo? doctorInfo;

  factory Update_Token_Data.fromJson(Map<String, dynamic> json) => Update_Token_Data(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : json["date"],
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"],
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"],
    height: json["height"],
    weight: json["weight"],
    pulseRate: json["pulse_rate"],
    spo2: json["spo2"],
    temperature: json["temperature"],
    bloodPressure: json["blood_pressure"],
    heartBeat: json["heart_beat"],
    diabetes: json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"],
    feedback: json["feedback"],
    status: json["status"] == null ? null : json["status"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    doctorInfo: json["doctor_info"] == null ? null : DoctorInfo.fromJson(json["doctor_info"]),
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
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber,
    "height": height,
    "weight": weight,
    "pulse_rate": pulseRate,
    "spo2": spo2,
    "temperature": temperature,
    "blood_pressure": bloodPressure,
    "heart_beat": heartBeat,
    "diabetes": diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription,
    "feedback": feedback,
    "status": status == null ? null : status,
    "parent_id": parentId == null ? null : parentId,
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
  String? image;
  String? specialist;
  String? clinicAddress;

  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "specialist": specialist == null ? null : specialist,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
  };
}
