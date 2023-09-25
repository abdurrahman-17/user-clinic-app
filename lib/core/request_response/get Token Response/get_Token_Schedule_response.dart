// To parse this JSON data, do
//
//     final getDoctorScheduleToken = getDoctorScheduleTokenFromJson(jsonString);

import 'dart:convert';

GetDoctorScheduleToken getDoctorScheduleTokenFromJson(String str) => GetDoctorScheduleToken.fromJson(json.decode(str));

String getDoctorScheduleTokenToJson(GetDoctorScheduleToken data) => json.encode(data.toJson());

class GetDoctorScheduleToken {
  GetDoctorScheduleToken({
    this.status,
    this.message,
    this.data,
    this.familyMembers,
  });

  bool? status;
  String? message;
  List<add_Token_Appointment_Data>? data;
  List<FamilyMember>? familyMembers;

  factory GetDoctorScheduleToken.fromJson(Map<String, dynamic> json) => GetDoctorScheduleToken(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<add_Token_Appointment_Data>.from(json["data"].map((x) => add_Token_Appointment_Data.fromJson(x))),
    familyMembers: json["family_members"] == null ? null : List<FamilyMember>.from(json["family_members"].map((x) => FamilyMember.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "family_members": familyMembers == null ? null : List<dynamic>.from(familyMembers!.map((x) => x.toJson())),
  };
}

class add_Token_Appointment_Data {
  add_Token_Appointment_Data({
    this.id,
    this.doctorId,
    this.scheduleName,
    this.days,
    this.fromSession,
    this.availableTokenTime,
    this.tokenTime,
  });

  int? id;
  int? doctorId;
  String? scheduleName;
  String? days;
  String? fromSession;
  String? availableTokenTime;
  List<String>? tokenTime;

  factory add_Token_Appointment_Data.fromJson(Map<String, dynamic> json) => add_Token_Appointment_Data(
    id: json["id"] == null ? null : json["id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    days: json["days"] == null ? null : json["days"],
    fromSession: json["from_session"] == null ? null : json["from_session"],
    availableTokenTime: json["available_token_time"] == null ? null : json["available_token_time"],
    tokenTime: json["token_time"] == null ? null : List<String>.from(json["token_time"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "doctor_id": doctorId == null ? null : doctorId,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "days": days == null ? null : days,
    "from_session": fromSession == null ? null : fromSession,
    "available_token_time": availableTokenTime == null ? null : availableTokenTime,
    "token_time": tokenTime == null ? null : List<dynamic>.from(tokenTime!.map((x) => x)),
  };
}

class FamilyMember {
  FamilyMember({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
