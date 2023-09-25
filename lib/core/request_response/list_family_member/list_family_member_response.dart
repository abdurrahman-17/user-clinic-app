// To parse this JSON data, do
//
//     final familyMemberResponse = familyMemberResponseFromJson(jsonString);

import 'dart:convert';

FamilyMemberResponse familyMemberResponseFromJson(String str) => FamilyMemberResponse.fromJson(json.decode(str));

String familyMemberResponseToJson(FamilyMemberResponse data) => json.encode(data.toJson());

class FamilyMemberResponse {
  FamilyMemberResponse({
    this.status,
    this.parentDetails,
    this.message,
    this.data,
  });

  bool? status;
  ParentDetails? parentDetails;
  String? message;
  List<list_family>? data;

  factory FamilyMemberResponse.fromJson(Map<String, dynamic> json) => FamilyMemberResponse(
    status: json["status"] == null ? null : json["status"],
    parentDetails: json["parent_details"] == null ? null : ParentDetails.fromJson(json["parent_details"]),
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<list_family>.from(json["data"].map((x) => list_family.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "parent_details": parentDetails == null ? null : parentDetails!.toJson(),
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class list_family {
  list_family({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.image,
  });

  int? id;
  String? name;
  int? age;
  String? gender;
  String? image;

  factory list_family.fromJson(Map<String, dynamic> json) => list_family(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "image": image == null ? null : image,
  };
}



class ParentDetails {
  ParentDetails({
    this.headOfTheFamily,
    this.age,
    this.image,
  });

  String? headOfTheFamily;
  int? age;
  String? image;

  factory ParentDetails.fromJson(Map<String, dynamic> json) => ParentDetails(
    headOfTheFamily: json["Head of the family"] == null ? null : json["Head of the family"],
    age: json["age"] == null ? null : json["age"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "Head of the family": headOfTheFamily == null ? null : headOfTheFamily,
    "age": age == null ? null : age,
    "image": image == null ? null : image,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
