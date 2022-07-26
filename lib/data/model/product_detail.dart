class ProductDetailModel {
  int? code;
  bool? status;

  Body? body;

  ProductDetailModel({
    this.code,
    this.status,
    this.body,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  Products? products;

  Body({this.products});

  Body.fromJson(Map<String, dynamic> json) {
    products =
        json['products'] != null ? Products.fromJson(json['products']) : null;
  }
}

class Products {
  int? id;
  List<String>? images;
  String? title;
  String? stock;
  String? description;
  String? price;
  List<Similar>? similar;

  Products(
      {this.id,
      this.images,
      this.title,
      this.stock,
      this.description,
      this.price,
      this.similar});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'].cast<String>();
    title = json['title'];
    stock = json['stock'];
    description = json['description'];
    price = json['price'];
    if (json['similar'] != null) {
      similar = <Similar>[];
      json['similar'].forEach((v) {
        similar!.add(Similar.fromJson(v));
      });
    }
  }
}

class Similar {
  int? id;
  String? title;
  String? image;

  Similar({this.id, this.title, this.image});

  Similar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

 
}
