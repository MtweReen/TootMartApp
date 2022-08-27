class AreasModel {
  int? code;
  bool? status;

  Body? body;

  AreasModel({
    this.code,
    this.status,
    this.body,
  });

  AreasModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Areas>? areas;

  Body({this.areas});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
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
