// To parse this JSON data, do
//
//     final intoModel = intoModelFromJson(jsonString);

import 'dart:convert';

IntroModel intoModelFromJson(String str) => IntroModel.fromJson(json.decode(str));

class IntroModel {
  IntroModel({
    this.code,
    this.status,
    this.message,
    this.body,
    this.strings,
    this.info,
  });

  int? code;
  bool? status;
  String? message;
  Body? body;
  dynamic strings;
  String? info;

  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        strings: json["strings"],
        info: json["info"] == null ? null : json["info"],
      );
}

class Body {
  Body({
    this.intros,
  });

  List<Intro>? intros;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        intros: json["intros"] == null
            ? null
            : List<Intro>.from(json["intros"].map((x) => Intro.fromJson(x))),
      );
}

class Intro {
  Intro({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  int? id;
  String? title;
  String? description;
  String? image;

  factory Intro.fromJson(Map<String, dynamic> json) => Intro(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
      };
}
