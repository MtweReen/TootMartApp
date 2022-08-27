// ignore_for_file: prefer_typing_uninitialized_variables

class FilterResultModel {
  int? code;
  bool? status;

  Body? body;

  FilterResultModel({
    this.code,
    this.status,
    this.body,
  });

  FilterResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Products>? products;

  Body({this.products});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class Products {
  int? id;
  var price;
  var priceBefore;
  String? title;
  String? image;

  Products({this.id, this.price, this.priceBefore, this.title, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    priceBefore = json['price_before'];
    title = json['title'];
    image = json['image'];
  }
}
