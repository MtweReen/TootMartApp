// To parse this JSON data, do
//
//     final intoModel = intoModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

IntroModel intoModelFromJson(String str) => IntroModel.fromJson(json.decode(str));

class IntroModel {
  IntroModel({
    this.code,
    this.status,
    this.body,

  });

  int? code;
  bool? status;
  Body? body;


  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        code: json["code"],
        status: json["status"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
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
