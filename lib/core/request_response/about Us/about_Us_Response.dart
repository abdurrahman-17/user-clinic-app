// To parse this JSON data, do
//
//     final aboutUs = aboutUsFromJson(jsonString);

import 'dart:convert';

AboutUs aboutUsFromJson(String str) => AboutUs.fromJson(json.decode(str));

String aboutUsToJson(AboutUs data) => json.encode(data.toJson());

class AboutUs {
  AboutUs({
    this.status,
    this.message,
    this.logo,
    this.aboutUsContent,
  });

  bool? status;
  String? message;
  Logo? logo;
  AboutUsContent? aboutUsContent;

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
    aboutUsContent: json["AboutUS_content"] == null ? null : AboutUsContent.fromJson(json["AboutUS_content"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "logo": logo == null ? null : logo!.toJson(),
    "AboutUS_content": aboutUsContent == null ? null : aboutUsContent!.toJson(),
  };
}

class AboutUsContent {
  AboutUsContent({
    this.aboutUs,
  });

  String? aboutUs;

  factory AboutUsContent.fromJson(Map<String, dynamic> json) => AboutUsContent(
    aboutUs: json["About_us"] == null ? null : json["About_us"],
  );

  Map<String, dynamic> toJson() => {
    "About_us": aboutUs == null ? null : aboutUs,
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
