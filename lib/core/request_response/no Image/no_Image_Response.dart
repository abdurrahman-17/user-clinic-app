// To parse this JSON data, do
//
//     final noImage = noImageFromJson(jsonString);

import 'dart:convert';

NoImage noImageFromJson(String str) => NoImage.fromJson(json.decode(str));

String noImageToJson(NoImage data) => json.encode(data.toJson());

class NoImage {
  NoImage({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  String? data;

  factory NoImage.fromJson(Map<String, dynamic> json) => NoImage(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
