class CartModel {
  int? code;
  bool? status;

  Body? body;

  CartModel({
    this.code,
    this.status,
    this.body,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Carts>? carts;
  String? total;

  Body({this.carts, this.total});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(Carts.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class Carts {
  int? id;
  var price;
  String? productId;
  String? productTitle;
  String? quantity;
  String? productImage;

  Carts(
      {this.id,
      this.price,
      this.productId,
      this.productTitle,
      this.quantity,
      this.productImage});

  Carts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    quantity = json['quantity'];
    productImage = json['product_image'];
  }
}
