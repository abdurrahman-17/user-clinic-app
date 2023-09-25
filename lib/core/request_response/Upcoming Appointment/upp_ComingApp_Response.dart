// To parse this JSON data, do
//
//     final upcomingAppointment = upcomingAppointmentFromJson(jsonString);

import 'dart:convert';

UpcomingAppointment upcomingAppointmentFromJson(String str) => UpcomingAppointment.fromJson(json.decode(str));

String upcomingAppointmentToJson(UpcomingAppointment data) => json.encode(data.toJson());

class UpcomingAppointment {
  UpcomingAppointment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<uppcoming_App_Data>? data;

  factory UpcomingAppointment.fromJson(Map<String, dynamic> json) => UpcomingAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<uppcoming_App_Data>.from(json["data"].map((x) => uppcoming_App_Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class uppcoming_App_Data {
  uppcoming_App_Data({
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
    this.newAppoinmentTime,
    this.doctor,
    this.specialist,
    this.clinicAddress,
    this.phone,
  });

  int? id;
  int? patientId;
  int? doctorId;
  DateTime? date;
  String? day;
  dynamic appointmentTime;
  int? tokenNo;
  String? patientName;
  String? description;
  int? age;
  int? type;
  String? gender;
  dynamic mobileNumber;
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
  dynamic parentId;
  String? newAppoinmentTime;
  String? doctor;
  String? specialist;
  String? clinicAddress;
  String? phone;

  factory uppcoming_App_Data.fromJson(Map<String, dynamic> json) => uppcoming_App_Data(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"],
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"],
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
    parentId: json["parent_id"],
    newAppoinmentTime: json["new_appoinment_time"] == null ? null : json["new_appoinment_time"],
    doctor: json["doctor"] == null ? null : json["doctor"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime,
    "token_no": tokenNo == null ? null : tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber,
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
    "parent_id": parentId,
    "new_appoinment_time": newAppoinmentTime == null ? null : newAppoinmentTime,
    "doctor": doctor == null ? null : doctor,
    "specialist": specialist == null ? null : specialist,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
    "phone": phone == null ? null : phone,
  };
}


// // To parse this JSON data, do
// //
// //     final upcomingAppointment = upcomingAppointmentFromJson(jsonString);
//
// import 'dart:convert';
//
// UpcomingAppointment upcomingAppointmentFromJson(String str) => UpcomingAppointment.fromJson(json.decode(str));
//
// String upcomingAppointmentToJson(UpcomingAppointment data) => json.encode(data.toJson());
//
// class UpcomingAppointment {
//   UpcomingAppointment({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   List<uppcoming_App_Data>? data;
//
//   factory UpcomingAppointment.fromJson(Map<String, dynamic> json) => UpcomingAppointment(
//     status: json["status"] == null ? null : json["status"],
//     message: json["message"] == null ? null : json["message"],
//     data: json["data"] == null ? null : List<uppcoming_App_Data>.from(json["data"].map((x) => uppcoming_App_Data.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status == null ? null : status,
//     "message": message == null ? null : message,
//     "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class uppcoming_App_Data {
//   uppcoming_App_Data({
//     this.id,
//     this.patientId,
//     this.doctorId,
//     this.date,
//     this.day,
//     this.appointmentTime,
//     this.tokenNo,
//     this.patientName,
//     this.description,
//     this.age,
//     this.type,
//     this.gender,
//     this.mobileNumber,
//     this.height,
//     this.weight,
//     this.temperature,
//     this.bloodPressure,
//     this.heartBeat,
//     this.diabetes,
//     this.consultation,
//     this.prescription,
//     this.status,
//     this.clinicAddress,
//     this.doctor,
//     this.specialist,
//     this.phone,
//     this.newAppoinmentTime,
//
//   });
//
//   int? id;
//   int? patientId;
//   int? doctorId;
//   DateTime? date;
//   String? day;
//   String? appointmentTime;
//   int? tokenNo;
//   String? patientName;
//   String? description;
//   int? age;
//   int? type;
//   String? gender;
//   int? mobileNumber;
//   int? height;
//   int? weight;
//   int? temperature;
//   int? bloodPressure;
//   int? heartBeat;
//   int? diabetes;
//   int? consultation;
//   String? prescription;
//   int? status;
//   String? clinicAddress;
//   String? doctor;
//   String? doctorName;
//   String? specialist;
//   String? phone;
//   String? newAppoinmentTime;
//
//   factory uppcoming_App_Data.fromJson(Map<String, dynamic> json) => uppcoming_App_Data(
//     id: json["id"] == null ? null : json["id"],
//     patientId: json["patient_id"] == null ? null : json["patient_id"],
//     doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
//     date: json["date"] == null ? null : DateTime.parse(json["date"]),
//     day: json["day"] == null ? null : json["day"],
//     appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
//     tokenNo: json["token_no"] == null ? null : json["token_no"],
//     patientName: json["patient_name"] == null ? null : json["patient_name"],
//     description: json["description"] == null ? null : json["description"],
//     age: json["age"] == null ? null : json["age"],
//     type: json["type"] == null ? null : json["type"],
//     gender: json["gender"] == null ? null : json["gender"],
//     mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
//     height: json["height"] == null ? null : json["height"],
//     weight: json["weight"] == null ? null : json["weight"],
//     temperature: json["temperature"] == null ? null : json["temperature"],
//     bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
//     heartBeat: json["heart_beat"] == null ? null : json["heart_beat"],
//     diabetes: json["diabetes"] == null ? null : json["diabetes"],
//     consultation: json["consultation"] == null ? null : json["consultation"],
//     prescription: json["prescription"] == null ? null : json["prescription"],
//     status: json["status"] == null ? null : json["status"],
//     clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
//     doctor: json["doctor"] == null ? null : json["doctor"],
//     specialist: json["specialist"] == null ? null : json["specialist"],
//     phone: json["phone"] == null ? null : json["phone"],
//     newAppoinmentTime: json["new_appoinment_time"] == null ? null : json["new_appoinment_time"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "patient_id": patientId == null ? null : patientId,
//     "doctor_id": doctorId == null ? null : doctorId,
//     "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//     "day": day == null ? null : day,
//     "appointment_time": appointmentTime == null ? null : appointmentTime,
//     "token_no": tokenNo == null ? null : tokenNo,
//     "patient_name": patientName == null ? null : patientName,
//     "description": description == null ? null : description,
//     "age": age == null ? null : age,
//     "type": type == null ? null : type,
//     "gender": gender == null ? null : gender,
//     "mobile_number": mobileNumber == null ? null : mobileNumber,
//     "height": height == null ? null : height,
//     "weight": weight == null ? null : weight,
//     "temperature": temperature == null ? null : temperature,
//     "blood_pressure": bloodPressure == null ? null : bloodPressure,
//     "heart_beat": heartBeat == null ? null : heartBeat,
//     "diabetes": diabetes == null ? null : diabetes,
//     "consultation": consultation == null ? null : consultation,
//     "prescription": prescription == null ? null : prescription,
//     "status": status == null ? null : status,
//     "clinic_address": clinicAddress == null ? null : clinicAddress,
//     "doctor": doctor == null ? null : doctor,
//     "specialist": specialist == null ? null : specialist,
//     "phone": phone == null ? null : phone,
//     "new_appoinment_time": newAppoinmentTime == null ? null : newAppoinmentTime,
//   };
// }
