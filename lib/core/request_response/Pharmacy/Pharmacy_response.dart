// To parse this JSON data, do
//
//     final pharmacyResponse = pharmacyResponseFromJson(jsonString);

import 'dart:convert';

PharmacyResponse pharmacyResponseFromJson(String str) => PharmacyResponse.fromJson(json.decode(str));

String pharmacyResponseToJson(PharmacyResponse data) => json.encode(data.toJson());

class PharmacyResponse {
  PharmacyResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Pharmacy_class>? data;

  factory PharmacyResponse.fromJson(Map<String, dynamic> json) => PharmacyResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Pharmacy_class>.from(json["data"].map((x) => Pharmacy_class.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Pharmacy_class {
  Pharmacy_class({
    this.id,
    this.patientId,
    this.patientName,
    this.doctorId,
    this.clinicAddress,
    this.doctorName,
    this.specialist,
    this.phone,
    this.date,
    this.day,
    this.appointmentTime,
    this.tokenNo,
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
    this.status,
    this.feedback,
    this.parentId,
  });

  int? id;
  int? patientId;
  String? patientName;
  int? doctorId;
  String? clinicAddress;
  String? doctorName;
  String? specialist;
  String? phone;
  DateTime? date;
  String? day;
  String? appointmentTime;
  dynamic tokenNo;
  String? description;
  int? age;
  int? type;
  String? gender;
  dynamic mobileNumber;
  int? height;
  int? weight;
  String? pulseRate;
  String? spo2;
  int? temperature;
  int? bloodPressure;
  dynamic heartBeat;
  int? diabetes;
  int? consultation;
  List<String>? prescription;
  int? status;
  String? feedback;
  int? parentId;

  factory Pharmacy_class.fromJson(Map<String, dynamic> json) => Pharmacy_class(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    phone: json["phone"] == null ? null : json["phone"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    tokenNo: json["token_no"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"],
    height: json["height"] == null ? null : json["height"],
    weight: json["weight"] == null ? null : json["weight"],
    pulseRate: json["pulse_rate"] == null ? null : json["pulse_rate"],
    spo2: json["spo2"] == null ? null : json["spo2"],
    temperature: json["temperature"] == null ? null : json["temperature"],
    bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
    heartBeat: json["heart_beat"],
    diabetes: json["diabetes"] == null ? null : json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"] == null ? null : List<String>.from(json["prescription"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    feedback: json["feedback"] == null ? null : json["feedback"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "patient_name": patientName == null ? null : patientName,
    "doctor_id": doctorId == null ? null : doctorId,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
    "doctor_name": doctorName == null ? null : doctorName,
    "specialist": specialist == null ? null : specialist,
    "phone": phone == null ? null : phone,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "token_no": tokenNo,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "pulse_rate": pulseRate == null ? null : pulseRate,
    "spo2": spo2 == null ? null : spo2,
    "temperature": temperature == null ? null : temperature,
    "blood_pressure": bloodPressure == null ? null : bloodPressure,
    "heart_beat": heartBeat,
    "diabetes": diabetes == null ? null : diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription == null ? null : List<dynamic>.from(prescription!.map((x) => x)),
    "status": status == null ? null : status,
    "feedback": feedback == null ? null : feedback,
    "parent_id": parentId == null ? null : parentId,
  };
}

// // To parse this JSON data, do
// //
// //     final pharmacyResponse = pharmacyResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// PharmacyResponse pharmacyResponseFromJson(String str) => PharmacyResponse.fromJson(json.decode(str));
//
// String pharmacyResponseToJson(PharmacyResponse data) => json.encode(data.toJson());
//
// class PharmacyResponse {
//   PharmacyResponse({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   List<Pharmacy_class>? data;
//
//   factory PharmacyResponse.fromJson(Map<String, dynamic> json) => PharmacyResponse(
//     status: json["status"] == null ? null : json["status"],
//     message: json["message"] == null ? null : json["message"],
//     data: json["data"] == null ? null : List<Pharmacy_class>.from(json["data"].map((x) => Pharmacy_class.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status == null ? null : status,
//     "message": message == null ? null : message,
//     "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Pharmacy_class {
//   Pharmacy_class({
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
//     this.pulseRate,
//     this.spo2,
//     this.temperature,
//     this.bloodPressure,
//     this.heartBeat,
//     this.diabetes,
//     this.consultation,
//     this.prescription,
//     this.feedback,
//     this.status,
//     this.parentId,
//     this.clinicAddress,
//     this.doctorName,
//     this.specialist,
//     this.phone,
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
//   dynamic height;
//   dynamic weight;
//   String? pulseRate;
//   String? spo2;
//   int? temperature;
//   int? bloodPressure;
//   int? heartBeat;
//   int? diabetes;
//   int? consultation;
//   String? prescription;
//   String? feedback;
//   int? status;
//   int? parentId;
//   String? clinicAddress;
//   String? doctorName;
//   String? specialist;
//   String? phone;
//
//   factory Pharmacy_class.fromJson(Map<String, dynamic> json) => Pharmacy_class(
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
//     height: json["height"],
//     weight: json["weight"],
//     pulseRate: json["pulse_rate"] == null ? null : json["pulse_rate"],
//     spo2: json["spo2"] == null ? null : json["spo2"],
//     temperature: json["temperature"] == null ? null : json["temperature"],
//     bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
//     heartBeat: json["heart_beat"] == null ? null : json["heart_beat"],
//     diabetes: json["diabetes"] == null ? null : json["diabetes"],
//     consultation: json["consultation"] == null ? null : json["consultation"],
//     prescription: json["prescription"] == null ? null : json["prescription"],
//     feedback: json["feedback"] == null ? null : json["feedback"],
//     status: json["status"] == null ? null : json["status"],
//     parentId: json["parent_id"] == null ? null : json["parent_id"],
//     clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
//     doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
//     specialist: json["specialist"] == null ? null : json["specialist"],
//     phone: json["phone"] == null ? null : json["phone"],
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
//     "height": height,
//     "weight": weight,
//     "pulse_rate": pulseRate == null ? null : pulseRate,
//     "spo2": spo2 == null ? null : spo2,
//     "temperature": temperature == null ? null : temperature,
//     "blood_pressure": bloodPressure == null ? null : bloodPressure,
//     "heart_beat": heartBeat == null ? null : heartBeat,
//     "diabetes": diabetes == null ? null : diabetes,
//     "consultation": consultation == null ? null : consultation,
//     "prescription": prescription == null ? null : prescription,
//     "feedback": feedback == null ? null : feedback,
//     "status": status == null ? null : status,
//     "parent_id": parentId == null ? null : parentId,
//     "clinic_address": clinicAddress == null ? null : clinicAddress,
//     "doctor_name": doctorName == null ? null : doctorName,
//     "specialist": specialist == null ? null : specialist,
//     "phone": phone == null ? null : phone,
//   };
// }
//
//
// // // To parse this JSON data, do
// // //
// // //     final pharmacy = pharmacyFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // PharmacyResponse pharmacyFromJson(String str) => PharmacyResponse.fromJson(json.decode(str));
// //
// // String pharmacyToJson(PharmacyResponse data) => json.encode(data.toJson());
// //
// // class PharmacyResponse {
// //   PharmacyResponse({
// //     this.status,
// //     this.message,
// //     this.data,
// //   });
// //
// //   bool? status;
// //   String? message;
// //   List<Pharmacy_class>? data;
// //
// //   factory PharmacyResponse.fromJson(Map<String, dynamic> json) => PharmacyResponse(
// //     status: json["status"] == null ? null : json["status"],
// //     message: json["message"] == null ? null : json["message"],
// //     data: json["data"] == null ? null : List<Pharmacy_class>.from(json["data"].map((x) => Pharmacy_class.fromJson(x))),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "status": status == null ? null : status,
// //     "message": message == null ? null : message,
// //     "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
// //   };
// // }
// //
// // class Pharmacy_class {
// //   Pharmacy_class({
// //     this.id,
// //     this.patientId,
// //     this.doctorId,
// //     this.date,
// //     this.day,
// //     this.appointmentTime,
// //     this.tokenNo,
// //     this.patientName,
// //     this.description,
// //     this.age,
// //     this.type,
// //     this.gender,
// //     this.mobileNumber,
// //     this.height,
// //     this.weight,
// //     this.temperature,
// //     this.bloodPressure,
// //     this.heartBeat,
// //     this.diabetes,
// //     this.consultation,
// //     this.status,
// //     this.clinicAddress,
// //     this.doctorName,
// //     this.specialist,
// //     this.phone,
// //   });
// //
// //   int? id;
// //   int? patientId;
// //   int? doctorId;
// //   DateTime? date;
// //   String? day;
// //   String? appointmentTime;
// //   dynamic tokenNo;
// //   String? patientName;
// //   dynamic description;
// //   int? age;
// //   int? type;
// //   String? gender;
// //   int? mobileNumber;
// //   double? height;
// //   int? weight;
// //   double? temperature;
// //   int? bloodPressure;
// //   dynamic heartBeat;
// //   dynamic diabetes;
// //   int? consultation;
// //   int? status;
// //   String? clinicAddress;
// //   String? doctorName;
// //   String? specialist;
// //   String? phone;
// //
// //   factory Pharmacy_class.fromJson(Map<String, dynamic> json) => Pharmacy_class(
// //     id: json["id"] == null ? null : json["id"],
// //     patientId: json["patient_id"] == null ? null : json["patient_id"],
// //     doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
// //     date: json["date"] == null ? null : DateTime.parse(json["date"]),
// //     day: json["day"] == null ? null : json["day"],
// //     appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
// //     tokenNo: json["token_no"],
// //     patientName: json["patient_name"] == null ? null : json["patient_name"],
// //     description: json["description"],
// //     age: json["age"] == null ? null : json["age"],
// //     type: json["type"] == null ? null : json["type"],
// //     gender: json["gender"] == null ? null : json["gender"],
// //     mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
// //     height: json["height"] == null ? null : json["height"].toDouble(),
// //     weight: json["weight"] == null ? null : json["weight"],
// //     temperature: json["temperature"] == null ? null : json["temperature"].toDouble(),
// //     bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
// //     heartBeat: json["heart_beat"],
// //     diabetes: json["diabetes"],
// //     consultation: json["consultation"] == null ? null : json["consultation"],
// //     status: json["status"] == null ? null : json["status"],
// //     clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
// //     doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
// //     specialist: json["specialist"] == null ? null : json["specialist"],
// //     phone: json["phone"] == null ? null : json["phone"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id == null ? null : id,
// //     "patient_id": patientId == null ? null : patientId,
// //     "doctor_id": doctorId == null ? null : doctorId,
// //     "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
// //     "day": day == null ? null : day,
// //     "appointment_time": appointmentTime == null ? null : appointmentTime,
// //     "token_no": tokenNo,
// //     "patient_name": patientName == null ? null : patientName,
// //     "description": description,
// //     "age": age == null ? null : age,
// //     "type": type == null ? null : type,
// //     "gender": gender == null ? null : gender,
// //     "mobile_number": mobileNumber == null ? null : mobileNumber,
// //     "height": height == null ? null : height,
// //     "weight": weight == null ? null : weight,
// //     "temperature": temperature == null ? null : temperature,
// //     "blood_pressure": bloodPressure == null ? null : bloodPressure,
// //     "heart_beat": heartBeat,
// //     "diabetes": diabetes,
// //     "consultation": consultation == null ? null : consultation,
// //     "status": status == null ? null : status,
// //     "clinic_address": clinicAddress == null ? null : clinicAddress,
// //     "doctor_name": doctorName == null ? null : doctorName,
// //     "specialist": specialist == null ? null : specialist,
// //     "phone": phone == null ? null : phone,
// //   };
// // }
