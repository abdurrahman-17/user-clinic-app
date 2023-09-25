// To parse this JSON data, do
//
//     final updatePatientProfileResponse = updatePatientProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdatePatientProfileResponse updatePatientProfileResponseFromJson(String str) => UpdatePatientProfileResponse.fromJson(json.decode(str));

String updatePatientProfileResponseToJson(UpdatePatientProfileResponse data) => json.encode(data.toJson());

class UpdatePatientProfileResponse {
  UpdatePatientProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory UpdatePatientProfileResponse.fromJson(Map<String, dynamic> json) => UpdatePatientProfileResponse(
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
    this.parent,
    this.report,
    this.apiToken,
    this.height,
    this.weight,
    this.temperature,
    this.heartBeat,
    this.bloodPressure,
    this.diabetes,
    this.sop,
    this.issue,
    this.notificationStatus,
    this.deviceType,
    this.androidToken,
    this.iosToken,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.status,
  });

  int? id;
  String? email;
  String? name;
  dynamic mobileNumber;
  String? image;
  String? gender;
  String? age;
  int? parent;
  dynamic report;
  String? apiToken;
  dynamic height;
  dynamic weight;
  dynamic temperature;
  dynamic heartBeat;
  dynamic bloodPressure;
  dynamic diabetes;
  dynamic sop;
  dynamic issue;
  int? notificationStatus;
  dynamic deviceType;
  dynamic androidToken;
  dynamic iosToken;
  String? address;
  String? city;
  String? state;
  int? zipCode;
  int? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    mobileNumber: json["mobile_number"],
    image: json["image"] == null ? null : json["image"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    parent: json["parent"] == null ? null : json["parent"],
    report: json["report"],
    apiToken: json["api_token"] == null ? null : json["api_token"],
    height: json["height"],
    weight: json["weight"],
    temperature: json["temperature"],
    heartBeat: json["heart_beat"],
    bloodPressure: json["blood_pressure"],
    diabetes: json["diabetes"],
    sop: json["sop"],
    issue: json["issue"],
    notificationStatus: json["notification_status"] == null ? null : json["notification_status"],
    deviceType: json["device_type"],
    androidToken: json["android_token"],
    iosToken: json["ios_token"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    zipCode: json["zip_code"] == null ? null : json["zip_code"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "mobile_number": mobileNumber,
    "image": image == null ? null : image,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "parent": parent == null ? null : parent,
    "report": report,
    "api_token": apiToken == null ? null : apiToken,
    "height": height,
    "weight": weight,
    "temperature": temperature,
    "heart_beat": heartBeat,
    "blood_pressure": bloodPressure,
    "diabetes": diabetes,
    "sop": sop,
    "issue": issue,
    "notification_status": notificationStatus == null ? null : notificationStatus,
    "device_type": deviceType,
    "android_token": androidToken,
    "ios_token": iosToken,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "zip_code": zipCode == null ? null : zipCode,
    "status": status == null ? null : status,
  };
}
