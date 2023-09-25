// To parse this JSON data, do
//
//     final getdoctorByid = getdoctorByidFromJson(jsonString);

import 'dart:convert';

GetdoctorByid getdoctorByidFromJson(String str) => GetdoctorByid.fromJson(json.decode(str));

String getdoctorByidToJson(GetdoctorByid data) => json.encode(data.toJson());

class GetdoctorByid {
  GetdoctorByid({
    this.status,
    this.message,
    this.data,
    this.doctorAvailable,
  });

  bool? status;
  String? message;
  List<No_of_appo>? data;
  DoctorAvailable? doctorAvailable;

  factory GetdoctorByid.fromJson(Map<String, dynamic> json) => GetdoctorByid(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<No_of_appo>.from(json["data"].map((x) => No_of_appo.fromJson(x))),
    doctorAvailable: json["doctor_available"] == null ? null : DoctorAvailable.fromJson(json["doctor_available"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "doctor_available": doctorAvailable == null ? null : doctorAvailable!.toJson(),
  };
}

class No_of_appo {
  No_of_appo({
    this.id,
    this.name,
    this.type,
    this.degree,
    this.experience,
    this.specialist,
    this.patientAttend,
    this.image,
    this.phone,
    this.about,
    this.clinicAddress,
  });

  int? id;
  String? name;
  int? type;
  String? degree;
  int? experience;
  String? specialist;
  int? patientAttend;
  String? image;
  String? phone;
  String? about;
  String? clinicAddress;

  factory No_of_appo.fromJson(Map<String, dynamic> json) => No_of_appo(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    degree: json["degree"] == null ? null : json["degree"],
    experience: json["experience"] == null ? null : json["experience"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    patientAttend: json["patient_attend"] == null ? null : json["patient_attend"],
    image: json["image"] == null ? null : json["image"],
    phone: json["phone"] == null ? null : json["phone"],
    about: json["about"] == null ? null : json["about"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "degree": degree == null ? null : degree,
    "experience": experience == null ? null : experience,
    "specialist": specialist == null ? null : specialist,
    "patient_attend": patientAttend == null ? null : patientAttend,
    "image": image == null ? null : image,
    "phone": phone == null ? null : phone,
    "about": about == null ? null : about,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
  };
}

class DoctorAvailable {
  DoctorAvailable({
    this.days,
    this.fromTime,
    this.toTime,
  });

  String? days;
  String? fromTime;
  String? toTime;

  factory DoctorAvailable.fromJson(Map<String, dynamic> json) => DoctorAvailable(
    days: json["days"] == null ? null : json["days"],
    fromTime: json["from_time"] == null ? null : json["from_time"],
    toTime: json["to_time"] == null ? null : json["to_time"],
  );

  Map<String, dynamic> toJson() => {
    "days": days == null ? null : days,
    "from_time": fromTime == null ? null : fromTime,
    "to_time": toTime == null ? null : toTime,
  };
}


// // To parse this JSON data, do
// //
// //     final drprofile = drprofileFromJson(jsonString);
//
// import 'dart:convert';
//
// GetdoctorByid drprofileFromJson(String str) => GetdoctorByid.fromJson(json.decode(str));
//
// String drprofileToJson(GetdoctorByid data) => json.encode(data.toJson());
//
// class GetdoctorByid {
//   GetdoctorByid({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   List<No_of_appo>? data;
//
//   factory GetdoctorByid.fromJson(Map<String, dynamic> json) => GetdoctorByid(
//     status: json["status"] == null ? null : json["status"],
//     message: json["message"] == null ? null : json["message"],
//     data: json["data"] == null ? null : List<No_of_appo>.from(json["data"].map((x) => No_of_appo.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status == null ? null : status,
//     "message": message == null ? null : message,
//     "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class No_of_appo {
//   No_of_appo({
//     this.id,
//     this.name,
//     this.type,
//     this.degree,
//     this.experience,
//     this.specialist,
//     this.patientAttend,
//     this.image,
//     this.phone,
//     this.about,
//   });
//
//   int? id;
//   String? name;
//   int? type;
//   String? degree;
//   int? experience;
//   String? specialist;
//   int? patientAttend;
//   String? image;
//   String? phone;
//   String? about;
//
//   factory No_of_appo.fromJson(Map<String, dynamic> json) => No_of_appo(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"] == null ? null : json["name"],
//     type: json["type"] == null ? null : json["type"],
//     degree: json["degree"] == null ? null : json["degree"],
//     experience: json["experience"] == null ? null : json["experience"],
//     specialist: json["specialist"] == null ? null : json["specialist"],
//     patientAttend: json["patient_attend"] == null ? null : json["patient_attend"],
//     image: json["image"] == null ? null : json["image"],
//     phone: json["phone"] == null ? null : json["phone"],
//     about: json["about"] == null ? null : json["about"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "name": name == null ? null : name,
//     "type": type == null ? null : type,
//     "degree": degree == null ? null : degree,
//     "experience": experience == null ? null : experience,
//     "specialist": specialist == null ? null : specialist,
//     "patient_attend": patientAttend == null ? null : patientAttend,
//     "image": image == null ? null : image,
//     "phone": phone == null ? null : phone,
//     "about": about == null ? null : about,
//   };
// }
