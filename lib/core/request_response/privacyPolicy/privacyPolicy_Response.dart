// To parse this JSON data, do
//
//     final privacyPolicy = privacyPolicyFromJson(jsonString);

import 'dart:convert';

PrivacyPolicy privacyPolicyFromJson(String str) => PrivacyPolicy.fromJson(json.decode(str));

String privacyPolicyToJson(PrivacyPolicy data) => json.encode(data.toJson());

class PrivacyPolicy {
  PrivacyPolicy({
    this.status,
    this.message,
    this.logo,
    this.privacyPolicyContent,
  });

  bool? status;
  String? message;
  Logo? logo;
  PrivacyPolicyContent? privacyPolicyContent;

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
    privacyPolicyContent: json["PrivacyPolicy_content"] == null ? null : PrivacyPolicyContent.fromJson(json["PrivacyPolicy_content"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "logo": logo == null ? null : logo!.toJson(),
    "PrivacyPolicy_content": privacyPolicyContent == null ? null : privacyPolicyContent!.toJson(),
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

class PrivacyPolicyContent {
  PrivacyPolicyContent({
    this.privacyPolicy,
  });

  String? privacyPolicy;

  factory PrivacyPolicyContent.fromJson(Map<String, dynamic> json) => PrivacyPolicyContent(
    privacyPolicy: json["Privacy_policy"] == null ? null : json["Privacy_policy"],
  );

  Map<String, dynamic> toJson() => {
    "Privacy_policy": privacyPolicy == null ? null : privacyPolicy,
  };
}
