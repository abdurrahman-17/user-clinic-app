// To parse this JSON data, do
//
//     final termsAndConditions = termsAndConditionsFromJson(jsonString);

import 'dart:convert';

TermsAndConditions termsAndConditionsFromJson(String str) => TermsAndConditions.fromJson(json.decode(str));

String termsAndConditionsToJson(TermsAndConditions data) => json.encode(data.toJson());

class TermsAndConditions {
  TermsAndConditions({
    this.status,
    this.message,
    this.data,
    this.logo,
    this.termsConditionContent,
    this.date,
  });

  bool? status;
  String? message;
  TermsConditionContent? data;
  Logo? logo;
  TermsConditionContent? termsConditionContent;
  Date? date;

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) => TermsAndConditions(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : TermsConditionContent.fromJson(json["data"]),
    logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
    termsConditionContent: json["TermsCondition_content"] == null ? null : TermsConditionContent.fromJson(json["TermsCondition_content"]),
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "logo": logo == null ? null : logo!.toJson(),
    "TermsCondition_content": termsConditionContent == null ? null : termsConditionContent!.toJson(),
    "date": date == null ? null : date!.toJson(),
  };
}

class TermsConditionContent {
  TermsConditionContent({
    this.termsCondition,
  });

  String? termsCondition;

  factory TermsConditionContent.fromJson(Map<String, dynamic> json) => TermsConditionContent(
    termsCondition: json["terms_condition"] == null ? null : json["terms_condition"],
  );

  Map<String, dynamic> toJson() => {
    "terms_condition": termsCondition == null ? null : termsCondition,
  };
}

class Date {
  Date({
    this.updateDate,
  });

  DateTime? updateDate;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    updateDate: json["update_date"] == null ? null : DateTime.parse(json["update_date"]),
  );

  Map<String, dynamic> toJson() => {
    "update_date": updateDate == null ? null : "${updateDate!.year.toString().padLeft(4, '0')}-${updateDate!.month.toString().padLeft(2, '0')}-${updateDate!.day.toString().padLeft(2, '0')}",
  };
}

class Logo {
  Logo({
    this.image,
  });

  String? image;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
  };
}
