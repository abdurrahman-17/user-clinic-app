// To parse this JSON data, do
//
//     final addAppointment = addAppointmentFromJson(jsonString);

import 'dart:convert';

AddAppointment addAppointmentFromJson(String str) => AddAppointment.fromJson(json.decode(str));

String addAppointmentToJson(AddAppointment data) => json.encode(data.toJson());

class AddAppointment {
  AddAppointment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Add_Appointment_Data? data;

  factory AddAppointment.fromJson(Map<String, dynamic> json) => AddAppointment(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Add_Appointment_Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Add_Appointment_Data {
  Add_Appointment_Data({
    this.patientId,
    this.doctorId,
    this.date,
    this.day,
    this.appointmentTime,
    this.patientName,
    this.parentId,
    this.description,
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
  String? appointmentTime;
  String? patientName;
  int? parentId;
  String? description;
  int? age;
  String? type;
  String? gender;
  int? id;
  DoctorInfo? doctorInfo;

  factory Add_Appointment_Data.fromJson(Map<String, dynamic> json) => Add_Appointment_Data(
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    id: json["id"] == null ? null : json["id"],
    doctorInfo: json["doctor_info"] == null ? null : DoctorInfo.fromJson(json["doctor_info"]),
  );

  Map<String, dynamic> toJson() => {
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "patient_name": patientName == null ? null : patientName,
    "parent_id": parentId == null ? null : parentId,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
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



// // To parse this JSON data, do
// //
// //     final addAppointment = addAppointmentFromJson(jsonString);
//
// import 'dart:convert';
//
// AddAppointment addAppointmentFromJson(String str) => AddAppointment.fromJson(json.decode(str));
//
// String addAppointmentToJson(AddAppointment data) => json.encode(data.toJson());
//
// class AddAppointment {
//   AddAppointment({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   Add_Appointment_Data? data;
//
//   factory AddAppointment.fromJson(Map<String, dynamic> json) => AddAppointment(
//     status: json["status"] == null ? null : json["status"],
//     message: json["message"] == null ? null : json["message"],
//     data: json["data"] == null ? null : Add_Appointment_Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status == null ? null : status,
//     "message": message == null ? null : message,
//     "data": data == null ? null : data!.toJson(),
//   };
// }
//
// class Add_Appointment_Data {
//   Add_Appointment_Data({
//     this.patientId,
//     this.doctorId,
//     this.date,
//     this.day,
//     this.appointmentTime,
//     this.patientName,
//     this.description,
//     this.age,
//     this.type,
//     this.gender,
//     this.id,
//     this.doctorInfo,
//   });
//
//   int? patientId;
//   String? doctorId;
//   DateTime? date;
//   String? day;
//   String? appointmentTime;
//   String? patientName;
//   String? description;
//   int? age;
//   String? type;
//   String? gender;
//   int? id;
//   DoctorInfo? doctorInfo;
//
//   factory Add_Appointment_Data.fromJson(Map<String, dynamic> json) => Add_Appointment_Data(
//     patientId: json["patient_id"] == null ? null : json["patient_id"],
//     doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
//     date: json["date"] == null ? null : DateTime.parse(json["date"]),
//     day: json["day"] == null ? null : json["day"],
//     appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
//     patientName: json["patient_name"] == null ? null : json["patient_name"],
//     description: json["description"] == null ? null : json["description"],
//     age: json["age"] == null ? null : json["age"],
//     type: json["type"] == null ? null : json["type"],
//     gender: json["gender"] == null ? null : json["gender"],
//     id: json["id"] == null ? null : json["id"],
//     doctorInfo: json["doctor_info"] == null ? null : DoctorInfo.fromJson(json["doctor_info"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "patient_id": patientId == null ? null : patientId,
//     "doctor_id": doctorId == null ? null : doctorId,
//     "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//     "day": day == null ? null : day,
//     "appointment_time": appointmentTime == null ? null : appointmentTime,
//     "patient_name": patientName == null ? null : patientName,
//     "description": description == null ? null : description,
//     "age": age == null ? null : age,
//     "type": type == null ? null : type,
//     "gender": gender == null ? null : gender,
//     "id": id == null ? null : id,
//     "doctor_info": doctorInfo == null ? null : doctorInfo!.toJson(),
//   };
// }
//
// class DoctorInfo {
//   DoctorInfo({
//     this.name,
//     this.image,
//     this.specialist,
//     this.clinicAddress,
//   });
//
//   String? name;
//   dynamic image;
//   String? specialist;
//   String? clinicAddress;
//
//   factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
//     name: json["name"] == null ? null : json["name"],
//     image: json["image"],
//     specialist: json["specialist"] == null ? null : json["specialist"],
//     clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name == null ? null : name,
//     "image": image,
//     "specialist": specialist == null ? null : specialist,
//     "clinic_address": clinicAddress == null ? null : clinicAddress,
//   };
// }
