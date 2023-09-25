// To parse this JSON data, do
//
//     final doctorProfile = doctorProfileFromJson(jsonString);

import 'dart:convert';

DoctorProfile doctorProfileFromJson(String str) => DoctorProfile.fromJson(json.decode(str));

String doctorProfileToJson(DoctorProfile data) => json.encode(data.toJson());

class DoctorProfile {
  DoctorProfile({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
  };
}
