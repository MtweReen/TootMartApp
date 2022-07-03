// To parse this JSON data, do
//
//     final favouritesModel = favouritesModelFromJson(jsonString);

import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) => FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) => json.encode(data.toJson());

class FavouritesModel {
  FavouritesModel({
    this.data,
    this.error,
    this.message,
  });

  List<Datum>? data;
  int? error;
  String? message;

  factory FavouritesModel.fromJson(Map<String, dynamic> json) => FavouritesModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "error": error,
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.price,
    this.discount,
    this.finalPrice,
    this.imagePath,
  });

  int? id;
  String? name;
  String? price;
  String? discount;
  int? finalPrice;
  String? imagePath;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    discount: json["discount"],
    finalPrice: json["final_price"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "discount": discount,
    "final_price": finalPrice,
    "image_path": imagePath,
  };
}
