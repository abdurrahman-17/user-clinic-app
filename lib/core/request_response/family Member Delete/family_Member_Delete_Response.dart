// To parse this JSON data, do
//
//     final deleteFamilyMember = deleteFamilyMemberFromJson(jsonString);

import 'dart:convert';

DeleteFamilyMember deleteFamilyMemberFromJson(String str) => DeleteFamilyMember.fromJson(json.decode(str));

String deleteFamilyMemberToJson(DeleteFamilyMember data) => json.encode(data.toJson());

class DeleteFamilyMember {
  DeleteFamilyMember({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DeleteFamilyMember.fromJson(Map<String, dynamic> json) => DeleteFamilyMember(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
