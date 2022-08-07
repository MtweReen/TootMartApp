class SingleOrderModel {
  int? code;
  bool? status;
  Body? body;
 

  SingleOrderModel(
      {this.code,
      this.status,
      
      this.body,
    });

  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
   
    body = json['body'] != null ?  Body.fromJson(json['body']) : null;
   
  }

}

class Body {
  List<Products>? products;
  Order? order;

  Body({this.products, this.order});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
    order = json['order'] != null ?  Order.fromJson(json['order']) : null;
  }

}

class Products {
  int? id;
  var price;
  String? title;
  String? image;

  Products({this.id, this.price, this.title, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    image = json['image'];
  }


}

class Order {
  int? id;
  String? orderNumber;
  String? date;
  String? subTotal;
  String? total;

  Order(
      {this.id,
      this.orderNumber,
      this.date,
      this.subTotal,
      this.total});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    date = json['date'];
    subTotal = json['subTotal'];
    total = json['total'];
  }

}