// To parse this JSON data, do
//
//     final errorRegisterModel = errorRegisterModelFromJson(jsonString);

import 'dart:convert';

ErrorRegisterModel errorRegisterModelFromJson(String str) =>
    ErrorRegisterModel.fromJson(json.decode(str));

String errorRegisterModelToJson(ErrorRegisterModel data) =>
    json.encode(data.toJson());

class ErrorRegisterModel {
  ErrorRegisterModel({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  factory ErrorRegisterModel.fromJson(Map<String, dynamic> json) =>
      ErrorRegisterModel(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors!.toJson(),
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
        email:json["email"]!=null? List<String>.from(json["email"].map((x) => x)):[],
        mobile:json["mobile"]!=null? List<String>.from(json["mobile"].map((x) => x)):[],
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email!.map((x) => x)),
        "mobile": List<dynamic>.from(mobile!.map((x) => x)),
      };
}
