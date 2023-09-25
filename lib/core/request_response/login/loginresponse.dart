// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.name,
    this.mobileNumber,
    this.image,
    this.gender,
    this.age,
    this.height,
    this.parent,
    this.report,
    this.apiToken,
    this.issue,
    this.notificationStatus,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.status,
    this.pinAuthentication,
  });

  int? id;
  String? email;
  String? name;
  int? mobileNumber;
  dynamic image;
  String? gender;
  int? age;
  dynamic height;
  int? parent;
  dynamic report;
  String? apiToken;
  dynamic issue;
  int? notificationStatus;
  String? address;
  String? city;
  String? state;
  int? zipCode;
  int? status;
  String? pinAuthentication;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    image: json["image"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    height: json["height"],
    parent: json["parent"] == null ? null : json["parent"],
    report: json["report"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    issue: json["issue"],
    notificationStatus: json["notification_status"] == null ? null : json["notification_status"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    zipCode: json["zip_code"] == null ? null : json["zip_code"],
    status: json["status"] == null ? null : json["status"],
    pinAuthentication: json["pin_authentication"] == null ? null : json["pin_authentication"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "image": image,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "height": height,
    "parent": parent == null ? null : parent,
    "report": report,
    "api_token": apiToken == null ? null : apiToken,
    "issue": issue,
    "notification_status": notificationStatus == null ? null : notificationStatus,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "zip_code": zipCode == null ? null : zipCode,
    "status": status == null ? null : status,
    "pin_authentication": pinAuthentication == null ? null : pinAuthentication,
  };
}
