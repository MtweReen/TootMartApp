class UserAddressModel {
  int? code;
  bool? status;
  Body? body;

  UserAddressModel({
    this.code,
    this.status,
    this.body,
  });

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<UserAddress>? userAddress;

  Body({this.userAddress});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['user_address'] != null) {
      userAddress = <UserAddress>[];
      json['user_address'].forEach((v) {
        userAddress!.add(UserAddress.fromJson(v));
      });
    }
  }
}

class UserAddress {
  int? id;
  String? address;
  Shipping? shipping;
  String? area;
  int? areaId;
  String? userId;

  UserAddress(
      {this.id,
      this.address,
      this.shipping,
      this.area,
      this.areaId,
      this.userId});

  UserAddress.fromJson(Map<String, dynamic> json) {
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
