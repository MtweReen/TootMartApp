// ignore_for_file: prefer_typing_uninitialized_variables

class OrderModel {
  int? code;
  bool? status;
  Body? body;

  OrderModel({
    this.code,
    this.status,
    this.body,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<OrdersUnderProcess>? ordersUnderProcess;
  List<OrdersCompleted>? ordersCompleted;

  Body({this.ordersUnderProcess, this.ordersCompleted});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['orders_under_process'] != null) {
      ordersUnderProcess = <OrdersUnderProcess>[];
      json['orders_under_process'].forEach((v) {
        ordersUnderProcess!.add(OrdersUnderProcess.fromJson(v));
      });
    }
    if (json['orders_completed'] != null) {
      ordersCompleted = <OrdersCompleted>[];
      json['orders_completed'].forEach((v) {
        ordersCompleted!.add(OrdersCompleted.fromJson(v));
      });
    }
  }
}

class OrdersUnderProcess {
  int? id;
  String? orderNumber;
  String? date;
  var discount;
  String? status;
  int? productsAmount;
  String? subTotal;
  String? total;
  String? refundable;

  OrdersUnderProcess(
      {this.id,
      this.orderNumber,
      this.date,
      this.discount,
      this.status,
      this.productsAmount,
      this.subTotal,
      this.total,
      this.refundable});

  OrdersUnderProcess.fromJson(Map<String, dynamic> json) {
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

class OrdersCompleted {
  int? id;
  String? orderNumber;
  String? date;
  var discount;
  String? status;
  int? productsAmount;
  String? subTotal;
  String? total;
  String? refundable;

  OrdersCompleted(
      {this.id,
      this.orderNumber,
      this.date,
      this.discount,
      this.status,
      this.productsAmount,
      this.subTotal,
      this.total,
      this.refundable});

  OrdersCompleted.fromJson(Map<String, dynamic> json) {
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
