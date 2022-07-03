// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.data,
    this.error,
    this.errors,
    this.message,
  });

  Data? data;
  int? error;
  Errors? errors;
  String? message;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: Data.fromJson(json["data"]??{'':''}),
        error: json["error"],
        errors:json["errors"] != null? Errors.fromJson(json["errors"]):null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "error": error,
    "message": message,
      };
}

class Data {
  Data({
    this.user,
    this.token,
  });

  UserClass? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user:json["user"]!=null? UserClass.fromJson(json["user"]):null,
        token: json["token"]??'',
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
      };
}

class UserClass {
  UserClass({
    this.id,
    this.name,
    this.email,
    this.image,
    this.mobile,
  });

  int? id;
  String? name;
  String? email;
  String? image;
  String? mobile;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"]??0,
        name: json["name"]??'',
        email: json["email"]??'',
        image: json["image"]??'',
        mobile: json["mobile"]??'',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "mobile": mobile,
      };
}

class Errors {
  Errors({
    this.email,
    this.mobile,
  });

  List<String>? email;
  List<String>? mobile;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] != null
            ? List<String>.from(json["email"].map((x) => x))
            : null,
        mobile: json["mobile"] != null
            ? List<String>.from(json["mobile"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email!.map((x) => x)),
        "mobile": List<dynamic>.from(mobile!.map((x) => x)),
      };
}
