class RoomModel {
  int? code;
  bool? status;

  Body? body;

  RoomModel({
    this.code,
    this.status,
    this.body,
  });

  RoomModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Areas>? areas;
  List<Showrooms>? showrooms;

  Body({this.areas, this.showrooms});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
    if (json['showrooms'] != null) {
      showrooms = <Showrooms>[];
      json['showrooms'].forEach((v) {
        showrooms!.add(Showrooms.fromJson(v));
      });
    }
  }
}

class Areas {
  int? id;
  String? title;
  String? flag;

  Areas({this.id, this.title, this.flag});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    flag = json['flag'];
  }
}

class Showrooms {
  int? id;
  String? area;
  String? address;
  String? lat;
  String? lng;
  String? startHour;
  String? endHour;
  String? startDate;
  String? endDate;

  Showrooms(
      {this.id,
      this.area,
      this.address,
      this.lat,
      this.lng,
      this.startHour,
      this.endHour,
      this.startDate,
      this.endDate});

  Showrooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    startHour = json['start_hour'];
    endHour = json['end_hour'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
}
