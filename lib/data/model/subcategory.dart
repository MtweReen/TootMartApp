// ignore_for_file: prefer_typing_uninitialized_variables

class SubcategoryModel {
  int? code;
  bool? status;
  Body? body;


  SubcategoryModel(
      {this.code,
      this.status,
      this.body,
     });

  SubcategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    body = json['body'] != null ?  Body.fromJson(json['body']) : null;
  }
}

class Body {
  Category? category;
  List<SubCategories>? subCategories;
  List<Products>? products;

  Body(
      {
      this.category,
      this.subCategories,
      this.products});

  Body.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add( SubCategories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
  }
}

class Category {
  int? id;
  String? title;
  String? image;


  Category({this.id, this.title, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}

class SubCategories {
  int? id;
  String? title;
  String? image;
  List<Products>? products;

  SubCategories({this.id, this.title, this.image, this.products});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
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
  String? stock;
  String? image;

  Products(
      {this.id,
      this.price,
      this.priceBefore,
      this.title,
      this.stock,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    priceBefore = json['price_before'];
    title = json['title'];
    stock = json['stock'];
    image = json['image'];
  }
}