// To parse this JSON data, do
//
//     final doctorList = doctorListFromJson(jsonString);

import 'dart:convert';

DoctorList doctorListFromJson(String str) => DoctorList.fromJson(json.decode(str));

String doctorListToJson(DoctorList data) => json.encode(data.toJson());

class DoctorList {
  DoctorList({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<DoctorClass>? data;

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DoctorClass>.from(json["data"].map((x) => DoctorClass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DoctorClass {
  DoctorClass({
    this.id,
    this.name,
    this.degree,
    this.experience,
    this.patientAttend,
    this.specialist,
    this.type,
    this.image,
  });

  int? id;
  String? name;
  String? degree;
  int? experience;
  int? patientAttend;
  String? specialist;
  int? type;
  String? image;

  factory DoctorClass.fromJson(Map<String, dynamic> json) => DoctorClass(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    degree: json["degree"] == null ? null : json["degree"],
    experience: json["experience"] == null ? null : json["experience"],
    patientAttend: json["patient_attend"] == null ? null : json["patient_attend"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "degree": degree == null ? null : degree,
    "experience": experience == null ? null : experience,
    "patient_attend": patientAttend == null ? null : patientAttend,
    "specialist": specialist == null ? null : specialist,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
  };
}
