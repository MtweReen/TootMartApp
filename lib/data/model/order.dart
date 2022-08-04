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
  List<CompletedOrders>? ordersCompleted;

  Body({this.ordersUnderProcess, this.ordersCompleted});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['orders_under_process'] != null) {
      ordersUnderProcess = <OrdersUnderProcess>[];
      json['orders_under_process'].forEach((v) {
        ordersUnderProcess!.add(OrdersUnderProcess.fromJson(v));
      });
    }
    if (json['orders_completed'] != null) {
      ordersCompleted = <CompletedOrders>[];
      json['orders_completed'].forEach((v) {
        ordersCompleted!.add(CompletedOrders.fromJson(v));
      });
    }
  }
}

class OrdersUnderProcess {
  int? id;
  String? orderNumber;
  String? date;
  String? subTotal;
  String? total;

  OrdersUnderProcess(
      {this.id, this.orderNumber, this.date, this.subTotal, this.total});

  OrdersUnderProcess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    date = json['date'];
    subTotal = json['subTotal'];
    total = json['total'];
  }
}

class CompletedOrders {
  int? id;
  String? orderNumber;
  String? date;
  String? subTotal;
  String? total;

  CompletedOrders(
      {this.id, this.orderNumber, this.date, this.subTotal, this.total});

  CompletedOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    date = json['date'];
    subTotal = json['subTotal'];
    total = json['total'];
  }
}
