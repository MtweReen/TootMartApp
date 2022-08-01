// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.code,
    this.status,

    this.body,

  });

  int? code;
  bool? status;
  Body? body;


  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    code: json["code"],
    status: json["status"],

    body: Body.fromJson(json["body"]),

  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,

    "body": body!.toJson(),

  };
}

class Body {
  Body({
    this.carts,
    this.total,
  });

  List<Cart>? carts;
  String? total;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "carts": List<dynamic>.from(carts!.map((x) => x.toJson())),
    "total": total,
  };
}

class Cart {
  Cart({
    this.id,
    this.price,
    this.productId,
    this.productTitle,
    this.quantity,
    this.productImage,
  });

  int? id;
  double? price;
  String? productId;
  String? productTitle;
  String? quantity;
  String? productImage;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    price: json["price"].toDouble(),
    productId: json["product_id"],
    productTitle: json["product_title"],
    quantity: json["quantity"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "product_id": productId,
    "product_title": productTitle,
    "quantity": quantity,
    "product_image": productImage,
  };
}
