// To parse this JSON data, do
//
//     final myDoctorResponse = myDoctorResponseFromJson(jsonString);

import 'dart:convert';

MyDoctorResponse myDoctorResponseFromJson(String str) => MyDoctorResponse.fromJson(json.decode(str));

String myDoctorResponseToJson(MyDoctorResponse data) => json.encode(data.toJson());

class MyDoctorResponse {
  MyDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<mydoctordata>? data;

  factory MyDoctorResponse.fromJson(Map<String, dynamic> json) => MyDoctorResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<mydoctordata>.from(json["data"].map((x) => mydoctordata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class mydoctordata {
  mydoctordata({
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.specialist,
    this.type,
  });

  int? doctorId;
  String? doctorName;
  String? doctorImage;
  String? specialist;
  int? type;

  factory mydoctordata.fromJson(Map<String, dynamic> json) => mydoctordata(
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    doctorImage: json["doctor_image"] == null ? null : json["doctor_image"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId == null ? null : doctorId,
    "doctor_name": doctorName == null ? null : doctorName,
    "doctor_image": doctorImage == null ? null : doctorImage,
    "specialist": specialist == null ? null : specialist,
    "type": type == null ? null : type,
  };
}
