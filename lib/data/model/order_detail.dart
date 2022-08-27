class SingleOrderModel {
  int? code;
  bool? status;
  Body? body;

  SingleOrderModel({
    this.code,
    this.status,
    this.body,
  });

  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Products>? products;
  Order? order;
  Address? address;

  Body({this.products, this.order, this.address});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }
}

class Products {
  int? id;
  num? price;
  String? title;
  String? quantity;
  String? stock;
  String? image;

  Products(
      {this.id, this.price, this.title, this.quantity, this.stock, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    quantity = json['quantity'];
    stock = json['stock'];
    image = json['image'];
  }
}

class Order {
  int? id;
  String? orderNumber;
  String? date;
  int? discount;
  String? status;
  int? productsAmount;
  String? subTotal;
  String? total;
  String? refundable;

  Order(
      {this.id,
      this.orderNumber,
      this.date,
      this.discount,
      this.status,
      this.productsAmount,
      this.subTotal,
      this.total,
      this.refundable});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    date = json['date'];
    discount = json['discount'];
    status = json['status'];
    productsAmount = json['products_amount'];
    subTotal = json['subTotal'];
    total = json['total'];
    refundable = json['refundable'];
  }
}

class Address {
  int? id;
  String? address;
  Shipping? shipping;
  String? area;
  int? areaId;
  String? userId;

  Address(
      {this.id,
      this.address,
      this.shipping,
      this.area,
      this.areaId,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    area = json['area'];
    areaId = json['area_id'];
    userId = json['user_id'];
  }
}

class Shipping {
  int? id;
  String? area;
  String? price;
  String? from;
  String? to;

  Shipping({this.id, this.area, this.price, this.from, this.to});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    price = json['price'];
    from = json['from'];
    to = json['to'];
  }
}
