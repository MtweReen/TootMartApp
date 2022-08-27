class AreaFilterResult {
  int? code;
  bool? status;

  Body? body;

  AreaFilterResult({
    this.code,
    this.status,
    this.body,
  });

  AreaFilterResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Showrooms>? showrooms;

  Body({this.showrooms});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['showrooms'] != null) {
      showrooms = <Showrooms>[];
      json['showrooms'].forEach((v) {
        showrooms!.add(Showrooms.fromJson(v));
      });
    }
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
